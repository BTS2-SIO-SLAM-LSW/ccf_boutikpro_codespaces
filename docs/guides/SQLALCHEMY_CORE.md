# Guide SQLAlchemy Core

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
SQLAlchemy Core permet de travailler au niveau SQL sans mapper les tables sur des classes Python.
