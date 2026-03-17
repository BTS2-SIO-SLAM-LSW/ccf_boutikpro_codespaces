# Guide SQLAlchemy ORM

## Connexion type

```python
from sqlalchemy import create_engine
from sqlalchemy.orm import DeclarativeBase, Session

engine = create_engine("mysql+pymysql://student:studentpwd@db:3306/boutikpro_ccf")

class Base(DeclarativeBase):
    pass
```

## Idée générale
L'ORM permet de représenter les tables par des classes et les lignes par des objets.
