# Guide SQLAlchemy ORM

## Principe

L'ORM de SQLAlchemy permet de représenter les tables par des classes Python et les lignes par des objets.

Dans ce mode d'accès :
- les tables sont décrites par des classes ;
- les opérations CRUD passent souvent par une `Session` ;
- les modifications sont validées avec `session.commit()` ;
- certaines opérations LDD et LCD restent plus simples à exécuter via `text()`.

## Connexion type

```python
from sqlalchemy import create_engine
from sqlalchemy.orm import DeclarativeBase, Session

engine = create_engine("mysql+pymysql://student:studentpwd@db:3306/boutikpro_ccf")

class Base(DeclarativeBase):
    pass
```

## Exemple minimal de modèle

```python
from sqlalchemy import Integer, String
from sqlalchemy.orm import Mapped, mapped_column

class Client(Base):
    __tablename__ = "client"

    id_client: Mapped[int] = mapped_column(Integer, primary_key=True, autoincrement=True)
    nom: Mapped[str] = mapped_column(String(50))
    prenom: Mapped[str] = mapped_column(String(50))
    e_mail: Mapped[str] = mapped_column(String(100))
```

---

# Exemples de requêtes LDD (Langage de Définition de Données)

## 1. Créer une table depuis les classes ORM

```python
from sqlalchemy import Integer, String
from sqlalchemy.orm import Mapped, mapped_column

class Marque(Base):
    __tablename__ = "marque"

    id_marque: Mapped[int] = mapped_column(Integer, primary_key=True, autoincrement=True)
    nom_marque: Mapped[str] = mapped_column(String(100), unique=True)

Base.metadata.create_all(engine)
```

## 2. Créer uniquement certaines tables

```python
Base.metadata.create_all(engine, tables=[Marque.__table__])
```

## 3. Supprimer une table ORM

```python
Base.metadata.drop_all(engine, tables=[Marque.__table__])
```

## 4. Exécuter un ALTER TABLE via l'ORM + SQL brut

```python
from sqlalchemy import text

with engine.begin() as conn:
    conn.execute(text("ALTER TABLE produit ADD COLUMN description VARCHAR(255) NULL"))
```

## 5. Modifier une colonne via SQL brut

```python
with engine.begin() as conn:
    conn.execute(text("ALTER TABLE produit MODIFY COLUMN prix DECIMAL(10,2) NOT NULL"))
```

## 6. Créer une table d'association via SQL brut

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

---

# Exemples de requêtes LMD (Langage de Manipulation de Données)

## Modèle ORM utilisé dans les exemples

```python
from sqlalchemy import Integer, String
from sqlalchemy.orm import Mapped, mapped_column

class Client(Base):
    __tablename__ = "client"

    id_client: Mapped[int] = mapped_column(Integer, primary_key=True, autoincrement=True)
    nom: Mapped[str] = mapped_column(String(50))
    prenom: Mapped[str] = mapped_column(String(50))
    e_mail: Mapped[str] = mapped_column(String(100))
```

## 1. INSERT

```python
with Session(engine) as session:
    client = Client(nom="Durand", prenom="Alice", e_mail="alice.durand@example.com")
    session.add(client)
    session.commit()
```

## 2. INSERT multiple

```python
with Session(engine) as session:
    clients = [
        Client(nom="Martin", prenom="Léo", e_mail="leo@example.com"),
        Client(nom="Petit", prenom="Nina", e_mail="nina@example.com")
    ]
    session.add_all(clients)
    session.commit()
```

## 3. SELECT simple

```python
from sqlalchemy import select

with Session(engine) as session:
    stmt = select(Client).order_by(Client.nom)
    clients = session.scalars(stmt).all()
    for client in clients:
        print(client.id_client, client.nom, client.prenom)
```

## 4. SELECT avec filtre

```python
with Session(engine) as session:
    stmt = select(Client).where(Client.nom == "Durand")
    client = session.scalars(stmt).first()
    print(client)
```

