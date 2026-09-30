import "dotenv/config";
import express from "express";
import Database from "better-sqlite3";
import crypto from "node:crypto";
import fs from "node:fs";
import path from "node:path";

const app = express();
app.use(express.json({ limit: "16kb" }));

const port = Number(process.env.PORT || 3000);
const dbPath = path.resolve(process.env.DATABASE_PATH || "./data/scriptvault.db");
fs.mkdirSync(path.dirname(dbPath), { recursive: true });

const db = new Database(dbPath);
db.pragma("journal_mode = WAL");

db.exec(`
  CREATE TABLE IF NOT EXISTS keys (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    key_hash TEXT NOT NULL UNIQUE,
    user_id TEXT,
    farm_id TEXT,
    created_at INTEGER NOT NULL,
    expires_at INTEGER NOT NULL,
    linkvertise_verified INTEGER NOT NULL DEFAULT 0,
    revoked INTEGER NOT NULL DEFAULT 0
  )
`);

const columns = db.prepare("PRAGMA table_info(keys)").all();
if (!columns.some(c => c.name === "farm_id")) {
  db.exec("ALTER TABLE keys ADD COLUMN farm_id TEXT");
}

const hashKey = key => crypto.createHash("sha256").update(key).digest("hex");
const generateKey = () => {
  const r = crypto.randomBytes(12).toString("hex").toUpperCase();
  return "SV-" + r.slice(0, 4) + "-" + r.slice(4, 8) + "-" + r.slice(8, 12);
};
const clean = value => typeof value === "string" ? value.trim() : "";

function getFarmLinks() {
  try {
    const parsed = JSON.parse(process.env.FARM_LINKS_JSON || "{}");
    return parsed && typeof parsed === "object" ? parsed : {};
  } catch {
    return {};
  }
}

const admin = (req, res, next) => {
  if (!process.env.ADMIN_TOKEN || req.get("x-admin-token") !== process.env.ADMIN_TOKEN) {
    return res.status(401).json({ success: false, message: "Unauthorized." });
  }
  next();
};

app.get("/health", (req, res) => {
  res.json({ success: true, service: "scriptvault-key-backend" });
});

// Returns the Linkvertise Target-Link configured for a farm.
// Link creation itself is done in the Linkvertise publisher dashboard.
app.get("/api/farms/:farmId/link", (req, res) => {
  const farmId = clean(req.params.farmId);
  const link = getFarmLinks()[farmId];

  if (!farmId || !link) {
    return res.status(404).json({ success: false, message: "Farm Linkvertise link not configured." });
  }

  try {
    new URL(link);
  } catch {
    return res.status(500).json({ success: false, message: "Configured farm link is invalid." });
  }

  res.json({ success: true, farmId, link });
});

app.post("/api/unlock", async (req, res) => {
  const hash = clean(req.body?.hash);
  const userId = clean(req.body?.userId);
  const farmId = clean(req.body?.farmId);
  const token = process.env.LINKVERTISE_AUTH_TOKEN;

  if (!hash || !farmId) {
    return res.status(400).json({ success: false, message: "Missing hash or farmId." });
  }
  if (!token) {
    return res.status(503).json({ success: false, message: "Linkvertise verification is not configured." });
  }

  try {
    const u = new URL(
      process.env.LINKVERTISE_API_URL ||
      "https://publisher.linkvertise.com/api/v1/anti_bypassing"
    );
    u.searchParams.set("token", token);
    u.searchParams.set("hash", hash);

    const rr = await fetch(u, {
      method: "POST",
      headers: { Accept: "application/json" }
    });

    if (!rr.ok) {
      return res.status(502).json({ success: false, message: "Unlock verification failed." });
    }

    const body = await rr.text();
    let verified = false;
    try {
      const json = JSON.parse(body);
      verified = json?.success === true || json?.verified === true || json?.valid === true;
    } catch {
      verified = /true|valid|success/i.test(body);
    }

    if (!verified) {
      return res.status(403).json({ success: false, message: "Unlock was not verified." });
    }

    const key = generateKey();
    const now = Date.now();
    const expires = now + Number(process.env.KEY_TTL_HOURS || 24) * 3600000;

    db.prepare(
      "INSERT INTO keys(key_hash,user_id,farm_id,created_at,expires_at,linkvertise_verified) VALUES(?,?,?,?,?,1)"
    ).run(hashKey(key), userId || null, farmId, now, expires);

    res.json({
      success: true,
      key,
      farmId,
      expiresAt: new Date(expires).toISOString()
    });
  } catch {
    res.status(502).json({ success: false, message: "Unlock verification request failed." });
  }
});

app.post("/api/verify", (req, res) => {
  const key = clean(req.body?.key);
  const userId = clean(req.body?.userId);
  const farmId = clean(req.body?.farmId);

  if (!key || !userId || !farmId) {
    return res.status(400).json({ success: false, message: "Missing key, userId or farmId." });
  }

  const row = db.prepare("SELECT * FROM keys WHERE key_hash=?").get(hashKey(key));

  if (!row) return res.status(403).json({ success: false, message: "Invalid key." });
  if (row.revoked) return res.status(403).json({ success: false, message: "Key revoked." });
  if (Date.now() >= row.expires_at) return res.status(403).json({ success: false, message: "Key expired." });
  if (row.user_id && row.user_id !== userId) return res.status(403).json({ success: false, message: "Key is bound to another user." });
  if (row.farm_id && row.farm_id !== farmId) return res.status(403).json({ success: false, message: "Key is bound to another auto-farm." });
  if (!row.linkvertise_verified) return res.status(403).json({ success: false, message: "Unlock verification missing." });

  res.json({
    success: true,
    message: "Key accepted.",
    farmId: row.farm_id,
    expiresAt: new Date(row.expires_at).toISOString()
  });
});

app.post("/api/admin/create-key", admin, (req, res) => {
  const userId = clean(req.body?.userId);
  const farmId = clean(req.body?.farmId);
  const hours = Math.min(Math.max(Number(req.body?.hours || 24), 1), 8760);

  if (!farmId) {
    return res.status(400).json({ success: false, message: "Missing farmId." });
  }

  const key = generateKey();
  const now = Date.now();
  const expires = now + hours * 3600000;

  db.prepare(
    "INSERT INTO keys(key_hash,user_id,farm_id,created_at,expires_at,linkvertise_verified) VALUES(?,?,?,?,?,1)"
  ).run(hashKey(key), userId || null, farmId, now, expires);

  res.json({
    success: true,
    key,
    farmId,
    expiresAt: new Date(expires).toISOString()
  });
});

app.post("/api/admin/revoke", admin, (req, res) => {
  const key = clean(req.body?.key);
  if (!key) return res.status(400).json({ success: false, message: "Missing key." });

  const r = db.prepare("UPDATE keys SET revoked=1 WHERE key_hash=?").run(hashKey(key));
  res.json({
    success: r.changes > 0,
    message: r.changes > 0 ? "Key revoked." : "Key not found."
  });
});

app.listen(port, () => {
  console.log("ScriptVault key backend listening on " + port);
});
