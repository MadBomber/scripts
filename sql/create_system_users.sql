-- ~/scripts/sql/create_system_users.sql
-- psql -h localhost -d postgres -f ~/scripts/sql/create_system_users.sql

DROP ROLE IF EXISTS dewayne;
DROP ROLE IF EXISTS madbomber;

CREATE ROLE dewayne   WITH SUPERUSER PASSWORD 'dewayne';
CREATE RoLE madbomber WITH SUPERUSER PASSWORD 'madbomber';
ALTER  ROLE postgres  WITH SUPERUSER PASSWORD 'postgres';
