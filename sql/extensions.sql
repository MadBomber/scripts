-- scripts/sql/extensions.sql

-- This SQL script is designed to create various PostgreSQL extensions
-- that enhance the database's capabilities. The extensions are 
-- categorized into several groups: HTTP support, data types, 
-- indexing, foreign data wrappers, spatial data, performance 
-- monitoring, auditing, job scheduling, and more. Each extension 
-- is created only if it does not already exist, ensuring that the 
-- script can be run multiple times without causing errors.

-- ===========================
-- HTTP Support
-- ===========================
-- **http**: Provides support for making HTTP requests 
-- from within PostgreSQL.
CREATE EXTENSION IF NOT EXISTS http;

-- ===========================
-- Data Types and Functions
-- ===========================
-- **pgai**: Adds pg_python support for LLM stuff
CREATE EXTENSION IF NOT EXISTS ai;

-- **vector**: Adds support for vector data types and 
-- operations, useful for machine learning and AI 
-- applications.
CREATE EXTENSION IF NOT EXISTS vector;

-- **hstore**: Provides a key-value store within 
-- PostgreSQL, allowing for dynamic attributes.
CREATE EXTENSION IF NOT EXISTS hstore;

-- **uuid-ossp**: Generates universally unique 
-- identifiers (UUIDs) for use as primary keys or unique 
-- identifiers.
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- **citext**: Case-insensitive text type, useful for 
-- comparisons that should ignore case.
CREATE EXTENSION IF NOT EXISTS citext;

-- **tablefunc**: Provides functions to work with tables, 
-- such as crosstab for pivoting data.
CREATE EXTENSION IF NOT EXISTS tablefunc;

-- ===========================
-- Indexing and Search
-- ===========================
-- **pg_trgm**: Supports trigram-based text search, 
-- allowing for efficient searching of text data.
CREATE EXTENSION IF NOT EXISTS pg_trgm;

-- **btree_gin**: Enables GIN indexes on B-tree data types, 
-- improving query performance.
CREATE EXTENSION IF NOT EXISTS btree_gin;

-- **btree_gist**: Provides B-tree indexing for GiST, 
-- allowing for more flexible indexing options.
CREATE EXTENSION IF NOT EXISTS btree_gist;

-- ===========================
-- Foreign Data Wrappers
-- ===========================
-- **postgres_fdw**: Allows for foreign data wrappers to 
-- access PostgreSQL databases from other servers.
-- CREATE EXTENSION IF NOT EXISTS postgres_fdw;

-- ===========================
-- Spatial Data
-- ===========================
-- **postgis**: Adds support for geographic objects, 
-- enabling location queries and spatial analysis.
CREATE EXTENSION IF NOT EXISTS postgis;

-- ===========================
-- Performance Monitoring and Optimization
-- ===========================
-- **pg_stat_statements**: Tracks execution statistics 
-- of SQL statements, useful for performance monitoring.
-- CREATE EXTENSION IF NOT EXISTS pg_stat_statements;

-- **pg_repack**: Reclaims space and optimizes tables, 
-- improving performance by reducing bloat.
-- CREATE EXTENSION IF NOT EXISTS pg_repack;

-- **pg_bulkload**: Fast bulk data loading, significantly 
-- improving the performance of data import operations.
-- CREATE EXTENSION IF NOT EXISTS pg_bulkload;

-- **pg_hint_plan**: Allows for query plan hints, giving 
-- users control over the query planner's decisions.
-- CREATE EXTENSION IF NOT EXISTS pg_hint_plan;

-- ===========================
-- Partitioning and Sampling
-- ===========================
-- **pg_partman**: Manages partitioned tables, automating 
-- the creation and maintenance of partitions.
-- CREATE EXTENSION IF NOT EXISTS pg_partman;

-- **tsm_system_rows**: Provides a table sampling method 
-- that returns a specified number of rows.
CREATE EXTENSION IF NOT EXISTS tsm_system_rows;

-- ===========================
-- Replication and Auditing
-- ===========================
-- **pglogical**: Provides logical replication for 
--PostgreSQL, allowing for data replication between 
-- databases.
CREATE EXTENSION IF NOT EXISTS pglogical;

-- **pgaudit**: Provides detailed session and object 
-- audit logging for compliance and security.
-- CREATE EXTENSION IF NOT EXISTS pgaudit;

-- ===========================
-- Job Scheduling
-- ===========================
-- **pgagent**: Job scheduling for PostgreSQL, allowing 
-- for the automation of routine tasks.
CREATE EXTENSION IF NOT EXISTS pgagent;

-- ===========================
-- Oracle Compatibility
-- ===========================
-- **orafce**: Oracle compatibility functions, providing Oracle-like functionality in PostgreSQL.
-- CREATE EXTENSION IF NOT EXISTS orafce;
