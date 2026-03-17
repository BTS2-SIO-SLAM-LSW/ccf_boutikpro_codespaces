# Installation Codespace

## Ouverture du projet

1. Ouvrir le dépôt dans GitHub.
2. Créer un Codespace sur la branche `main`.
3. Attendre la fin complète de l'initialisation.

Le conteneur `db` démarre automatiquement MySQL.
Le `postCreateCommand` exécute automatiquement :

- l'installation du client MySQL si nécessaire ;
- `bash scripts/setup.sh` ;
- `bash scripts/check_db.sh`.

## Commandes à relancer manuellement si besoin

```bash
cd /workspace/ccf-boutikpro-codespaces
sudo apt-get update
sudo apt-get install -y default-mysql-client
bash scripts/setup.sh
bash scripts/check_db.sh
python -m src.dbapi.main
```

## Commande simplifiée

```bash
bash scripts/start_dbapi.sh
```

## Vérification

Le contrôle de la base affiche les tables de `boutikpro_ccf`.
Le lancement Python doit ensuite afficher le bandeau du mode DB-API et la liste des clients.
