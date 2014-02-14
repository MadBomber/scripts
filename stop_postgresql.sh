#!/bin/bash
#####################################################
## stop_postgresql.sh

# Installation prefix
prefix=/usr/local/pgsql

PGCTL="$prefix/bin/pg_ctl"
PGUSER=postgres

if [ ! -n "$PGDATA" ]; then
  PGDATA="$prefix/data"
fi

# Ensure a stop of PostgreSQL, continue when server is down:

echo "shutdown server"
su - $PGUSER -c "$PGCTL status -D $PGDATA"
if [ $? != 1 ]; then
  su - $PGUSER -c "$PGCTL stop -D  $PGDATA -m fast"
  if [ $? != 1 -a $? != 0 ]; then
    su - $PGUSER  -c "$PGCTL status -D  $PGDATA"
    while [ $? != 1 -a $? != 3 ]; do
      echo "PostgreSQL still running.."
      sleep 1
      su - $PGUSER -c "$PGCTL status -D  $PGDATA"
    done
  fi
fi
