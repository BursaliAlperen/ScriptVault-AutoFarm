import "dotenv/config";
import express from "express";
import Database from "better-sqlite3";
import crypto from "node:crypto";
import fs from "node:fs";
import path from "node:path";

const app=express();
app.use(express.json({limit:"16kb"}));
const port=Number(process.env.PORT||3000);
const dbPath=path.resolve(process.env.DATABASE_PATH||"./data/scriptvault.db");
fs.mkdirSync(path.dirname(dbPath),{recursive:true});
const db=new Database(dbPath);
db.pragma("journal_mode = WAL");
db.exec("CREATE TABLE IF NOT EXISTS keys (id INTEGER PRIMARY KEY AUTOINCREMENT,key_hash TEXT NOT NULL UNIQUE,user_id TEXT,created_at INTEGER NOT NULL,expires_at INTEGER NOT NULL,linkvertise_verified INTEGER NOT NULL DEFAULT 0,revoked INTEGER NOT NULL DEFAULT 0)");

const hashKey=k=>crypto.createHash("sha256").update(k).digest("hex");
const generateKey=()=>{const r=crypto.randomBytes(12).toString("hex").toUpperCase();return "SV-"+r.slice(0,4)+"-"+r.slice(4,8)+"-"+r.slice(8,12)};
const clean=v=>typeof v==="string"?v.trim():"";
const admin=(req,res,next)=>{if(!process.env.ADMIN_TOKEN||req.get("x-admin-token")!==process.env.ADMIN_TOKEN)return res.status(401).json({success:false,message:"Unauthorized."});next()};

app.get("/health",(req,res)=>res.json({success:true,service:"scriptvault-key-backend"}));

app.post("/api/unlock",async(req,res)=>{
  const hash=clean(req.body?.hash), userId=clean(req.body?.userId), token=process.env.LINKVERTISE_AUTH_TOKEN;
  if(!hash)return res.status(400).json({success:false,message:"Missing hash."});
  if(!token)return res.status(503).json({success:false,message:"Linkvertise verification is not configured."});
  try{
    const u=new URL(process.env.LINKVERTISE_API_URL||"https://publisher.linkvertise.com/api/v1/anti_bypassing");
    u.searchParams.set("token",token);u.searchParams.set("hash",hash);
    const rr=await fetch(u,{method:"POST",headers:{Accept:"application/json"}});
    if(!rr.ok)return res.status(502).json({success:false,message:"Unlock verification failed."});
    const body=await rr.text();let verified=false;
    try{const j=JSON.parse(body);verified=j?.success===true||j?.verified===true||j?.valid===true}catch{verified=/true|valid|success/i.test(body)}
    if(!verified)return res.status(403).json({success:false,message:"Unlock was not verified."});
    const key=generateKey(),now=Date.now(),expires=now+Number(process.env.KEY_TTL_HOURS||24)*3600000;
    db.prepare("INSERT INTO keys(key_hash,user_id,created_at,expires_at,linkvertise_verified) VALUES(?,?,?,?,1)").run(hashKey(key),userId||null,now,expires);
    res.json({success:true,key,expiresAt:new Date(expires).toISOString()});
  }catch{res.status(502).json({success:false,message:"Unlock verification request failed."})}
});

app.post("/api/verify",(req,res)=>{
  const key=clean(req.body?.key),userId=clean(req.body?.userId);
  if(!key||!userId)return res.status(400).json({success:false,message:"Missing key or userId."});
  const row=db.prepare("SELECT * FROM keys WHERE key_hash=?").get(hashKey(key));
  if(!row)return res.status(403).json({success:false,message:"Invalid key."});
  if(row.revoked)return res.status(403).json({success:false,message:"Key revoked."});
  if(Date.now()>=row.expires_at)return res.status(403).json({success:false,message:"Key expired."});
  if(row.user_id&&row.user_id!==userId)return res.status(403).json({success:false,message:"Key is bound to another user."});
  if(!row.linkvertise_verified)return res.status(403).json({success:false,message:"Unlock verification missing."});
  res.json({success:true,message:"Key accepted.",expiresAt:new Date(row.expires_at).toISOString()});
});

app.post("/api/admin/create-key",admin,(req,res)=>{
  const userId=clean(req.body?.userId),hours=Math.min(Math.max(Number(req.body?.hours||24),1),8760);
  const key=generateKey(),now=Date.now(),expires=now+hours*3600000;
  db.prepare("INSERT INTO keys(key_hash,user_id,created_at,expires_at,linkvertise_verified) VALUES(?,?,?,?,1)").run(hashKey(key),userId||null,now,expires);
  res.json({success:true,key,expiresAt:new Date(expires).toISOString()});
});

app.post("/api/admin/revoke",admin,(req,res)=>{
  const key=clean(req.body?.key);
  if(!key)return res.status(400).json({success:false,message:"Missing key."});
  const r=db.prepare("UPDATE keys SET revoked=1 WHERE key_hash=?").run(hashKey(key));
  res.json({success:r.changes>0,message:r.changes>0?"Key revoked.":"Key not found."});
});

app.listen(port,()=>console.log("ScriptVault key backend listening on "+port));
