#!/usr/bin/env bash
set -e
cd "$(dirname "$0")/.."
python -m pip install -r requirements.txt >/dev/null 2>&1 || true
until mysql -h db -uroot -prootpwd -e "SELECT 1" >/dev/null 2>&1; do
  echo "En attente de MySQL..."
  sleep 2
done
mysql -h db -uroot -prootpwd boutikpro_ccf < sql/01_schema.sql
mysql -h db -uroot -prootpwd boutikpro_ccf < sql/02_seed.sql
echo "Base initialisée."
