#!/usr/bin/env bash
set -e
cd "$(dirname "$0")/.."

bash .devcontainer/install_mysql_client.sh
mysql -h db -ustudent -pstudentpwd -D boutikpro_ccf -e "SHOW TABLES;"
