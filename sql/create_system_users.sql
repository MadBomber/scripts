-- ~/scripts/sql/create_system_users.sql
-- psql -h localhost -d postgres -f ~/scripts/sql/create_system_users.sql

DROP ROLE IF EXISTS dewayne;
DROP ROLE IF EXISTS dewaynevanhoozer;
DROP ROLE IF EXISTS madbomber;
DROP ROLE IF EXISTS postgres;

CREATE ROLE dewayne;
CREATE ROLE dewaynevanhoozer;
CREATE ROLE madbomber;
CREATE ROLE postgres;

CREATE ROLE dewayne   			WITH SUPERUSER PASSWORD 'dewayne';
CREATE ROLE dewaynevanhoozer   	WITH SUPERUSER PASSWORD 'dewayne';
CREATE RoLE madbomber 			WITH SUPERUSER PASSWORD 'madbomber';
ALTER  ROLE postgres  			WITH SUPERUSER PASSWORD 'postgres';
			
ALTER ROLE "dewayne"    		WITH LOGIN;
ALTER ROLE "dewaynevanhoozer"   WITH LOGIN;
ALTER ROLE "madbomber"  		WITH LOGIN;
ALTER ROLE "postgres" 			WITH LOGIN;
