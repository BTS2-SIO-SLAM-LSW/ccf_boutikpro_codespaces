# Dépannage

## `mysql: command not found`

Exécuter :

```bash
bash .devcontainer/install_mysql_client.sh
```

ou, manuellement :

```bash
sudo apt-get update
sudo apt-get install -y default-mysql-client
```

## `apt-get update` échoue à cause d'un dépôt non signé

Le script `bash .devcontainer/install_mysql_client.sh` neutralise automatiquement le dépôt Yarn si ce problème survient.

## `Table ... doesn't exist`

Réinitialiser la base :

```bash
bash scripts/setup.sh
bash scripts/check_db.sh
```

## `ModuleNotFoundError: No module named 'src'`

Toujours lancer les modes Python avec `-m` depuis la racine du projet :

```bash
python -m src.dbapi.main
python -m src.core.main
python -m src.orm.main
```
