# Database setup (PostgreSQL)

This folder contains helper scripts to prepare a PostgreSQL database for the project.

Steps
1. Install PostgreSQL
   - Windows: https://www.postgresql.org/download/windows/
   - macOS: use Homebrew `brew install postgresql`
   - Linux: use your distro packages (`apt install postgresql` / `dnf install postgresql-server`)

2. Initialize DB cluster (if required by your installer) and start the service.

3. Create DB and user (two options):
   - Using psql and the SQL file (recommended):
     ```bash
     psql -U postgres -f database/init_db.sql
     ```
   - Using the PowerShell helper (Windows):
     ```powershell
     # Option A (interactive):
     $env:PGPASSWORD = 'postgres_super_password'
     .\database\create_db.ps1 -DbName tvu_hoso_dnn -DbUser tvu_user -DbPassword 'change_me'
     ```

4. Test connection:
   ```bash
   psql -h localhost -U tvu_user -d tvu_hoso_dnn
   # or
   psql "postgresql://tvu_user:change_me@localhost:5432/tvu_hoso_dnn"
   ```

Security notes
- Change the default password `change_me` to a strong password before using in production.
- Consider creating roles and granting least privilege for app use (CONNECT, USAGE on schemas, SELECT/INSERT/UPDATE/DELETE only on needed tables).

If you want, I can:
- Run the SQL from here (requires a reachable Postgres and credentials), or
- Add a Docker Compose service for Postgres to make local development easier.
