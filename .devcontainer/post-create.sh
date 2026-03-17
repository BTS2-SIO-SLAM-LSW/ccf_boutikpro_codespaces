#!/usr/bin/env bash
set -e
cd /workspace/ccf-boutikpro-codespaces
bash .devcontainer/install_mysql_client.sh
bash scripts/setup.sh
bash scripts/check_db.sh
