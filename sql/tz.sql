-- scripts/tz.sql

-- gets the RDBMS (PostgreSQL) time zone config
show time zone;

-- Gets the current offsets of North America time zones
SELECT *
FROM pg_timezone_names
WHERE
   name = 'America/New_York'
OR name = 'America/Chicago'
OR name = 'America/Denver'
OR name = 'America/Phoenix'     -- does not support DST
OR name = 'America/Los_Angeles'
ORDER BY utc_offset DESC;
