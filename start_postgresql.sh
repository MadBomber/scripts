#!/bin/bash
#####################################################
## start_postgresql.sh

# Installation prefix
prefix=/usr/local/pgsql

PGCTL="$prefix/bin/pg_ctl"
PGUSER=postgres

if [ ! -n "$PGDATA" ]; then
  PGDATA="$prefix/data"
fi

# Start server and continue when server is ready to accept connection:

echo "start server"
/etc/init.d/pgsql start
$prefix/bin/pg_isready
while [ $? != 0 ]; do
  sleep 1;
  $prefix/bin/pg_isready
done

