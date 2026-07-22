#!/bin/bash
set -e

if [ -z "${DB_USER}" ] || [ -z "${DB_PASSWORD}" ]; then
  echo "DB_USER and DB_PASSWORD must be set to create the privileged user"
  exit 1
fi

mysql -uroot <<-EOSQL
  CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED WITH mysql_native_password BY '${DB_PASSWORD}';
  GRANT ALL PRIVILEGES ON *.* TO '${DB_USER}'@'%' WITH GRANT OPTION;
  FLUSH PRIVILEGES;
EOSQL
