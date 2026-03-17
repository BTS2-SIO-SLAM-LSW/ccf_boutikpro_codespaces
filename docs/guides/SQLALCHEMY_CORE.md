# Guide SQLAlchemy Core

## Principe

SQLAlchemy Core permet de travailler avec SQL de manière structurée sans utiliser de classes métiers mappées sur les tables.

Dans ce mode d'accès :
- vous créez un moteur (`engine`) ;
- vous exécutez des requêtes SQL avec `text()` ou avec les objets SQLAlchemy ;
- vous gérez les transactions avec `engine.begin()` ;
- vous restez très proche du SQL.

## Connexion type

```python
from sqlalchemy import create_engine, text

engine = create_engine("mysql+pymysql://student:studentpwd@db:3306/boutikpro_ccf")

with engine.begin() as conn:
    rows = conn.execute(text("SELECT id_client, nom FROM client"))
    for row in rows:
        print(row)
```

## Idée générale

SQLAlchemy Core est adapté lorsque l'on souhaite :
- garder la maîtrise des requêtes SQL ;
- factoriser le code de connexion ;
- bénéficier d'une gestion plus propre des transactions.

---

# Exemples de requêtes LDD (Langage de Définition de Données)

## 1. Créer une table

```python
from sqlalchemy import create_engine, text

engine = create_engine("mysql+pymysql://student:studentpwd@db:3306/boutikpro_ccf")

with engine.begin() as conn:
    conn.execute(text("""
        CREATE TABLE IF NOT EXISTS marque (
            id_marque INT AUTO_INCREMENT PRIMARY KEY,
            nom_marque VARCHAR(100) NOT NULL UNIQUE
        )
    """))
```

## 2. Ajouter une colonne

```python
with engine.begin() as conn:
    conn.execute(text("""
        ALTER TABLE produit
        ADD COLUMN description VARCHAR(255) NULL
    """))
```

## 3. Modifier une colonne

```python
with engine.begin() as conn:
    conn.execute(text("""
        ALTER TABLE produit
        MODIFY COLUMN prix DECIMAL(10,2) NOT NULL
    """))
```

## 4. Créer une table d'association

```python
with engine.begin() as conn:
    conn.execute(text("""
        CREATE TABLE IF NOT EXISTS contient (
            id_commande VARCHAR(50) NOT NULL,
            id_produit VARCHAR(50) NOT NULL,
            quantite INT NOT NULL DEFAULT 1,
            PRIMARY KEY (id_commande, id_produit),
            CONSTRAINT fk_contient_commande
                FOREIGN KEY (id_commande) REFERENCES commande(id_commande),
            CONSTRAINT fk_contient_produit
                FOREIGN KEY (id_produit) REFERENCES produit(id_produit)
        )
    """))
```

## 5. Supprimer une table

```python
with engine.begin() as conn:
    conn.execute(text("DROP TABLE IF EXISTS marque"))
```

---

# Exemples de requêtes LMD (Langage de Manipulation de Données)

## 1. INSERT

```python
with engine.begin() as conn:
    conn.execute(
        text("""
            INSERT INTO client (nom, prenom, e_mail)
            VALUES (:nom, :prenom, :email)
        """),
        {"nom": "Durand", "prenom": "Alice", "email": "alice.durand@example.com"}
    )
```

## 2. INSERT multiple

```python
with engine.begin() as conn:
    conn.execute(
        text("""
            INSERT INTO produit (id_produit, libelle, prix, id_categorie_produit)
            VALUES (:id_produit, :libelle, :prix, :id_categorie)
        """),
        [
            {"id_produit": "P900", "libelle": "Webcam", "prix": 59.90, "id_categorie": 1},
            {"id_produit": "P901", "libelle": "Casque", "prix": 39.90, "id_categorie": 1}
        ]
    )
```

## 3. SELECT simple

```python
with engine.connect() as conn:
    result = conn.execute(text("SELECT id_client, nom, prenom FROM client ORDER BY nom"))
    for row in result:
        print(row)
```

## 4. SELECT avec jointure

```python
with engine.connect() as conn:
    result = conn.execute(text("""
        SELECT c.id_commande, cl.nom, cl.prenom, c.date_commande, c.montant_total
        FROM commande c
        JOIN client cl ON c.id_client = cl.id_client
        ORDER BY c.date_commande DESC
    """))
    for row in result:
        print(row)
```

