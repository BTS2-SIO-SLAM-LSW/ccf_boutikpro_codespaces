# Guide Python DB-API

## Principe

Python DB-API permet d'exécuter directement des requêtes SQL depuis Python à l'aide d'un connecteur MySQL.

Dans ce mode d'accès :
- vous écrivez vous-même les requêtes SQL ;
- vous utilisez un curseur pour les exécuter ;
- vous validez les modifications avec `commit()` ;
- vous gérez explicitement les erreurs et les transactions.

## Connexion type

```python
import mysql.connector

conn = mysql.connector.connect(
    host="db",
    port=3306,
    user="student",
    password="studentpwd",
    database="boutikpro_ccf"
)

cursor = conn.cursor()
```

## Structure minimale recommandée

```python
import mysql.connector
from mysql.connector import Error

conn = None
cursor = None

try:
    conn = mysql.connector.connect(
        host="db",
        port=3306,
        user="student",
        password="studentpwd",
        database="boutikpro_ccf"
    )
    cursor = conn.cursor()

    cursor.execute("SELECT id_client, nom, prenom FROM client")
    for row in cursor.fetchall():
        print(row)

except Error as e:
    print(f"Erreur MySQL : {e}")

finally:
    if cursor is not None:
        cursor.close()
    if conn is not None and conn.is_connected():
        conn.close()
```

## Rappel important

- utiliser `%s` pour les paramètres ;
- ne pas concaténer les valeurs utilisateur dans les requêtes SQL ;
- appeler `commit()` après une requête de type insertion, modification ou suppression ;
- utiliser `rollback()` si une erreur survient pendant une transaction.

---

# Exemples de requêtes LDD (Langage de Définition de Données)

Le LDD permet de créer, modifier ou supprimer la structure de la base.

## 1. Créer une table

```python
cursor.execute("""
CREATE TABLE IF NOT EXISTS marque (
    id_marque INT AUTO_INCREMENT PRIMARY KEY,
    nom_marque VARCHAR(100) NOT NULL UNIQUE
)
""")
conn.commit()
```

## 2. Ajouter une colonne

```python
cursor.execute("""
ALTER TABLE produit
ADD COLUMN description VARCHAR(255) NULL
""")
conn.commit()
```

## 3. Modifier le type d'une colonne

```python
cursor.execute("""
ALTER TABLE produit
MODIFY COLUMN prix DECIMAL(10,2) NOT NULL
""")
conn.commit()
```

## 4. Supprimer une colonne

```python
cursor.execute("""
ALTER TABLE produit
DROP COLUMN description
""")
conn.commit()
```

## 5. Créer une table d'association

```python
cursor.execute("""
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
""")
conn.commit()
```

## 6. Supprimer une table

```python
cursor.execute("DROP TABLE IF EXISTS marque")
conn.commit()
```

---

# Exemples de requêtes LMD (Langage de Manipulation de Données)

Le LMD permet d'insérer, lire, modifier et supprimer des données.

## 1. INSERT

```python
cursor.execute(
    """
    INSERT INTO client (nom, prenom, e_mail)
    VALUES (%s, %s, %s)
    """,
    ("Durand", "Alice", "alice.durand@example.com")
)
conn.commit()
```

## 2. INSERT multiple

```python
data = [
    ("C100", "Clavier", 49.90, 1),
    ("C101", "Souris", 19.90, 1)
]

cursor.executemany(
    """
    INSERT INTO produit (id_produit, libelle, prix, id_categorie_produit)
    VALUES (%s, %s, %s, %s)
    """,
    data
)
conn.commit()
```

## 3. SELECT simple

```python
cursor.execute("SELECT id_client, nom, prenom FROM client ORDER BY nom")
rows = cursor.fetchall()
for row in rows:
    print(row)
```

## 4. SELECT avec jointure

```python
cursor.execute("""
SELECT c.id_commande, cl.nom, cl.prenom, c.date_commande, c.montant_total
FROM commande c
JOIN client cl ON c.id_client = cl.id_client
ORDER BY c.date_commande DESC
""")

for row in cursor.fetchall():
    print(row)
```