## 5. SELECT avec SQL brut via session

```python
from sqlalchemy import text

with Session(engine) as session:
    result = session.execute(text("""
        SELECT c.id_commande, cl.nom, cl.prenom, c.date_commande, c.montant_total
        FROM commande c
        JOIN client cl ON c.id_client = cl.id_client
        ORDER BY c.date_commande DESC
    """))
    for row in result:
        print(row)
```

## 6. UPDATE

```python
with Session(engine) as session:
    client = session.get(Client, 1)
    if client is not None:
        client.e_mail = "nouveau.mail@example.com"
        session.commit()
```

## 7. DELETE

```python
with Session(engine) as session:
    client = session.get(Client, 1)
    if client is not None:
        session.delete(client)
        session.commit()
```

## 8. Transaction ORM

```python
with Session(engine) as session:
    try:
        client = Client(nom="Bernard", prenom="Tom", e_mail="tom.bernard@example.com")
        session.add(client)
        session.commit()
    except Exception:
        session.rollback()
        raise
```

---

# Exemples de requêtes LCD (Langage de Contrôle de Données)

## Remarque importante

Même avec l'ORM, les opérations LCD passent en pratique par du SQL brut.
Elles nécessitent en général un compte administrateur MySQL.

## 1. Créer un utilisateur

```python
from sqlalchemy import text

with engine.begin() as conn:
    conn.execute(text("CREATE USER IF NOT EXISTS 'tp_user'@'%' IDENTIFIED BY 'MotDePasse123!'"))
```

## 2. Donner des droits SELECT

```python
with engine.begin() as conn:
    conn.execute(text("GRANT SELECT ON boutikpro_ccf.* TO 'tp_user'@'%'"))
```

## 3. Donner des droits SELECT, INSERT, UPDATE, DELETE

```python
with engine.begin() as conn:
    conn.execute(text("GRANT SELECT, INSERT, UPDATE, DELETE ON boutikpro_ccf.* TO 'tp_user'@'%'"))
```

## 4. Donner des droits sur une table

```python
with engine.begin() as conn:
    conn.execute(text("GRANT SELECT, INSERT ON boutikpro_ccf.commande TO 'tp_user'@'%'"))
```

## 5. Retirer des droits

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

## 7. Supprimer un utilisateur

```python
with engine.begin() as conn:
    conn.execute(text("DROP USER IF EXISTS 'tp_user'@'%'"))
```

---

# Exemple de mini CRUD complet en SQLAlchemy ORM

```python
from sqlalchemy import create_engine, Integer, String, select
from sqlalchemy.orm import DeclarativeBase, Mapped, Session, mapped_column

engine = create_engine("mysql+pymysql://student:studentpwd@db:3306/boutikpro_ccf")

class Base(DeclarativeBase):
    pass

class Client(Base):
    __tablename__ = "client"

    id_client: Mapped[int] = mapped_column(Integer, primary_key=True, autoincrement=True)
    nom: Mapped[str] = mapped_column(String(50))
    prenom: Mapped[str] = mapped_column(String(50))
    e_mail: Mapped[str] = mapped_column(String(100))

# CREATE
with Session(engine) as session:
    client = Client(nom="Martin", prenom="Léo", e_mail="leo.martin@example.com")
    session.add(client)
    session.commit()
    session.refresh(client)
    new_id = client.id_client

# READ
with Session(engine) as session:
    stmt = select(Client).where(Client.id_client == new_id)
    client = session.scalars(stmt).first()
    print(client.id_client, client.nom, client.prenom, client.e_mail)

# UPDATE
with Session(engine) as session:
    client = session.get(Client, new_id)
    if client is not None:
        client.e_mail = "leo.martin.pro@example.com"
        session.commit()

# DELETE
with Session(engine) as session:
    client = session.get(Client, new_id)
    if client is not None:
        session.delete(client)
        session.commit()
```