## 5. SELECT avec agrégat

```python
with engine.connect() as conn:
    result = conn.execute(text("""
        SELECT id_client, COUNT(*) AS nb_commandes, SUM(montant_total) AS total_depense
        FROM commande
        GROUP BY id_client
        HAVING COUNT(*) >= 1
    """))
    for row in result:
        print(row)
```

## 6. UPDATE

```python
with engine.begin() as conn:
    conn.execute(
        text("UPDATE client SET e_mail = :email WHERE id_client = :id_client"),
        {"email": "nouveau.mail@example.com", "id_client": 1}
    )
```

## 7. DELETE

```python
with engine.begin() as conn:
    conn.execute(
        text("DELETE FROM facture WHERE id_facture = :id_facture"),
        {"id_facture": 10}
    )
```

## 8. Transaction sur plusieurs requêtes

```python
with engine.begin() as conn:
    conn.execute(
        text("""
            INSERT INTO commande (id_commande, date_commande, montant_total, id_client)
            VALUES (:id_commande, NOW(), :montant_total, :id_client)
        """),
        {"id_commande": "CMD950", "montant_total": 129.90, "id_client": 1}
    )

    conn.execute(
        text("""
            INSERT INTO facture (id_facture, montant_ttc, date_facture, id_commande)
            VALUES (:id_facture, :montant_ttc, CURDATE(), :id_commande)
        """),
        {"id_facture": 950, "montant_ttc": 129.90, "id_commande": "CMD950"}
    )
```

---

# Exemples de requêtes LCD (Langage de Contrôle de Données)

## Remarque importante

Les requêtes LCD nécessitent généralement un compte MySQL administrateur.
Ces exemples sont fournis à titre pédagogique.

## 1. Créer un utilisateur

```python
with engine.begin() as conn:
    conn.execute(text("CREATE USER IF NOT EXISTS 'tp_user'@'%' IDENTIFIED BY 'MotDePasse123!'"))
```

## 2. Accorder des droits SELECT

```python
with engine.begin() as conn:
    conn.execute(text("GRANT SELECT ON boutikpro_ccf.* TO 'tp_user'@'%'"))
```

## 3. Accorder des droits SELECT, INSERT, UPDATE, DELETE

```python
with engine.begin() as conn:
    conn.execute(text("GRANT SELECT, INSERT, UPDATE, DELETE ON boutikpro_ccf.* TO 'tp_user'@'%'"))
```

## 4. Accorder des droits sur une table précise

```python
with engine.begin() as conn:
    conn.execute(text("GRANT SELECT, INSERT ON boutikpro_ccf.commande TO 'tp_user'@'%'"))
```

## 5. Retirer un droit

```python
with engine.begin() as conn:
    conn.execute(text("REVOKE INSERT ON boutikpro_ccf.commande FROM 'tp_user'@'%'"))
```

## 6. Afficher les droits

```python
with engine.connect() as conn:
    result = conn.execute(text("SHOW GRANTS FOR 'tp_user'@'%'"))
    for row in result:
        print(row)
```

## 7. Supprimer l'utilisateur

```python
with engine.begin() as conn:
    conn.execute(text("DROP USER IF EXISTS 'tp_user'@'%'"))
```

---

# Exemple de mini CRUD complet en SQLAlchemy Core

```python
from sqlalchemy import create_engine, text

engine = create_engine("mysql+pymysql://student:studentpwd@db:3306/boutikpro_ccf")

with engine.begin() as conn:
    # CREATE
    result = conn.execute(
        text("INSERT INTO client (nom, prenom, e_mail) VALUES (:nom, :prenom, :email)"),
        {"nom": "Martin", "prenom": "Léo", "email": "leo.martin@example.com"}
    )
    new_id = result.lastrowid

with engine.connect() as conn:
    # READ
    row = conn.execute(
        text("SELECT id_client, nom, prenom, e_mail FROM client WHERE id_client = :id_client"),
        {"id_client": new_id}
    ).mappings().first()
    print(row)

with engine.begin() as conn:
    # UPDATE
    conn.execute(
        text("UPDATE client SET e_mail = :email WHERE id_client = :id_client"),
        {"email": "leo.martin.pro@example.com", "id_client": new_id}
    )

with engine.begin() as conn:
    # DELETE
    conn.execute(
        text("DELETE FROM client WHERE id_client = :id_client"),
        {"id_client": new_id}
    )
```
