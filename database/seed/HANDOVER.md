Hand-over notes for Backend team

Files:
- `seed.sql`: initial seed data for development.

How to use:
1. Backup database (recommended):
   pg_dump -h localhost -p 5432 -U postgres -F c -b -v -f database/backups/tvu_hoso_dnn_YYYYMMDD_HHMMSS.bak tvu_hoso_dnn
2. Run seed as application DB user:
   $env:PGPASSWORD='change_me'
   psql -h localhost -p 5432 -U tvu_user -d tvu_hoso_dnn -f database/seed/seed.sql

Notes for devs:
- The demo user password is plain text in the seed for convenience; replace with a hashed password in production or update the application to hash on first login.
- `schema.sql` is idempotent (CREATE IF NOT EXISTS) to reduce errors on re-run.
- If you need ownership changes, run as superuser:
  DO $$ DECLARE r record; BEGIN FOR r IN SELECT tablename FROM pg_tables WHERE schemaname='public' LOOP EXECUTE format('ALTER TABLE public.%I OWNER TO tvu_user', r.tablename); END LOOP; END $$;

Contact:
- Provide this repository link and any DB credentials to the team.
