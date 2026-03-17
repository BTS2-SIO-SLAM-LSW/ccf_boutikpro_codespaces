# Guide Python DB-API

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

## Points importants
- ouvrir une connexion ;
- créer un curseur ;
- exécuter les requêtes ;
- valider avec `commit()` pour INSERT, UPDATE et DELETE ;
- fermer le curseur et la connexion.
