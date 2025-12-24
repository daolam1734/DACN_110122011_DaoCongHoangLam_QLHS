-- init_db.sql
-- Usage: run as a PostgreSQL superuser (psql -U postgres -f init_db.sql)

-- Replace names and password before running in production
\connect postgres

CREATE DATABASE tvu_hoso_dnn;

-- create user and grant privileges
CREATE USER tvu_user WITH PASSWORD 'change_me';
GRANT ALL PRIVILEGES ON DATABASE tvu_hoso_dnn TO tvu_user;

-- You can add schema / initial tables below, example:
-- \c tvu_hoso_dnn
-- CREATE TABLE example (
--   id serial PRIMARY KEY,
--   name text NOT NULL
-- );
