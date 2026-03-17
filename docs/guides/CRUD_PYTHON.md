# Guide CRUD en Python

## Principe
CRUD signifie :
- **Create** : créer une donnée
- **Read** : lire une donnée
- **Update** : modifier une donnée
- **Delete** : supprimer une donnée

## Exemple DB-API

```python
cursor.execute("INSERT INTO client(nom, prenom, email) VALUES (%s, %s, %s)", ("Dupont", "Jean", "jean@example.com"))
conn.commit()
```

```python
cursor.execute("SELECT id_client, nom, prenom, email FROM client")
for row in cursor.fetchall():
    print(row)
```

```python
cursor.execute("UPDATE client SET nom=%s WHERE id_client=%s", ("Durand", 1))
conn.commit()
```

```python
cursor.execute("DELETE FROM client WHERE id_client=%s", (1,))
conn.commit()
```
