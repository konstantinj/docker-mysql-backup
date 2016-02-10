#!/bin/bash

mysql_conn_opts="--host=${MYSQL_HOST:-db} --user=root --password=$MYSQL_ROOT_PASSWORD"

wait_for_mysql() {
  until mysql $mysql_conn_opts --execute=";" &>/dev/null; do
    echo "waiting for mysql to start..."
    sleep 2
  done
}

wait_for_mysql

echo "0 0 * * * /backup.sh $mysql_conn_opts" | crontab -

crond -d 8 -b

:>/log/backup.log
tail -f /log/backup.log
