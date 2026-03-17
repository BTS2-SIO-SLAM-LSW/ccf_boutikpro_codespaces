# CCF – BoutikPro

## Contexte professionnel

Vous intervenez au sein de **BoutikPro**, une PME de commerce spécialisée dans la vente de produits techniques. L'entreprise souhaite remplacer plusieurs fichiers dispersés par une application Python connectée à une base MySQL.

Avant le développement, l'équipe a produit un **diagramme de cas d'utilisation** et un **MCD**. Votre mission consiste à mettre en œuvre une première version exploitable du système d'information.

L'application doit permettre de :
- gérer les clients ;
- enregistrer des commandes ;
- gérer un programme de fidélité ;
- produire les factures ;
- gérer les produits et leurs catégories ;
- gérer les fournisseurs et leurs catégories ;
- tracer les recommandations entre clients.

## Données de départ

- Le MCD fourni est disponible dans `assets/MCD_schema_entite_association.jpg`.
- Le contexte professionnel du diagramme de cas d'utilisation est repris dans `docs/phase-01/01-diagramme-cas-utilisation.md`.
- Un squelette PlantUML est fourni dans `uml/usecase.puml`.

## Travail demandé

### Partie 1 — Diagramme de cas d'utilisation avec PlantUML
1. Analyser le contexte métier.
2. Identifier les acteurs interagissant avec l'application.
3. Identifier les cas d'utilisation principaux.
4. Réaliser avec PlantUML un diagramme de cas d'utilisation représentant les interactions entre les acteurs et le système.
5. Faire apparaître l'héritage entre acteurs à partir de l'acteur générique `Utilisateur`.
6. Enregistrer votre travail dans `uml/usecase.puml`.

### Partie 2 — Analyse et modélisation des données
1. Expliquer le lien entre le besoin métier, le diagramme de cas d'utilisation et le MCD.
2. Justifier les cardinalités suivantes :
   - Client / Commande
   - Client / Carte_fidelite
   - Commande / Facture
   - Commande / Produit via `Contient`
   - Produit / Fournisseur via `Livre`
   - Client / Client via `Recommande`
3. Proposer le **MLD relationnel** correspondant.
4. Expliquer la traduction des associations 1,N et N,N en tables relationnelles.

### Partie 3 — Base de données MySQL
1. Exécuter le schéma initial.
2. Charger les données d'essai.
3. Modifier la base à l'aide de `sql/student_upgrade.sql` afin d'ajouter :
   - un champ `telephone` dans `client` ;
   - un champ `stock` dans `produit` ;
   - une contrainte garantissant qu'une facture correspond à une seule commande ;
   - une table ou structure complémentaire permettant de tracer l'état d'une commande (`brouillon`, `validee`, `facturee`).
4. Tester vos modifications.

### Partie 4 — Application Python
Vous devez choisir **un seul mode d'accès** parmi les trois suivants :
- Python DB-API
- SQLAlchemy Core
- SQLAlchemy ORM

L'application console doit proposer au minimum les fonctionnalités suivantes :
1. afficher la liste des clients ;
2. créer un client ;
3. modifier un client ;
4. supprimer un client ;
5. afficher les produits ;
6. enregistrer une commande et ses lignes ;
7. afficher les factures existantes ;
8. exécuter au moins une requête avec jointure et une requête d'agrégation.

### Partie 5 — Questions
Répondre aux questions figurant dans `docs/questions/QUESTIONS-TP.md`.

## Contraintes techniques
- Le projet doit fonctionner dans **GitHub Codespaces**.
- La base de données est **MySQL**.
- Le langage applicatif est **Python**.
- La modélisation UML doit être réalisée avec **PlantUML**.
- Les opérations de création, lecture, modification et suppression doivent être visibles dans le code.

## Livrables
- `uml/usecase.puml`
- `sql/student_upgrade.sql`
- le code Python du mode choisi
- les réponses aux questions
- les éventuelles requêtes complémentaires utilisées pour tester la base
