#!/bin/bash

dir_backup=/backup
log_backup=/log/backup.log
file_tmp_dump=/tmp_dump.sql
mysql_conn_opts="$@"
mysql_opts=" --skip-opt --add-drop-table --add-locks --create-options --set-charset --disable-keys --lock-tables --quick --default-character-set=utf8 --routines"

dbs=$(echo "SHOW DATABASES;" | mysql $mysql_conn_opts 2>>$log_backup | grep -v -e 'Database' -e 'mysql' -e 'information_schema' -e 'performance_schema') || error=true
if [ ! -z "$error" ] ; then
    exit 1
fi

for db in $dbs; do
  now=`date +%Y-%m-%d_%H:%M:%S`
  echo "$now: dumping $db">>$log_backup
  echo "SET NAMES 'utf8';">$file_tmp_dump
  mysqldump $mysql_conn_opts $mysql_opts $db 2>>$log_backup 1>>$file_tmp_dump
  bzip2 -c -9 < $file_tmp_dump > $dir_backup/mysqldump_$db"_$now".sql.bz2
  rm $file_tmp_dump
done

chmod 0600 $dir_backup/*.sql.bz2
