# TP — Diagramme de cas d'utilisation de l'application BoutikPro

## Contexte professionnel

Vous effectuez votre stage au sein de l’entreprise BoutikPro, une PME spécialisée dans la vente de produits grand public sur catalogue.

L’entreprise commercialise différents produits classés par catégories et s’approvisionne auprès de plusieurs fournisseurs, eux-mêmes regroupés par catégories de fournisseurs.

L’activité de l’entreprise repose sur une application interne de gestion commerciale permettant :
- de gérer les clients ;
- d’enregistrer les commandes passées par les clients ;
- de gérer les produits et leurs catégories ;
- d’identifier les fournisseurs des produits ;
- de générer les factures associées aux commandes ;
- de gérer un système de carte de fidélité attribuable à certains clients ;
- d’enregistrer les recommandations entre clients dans le cadre d’un programme de parrainage.

La direction souhaite faire évoluer son système d’information.
Avant de développer l’application Python reliée à une base de données MySQL, l’équipe projet vous demande de produire une première modélisation UML sous la forme d’un diagramme de cas d’utilisation.

## Mission confiée à l'étudiant
1. analyser le contexte métier ;
2. identifier les acteurs interagissant avec l’application ;
3. identifier les cas d’utilisation principaux ;
4. réaliser avec PlantUML un diagramme de cas d’utilisation représentant les interactions entre les acteurs et le système.

## Consignes
Le diagramme devra au minimum permettre de représenter :
- la connexion d’un utilisateur générique ;
- gérer les clients ;
- attribuer une carte de fidélité à un client ;
- enregistrer une commande ;
- ajouter des produits dans une commande ;
- consulter les produits ;
- gérer les catégories de produits ;
- gérer les fournisseurs ;
- associer un produit à un fournisseur ;
- générer une facture à partir d’une commande ;
- enregistrer une recommandation entre deux clients.

## Spécialisation des acteurs
L'acteur générique est **Utilisateur**.
Ses spécialisations attendues sont :
- Employé commercial
- Gestionnaire catalogue
- Gestionnaire fournisseurs
- Comptable

## Livrable attendu
Un fichier `uml/usecase.puml` contenant le diagramme de cas d’utilisation.

## Outil recommandé
Version en ligne de PlantUML :

```text
https://editor.plantuml.com/
```
