#!/usr/bin/env bash
set -e
cd "$(dirname "$0")/.."
bash scripts/setup.sh
bash scripts/check_db.sh
python -m src.dbapi.main
