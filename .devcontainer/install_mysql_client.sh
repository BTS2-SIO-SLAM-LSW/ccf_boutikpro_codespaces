#!/usr/bin/env bash
set -e

if command -v mysql >/dev/null 2>&1; then
  echo "Client MySQL déjà installé."
  exit 0
fi

echo "Installation du client MySQL..."

safe_apt_update() {
  if sudo apt-get update; then
    return 0
  fi

  echo "apt-get update a échoué. Tentative de neutralisation du dépôt Yarn si présent..."
  for f in /etc/apt/sources.list.d/yarn.list /etc/apt/sources.list.d/yarnpkg.list; do
    if [ -f "$f" ]; then
      sudo mv "$f" "$f.disabled"
      echo "Dépôt neutralisé : $f"
    fi
  done

  sudo apt-get update
}

safe_apt_update
sudo apt-get install -y default-mysql-client
mysql --version
