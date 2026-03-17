# BoutikPro - CCF Python / MySQL / Modélisation BTS SIO SLAM

## Documentation du CCF

| Partie | Documentation | Contenu | Statut |
|---|---|---|---|
| Démarrage | [START-HERE](START-HERE.md) | Feuille de route de l'étudiant | OK |
| Sujet | [SUBJECT](SUBJECT.md) | Énoncé complet du CCF | OK |
| Option 1 - Installation distante | [Guide installation distante](docs/INSTALLATION-CODESPACE.md) | Lancement avec GitHub Codespaces et outils en ligne | OK |
| Option 2 - Installation locale | [Guide installation locale](docs/INSTALLATION-LOCALE.md) | Installation sur poste personnel | OK |
| CRUD Python | [Guide CRUD](docs/guides/CRUD_PYTHON.md) | Rappels Create / Read / Update / Delete | OK |
| DB-API | [Guide DB-API](docs/guides/PYTHON_DB_API.md) | Connexion native MySQL en Python | OK |
| SQLAlchemy Core | [Guide Core](docs/guides/SQLALCHEMY_CORE.md) | Requêtes SQLAlchemy Core | OK |
| SQLAlchemy ORM | [Guide ORM](docs/guides/SQLALCHEMY_ORM.md) | Mapping classes / tables | OK |
| MCD / MLD | [Guide Modélisation](docs/guides/MCD_MLD.md) | Passage du MCD au MLD | OK |
| UML - Cas d'utilisation | [Guide UML](docs/phase-01/01-diagramme-cas-utilisation.md) | TP PlantUML sur le diagramme de l'application | OK |
| Questions | [Questions du TP](docs/questions/QUESTIONS-TP.md) | Questions de cours liées au TP | OK |
| Évaluation | [Grille](docs/grille_evaluation.md) | Barème indicatif | OK |

BoutikPro est une application de gestion commerciale simplifiée . Le projet est centré sur :

- la modélisation UML et Merise ;
- la création et la modification d'une base MySQL ;
- le passage MCD → MLD ;
- la programmation Python connectée à la base ;
- la mise en œuvre d'un CRUD ;
- le choix d'un des trois modes d'accès aux données :
  - Python DB-API
  - SQLAlchemy Core
  - SQLAlchemy ORM

## Image du MCD de référence

![MCD BoutikPro](assets/MCD_schema_entite_association.jpg)

## Public cible
- Étudiants de BTS SIO SLAM 2e année
- Formateurs en développement et base de données
- Enseignants souhaitant un support CCF lançable sous Codespaces ou en local

## Objectifs pédagogiques
1. Analyser un besoin métier à partir d'un contexte professionnel
2. Relier diagramme de cas d'utilisation, MCD et base relationnelle
3. Créer et faire évoluer une base MySQL
4. Programmer un CRUD Python sur une base réelle
5. Justifier les choix techniques et documenter le travail réalisé

## Installation rapide

### Option 1 : installation distante

Cette option repose sur GitHub Codespaces pour l'environnement d'exécution et sur l'éditeur PlantUML en ligne pour la modélisation UML.

1. Ouvrir ce dépôt dans GitHub.
2. Cliquer sur **Code** puis **Codespaces**.
3. Choisir **Create codespace on main**.
4. Attendre la fin complète de l'initialisation du conteneur.
5. Dans le terminal du Codespace, exécuter :

```bash
bash scripts/setup.sh
bash scripts/check_db.sh
```

6. Lancer ensuite le mode Python voulu depuis la racine du projet :

```bash
python -m src.dbapi.main
python -m src.core.main
python -m src.orm.main
```

7. Ouvrir l'éditeur PlantUML en ligne à l'adresse suivante :

```text
https://editor.plantuml.com/
```

