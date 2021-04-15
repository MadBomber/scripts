#! /bin/bash
# restore_latest_dump.s

file_path=$1
let errors=0

if [ "x" = "x$file_path" ] ; then
  echo "ERROR: Requires one parameter which is a path to a database.dump file."
  let errors++
fi

if [ "x" = "x$DBNAME" ] ; then
  echo "ERROR: Requires environment variable DBNAME to be set.  Full name has _development appended."
  let errors++
fi

if [ "x" = "x$DBUSER" ] ; then
  echo "ERROR: Requires environment variable DBUSER to be set."
  let errors++
fi

log_file=${DBNAME}.log

if [ $errors -gt 0 ]
then
  echo "Correct the $errors errors and try again."

else
  echo "# From `hostname`" > $log_file
  echo "# Creating $DBNAME from $file_path ..." >> $log_file
  echo "#" >> $log_file

  if [[ $file_path != *.sql ]] ; then
    # convert from *.dump to *.dump.sql
    echo "# Converting binary file to sql text" >> $log_file
    echo "#" >> $log_file
    #
    pg_restore -f ${file_path}.sql $file_path
    #
    echo "# replacing uuid-ossp with pgcrypto" >> $log_file
    echo "#" >> $log_file
    #
    # sed -n -f ./replace_uuid-ossp_with_pgcrypto.sed -i .unedited ${file_path}.sql
    #
    # file_path=${file_path}.sql
  fi

  psql -d ${DBNAME}_development -U $DBUSER \
    -f $file_path --echo-all \
    -L $log_file \
    -h localhost
fi

#######################################
# --schema public
# pg_restore --verbose --clean --no-acl --no-owner \
#   --create --if-exists \
#   -h localhost -U $DBUSER -d ${DBNAME}_development \
#  $file_path >> $log_file 2>&1