## 5. SELECT avec agrégat

```python
cursor.execute("""
SELECT id_client, COUNT(*) AS nb_commandes, SUM(montant_total) AS total_depense
FROM commande
GROUP BY id_client
HAVING COUNT(*) >= 1
""")

for row in cursor.fetchall():
    print(row)
```

## 6. UPDATE

```python
cursor.execute(
    "UPDATE client SET e_mail = %s WHERE id_client = %s",
    ("nouveau.mail@example.com", 1)
)
conn.commit()
```

## 7. DELETE

```python
cursor.execute("DELETE FROM facture WHERE id_facture = %s", (10,))
conn.commit()
```

## 8. Transaction manuelle

```python
try:
    cursor.execute(
        "INSERT INTO commande (id_commande, date_commande, montant_total, id_client) VALUES (%s, NOW(), %s, %s)",
        ("CMD900", 89.90, 1)
    )
    cursor.execute(
        "INSERT INTO facture (id_facture, montant_ttc, date_facture, id_commande) VALUES (%s, %s, CURDATE(), %s)",
        (900, 89.90, "CMD900")
    )
    conn.commit()
except Error:
    conn.rollback()
    raise
```

---

# Exemples de requêtes LCD (Langage de Contrôle de Données)

Le LCD permet de gérer les droits et la sécurité d'accès aux données.

## Remarque importante

Les requêtes LCD nécessitent généralement un compte administrateur MySQL.
Elles sont données ici comme exemples de cours et de révision.

## 1. Créer un utilisateur

```python
cursor.execute("CREATE USER IF NOT EXISTS 'tp_user'@'%' IDENTIFIED BY 'MotDePasse123!'")
conn.commit()
```

## 2. Donner des droits de lecture

```python
cursor.execute("GRANT SELECT ON boutikpro_ccf.* TO 'tp_user'@'%'")
conn.commit()
```

## 3. Donner des droits de lecture et modification

```python
cursor.execute("GRANT SELECT, INSERT, UPDATE, DELETE ON boutikpro_ccf.* TO 'tp_user'@'%'")
conn.commit()
```

## 4. Donner des droits sur une table précise

```python
cursor.execute("GRANT SELECT, INSERT ON boutikpro_ccf.commande TO 'tp_user'@'%'")
conn.commit()
```

## 5. Retirer des droits

```python
cursor.execute("REVOKE INSERT ON boutikpro_ccf.commande FROM 'tp_user'@'%'")
conn.commit()
```

## 6. Afficher les droits d'un utilisateur

```python
cursor.execute("SHOW GRANTS FOR 'tp_user'@'%'")
for row in cursor.fetchall():
    print(row)
```

## 7. Supprimer un utilisateur

```python
cursor.execute("DROP USER IF EXISTS 'tp_user'@'%'")
conn.commit()
```

---

# Exemple de mini CRUD complet en DB-API

```python
import mysql.connector

conn = mysql.connector.connect(
    host="db",
    port=3306,
    user="student",
    password="studentpwd",
    database="boutikpro_ccf"
)
cursor = conn.cursor(dictionary=True)

# CREATE
cursor.execute(
    "INSERT INTO client (nom, prenom, e_mail) VALUES (%s, %s, %s)",
    ("Martin", "Léo", "leo.martin@example.com")
)
conn.commit()
new_id = cursor.lastrowid

# READ
cursor.execute("SELECT id_client, nom, prenom, e_mail FROM client WHERE id_client = %s", (new_id,))
client = cursor.fetchone()
print(client)

# UPDATE
cursor.execute(
    "UPDATE client SET e_mail = %s WHERE id_client = %s",
    ("leo.martin.pro@example.com", new_id)
)
conn.commit()

# DELETE
cursor.execute("DELETE FROM client WHERE id_client = %s", (new_id,))
conn.commit()

cursor.close()
conn.close()
```