8. Lire dans cet ordre :
- [START-HERE.md](START-HERE.md)
- [SUBJECT.md](SUBJECT.md)
- [docs/INSTALLATION-CODESPACE.md](docs/INSTALLATION-CODESPACE.md)
- [docs/phase-01/01-diagramme-cas-utilisation.md](docs/phase-01/01-diagramme-cas-utilisation.md)
- [docs/guides/CRUD_PYTHON.md](docs/guides/CRUD_PYTHON.md)
- le guide du mode choisi :
  - [docs/guides/PYTHON_DB_API.md](docs/guides/PYTHON_DB_API.md)
  - [docs/guides/SQLALCHEMY_CORE.md](docs/guides/SQLALCHEMY_CORE.md)
  - [docs/guides/SQLALCHEMY_ORM.md](docs/guides/SQLALCHEMY_ORM.md)

### Option 2 : installation locale

Cette option permet de travailler hors Codespaces, sur Windows, Linux, macOS ou WSL.

1. Lire le guide complet : [docs/INSTALLATION-LOCALE.md](docs/INSTALLATION-LOCALE.md)
2. Choisir ensuite le script adapté à votre système :
- Windows CMD : `scripts/local/setup_windows.bat`
- Windows PowerShell : `scripts/local/setup_windows.ps1`
- Linux : `scripts/local/setup_linux.sh`
- macOS : `scripts/local/setup_macos.sh`
- WSL : `scripts/local/setup_wsl.sh`
3. Créer la base et injecter les scripts SQL selon les consignes du guide local.
4. Ouvrir ensuite PlantUML :

```text
https://editor.plantuml.com/
```

## Où se trouvent les 3 modes d'accès Python et comment les lancer

Les trois points d'entrée Python du CCF se trouvent dans le dossier `src/` :

- `src/dbapi/main.py` pour **Python DB-API** ;
- `src/core/main.py` pour **SQLAlchemy Core** ;
- `src/orm/main.py` pour **SQLAlchemy ORM**.

Depuis la racine du projet, vous pouvez lancer chaque mode avec l'une des commandes suivantes.

### Depuis GitHub Codespaces

```bash
python -m src.dbapi.main
python -m src.core.main
python -m src.orm.main
```

Vous pouvez aussi utiliser les scripts fournis :

```bash
bash scripts/run_dbapi.sh
bash scripts/run_core.sh
bash scripts/run_orm.sh
```

### Depuis une installation locale

Activez d'abord l'environnement virtuel, puis placez-vous à la racine du dépôt.

Sous Windows PowerShell :

```powershell
.\.venv\Scripts\Activate.ps1
python -m src.dbapi.main
python -m src.core.main
python -m src.orm.main
```

Sous Windows CMD :

```bat
.venv\Scripts\activate.bat
python -m src.dbapi.main
python -m src.core.main
python -m src.orm.main
```

Sous Linux, macOS ou WSL :

```bash
source .venv/bin/activate
python -m src.dbapi.main
python -m src.core.main
python -m src.orm.main
```

Chaque étudiant choisit **un seul mode d'accès** pour le développement principal du CRUD, mais il peut tester les trois lanceurs pour comparer leur fonctionnement.


## Démarrage automatique de MySQL dans GitHub Codespaces

Le template est configuré pour que le service MySQL démarre automatiquement avec le Codespace via Docker Compose.
Le script `scripts/setup.sh` attend que MySQL soit prêt, crée la base `boutikpro_ccf`, puis charge `sql/01_schema.sql` et `sql/02_seed.sql`.

Après ouverture du Codespace, l'étudiant peut relancer manuellement l'initialisation avec les commandes suivantes :

```bash
cd /workspace/ccf-boutikpro-codespaces
sudo apt-get update
sudo apt-get install -y default-mysql-client
bash scripts/setup.sh
bash scripts/check_db.sh
python -m src.dbapi.main
```

Si `apt-get update` échoue à cause d'un dépôt externe non signé, le script `bash .devcontainer/install_mysql_client.sh` corrige automatiquement ce cas avant installation du client MySQL.

Pour un lancement en une seule commande :

```bash
bash scripts/start_dbapi.sh
```
