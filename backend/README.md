# ScriptVault Key Backend

Server-side key service for ScriptVault.

Endpoints:
- POST /api/unlock
- POST /api/verify
- POST /api/admin/create-key
- POST /api/admin/revoke
- GET /health

Secrets stay server-side in environment variables. Keys are stored as SHA-256 hashes.

Run:
1. npm install
2. copy .env.example to .env
3. configure LINKVERTISE_AUTH_TOKEN and ADMIN_TOKEN
4. npm start
