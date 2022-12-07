-- ~/scripts/sql/where+omdexes+meeded.sq;

-- Finding which tables need extra indexes
-- 
-- pg_stat_user_tables is a fantastic system view that can show us invaluable 
-- information about the tables in our databases and can be used in diagnosing 
-- performance issues. Vacuum statistics like last_autovacuum and n_dead_tup will show 
-- if there are tables that aren’t being vacuumed efficiently and n_tup_hot_upd if you 
-- aren't performing HOT updates.
-- 
-- One of the things to look for first, though, is if there are tables that need new 
-- indexes as this can have a significant impact on your database's overall performance:
-- 
-- This simple query will help highlight tables that are heavy on sequential scans and 
-- potential candidates for adding an index.
-- 
-- By looking at the seq_scan results, you can see precisely how many sequential scans 
-- have happened on a table. Then looking at seq_tup_read you can see how many tuples 
-- are being read during those scans. If those numbers are significantly higher on 
-- certain tables, some further indexes may be badly needed.


SELECT relname,
    seq_scan,
    seq_tup_read,
    idx_scan
FROM pg_stat_user_tables
WHERE seq_scan > 0
ORDER BY 3 DESC LIMIT 10;
