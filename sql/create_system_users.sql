-- ~/scripts/sql/create_system_users.sql
-- psql -h localhost -d postgres -f ~/scripts/sql/create_system_users.sql

CREATE USER dewayne   WITH SUPERUSER PASSWORD 'dewayne';
CREATE USER madbomber WITH SUPERUSER PASSWORD 'madbomber';
CREATE USER postgres  WITH SUPERUSER PASSWORD 'postgres';