#!/usr/bin/env bash
set -e
mysql -h db -ustudent -pstudentpwd -D boutikpro_ccf -e "SHOW TABLES;"
