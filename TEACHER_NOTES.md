# Notes enseignant

## Intention pédagogique
Ce CCF vise à articuler :
- analyse du besoin ;
- modélisation des données ;
- passage MCD → MLD ;
- modification d'une base relationnelle ;
- programmation Python d'accès aux données.

## Blocs du référentiel principalement mobilisés
- **Bloc 2 – Option SLAM – Conception et développement d’applications** :
  - concevoir et développer une solution applicative ;
  - assurer la maintenance corrective ou évolutive d’une solution applicative ;
  - gérer les données.
- **Bloc 1 – Support et mise à disposition de services informatiques** :
  - travailler en mode projet ;
  - mettre à disposition des utilisateurs un service informatique ;
  - organiser son développement professionnel.
- **Bloc 3 – Cybersécurité des services informatiques** : sensibilisation à la protection des données et à la maîtrise des accès.

## Point de vigilance
Pour l'association **Commande — Facture**, la lecture retenue est :
- côté Commande : `(0,1)`
- côté Facture : `(1,1)`

Traduction relationnelle conseillée : clé étrangère `id_commande` dans `facture` avec `NOT NULL` et `UNIQUE`.
