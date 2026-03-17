DROP TABLE IF EXISTS recommande;
DROP TABLE IF EXISTS contient;
DROP TABLE IF EXISTS livre;
DROP TABLE IF EXISTS facture;
DROP TABLE IF EXISTS commande;
DROP TABLE IF EXISTS carte_fidelite;
DROP TABLE IF EXISTS produit;
DROP TABLE IF EXISTS fournisseur;
DROP TABLE IF EXISTS categorie_produit;
DROP TABLE IF EXISTS categorie_fournisseur;
DROP TABLE IF EXISTS client;

CREATE TABLE client (
  id_client INT PRIMARY KEY AUTO_INCREMENT,
  nom VARCHAR(50) NOT NULL,
  prenom VARCHAR(50) NOT NULL,
  email VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE carte_fidelite (
  id_carte_fidelite INT PRIMARY KEY AUTO_INCREMENT,
  date_creation DATE NOT NULL,
  points_fidelite INT NOT NULL DEFAULT 0,
  id_client INT NOT NULL UNIQUE,
  CONSTRAINT fk_carte_client FOREIGN KEY (id_client) REFERENCES client(id_client)
);

CREATE TABLE commande (
  id_commande INT PRIMARY KEY AUTO_INCREMENT,
  date_commande DATETIME NOT NULL,
  montant_total DECIMAL(10,2) NOT NULL,
  id_client INT NOT NULL,
  CONSTRAINT fk_commande_client FOREIGN KEY (id_client) REFERENCES client(id_client)
);

CREATE TABLE facture (
  id_facture INT PRIMARY KEY AUTO_INCREMENT,
  montant_ttc DECIMAL(10,2) NOT NULL,
  date_facture DATE NOT NULL,
  id_commande INT NOT NULL UNIQUE,
  CONSTRAINT fk_facture_commande FOREIGN KEY (id_commande) REFERENCES commande(id_commande)
);

CREATE TABLE categorie_produit (
  id_categorie_produit INT PRIMARY KEY AUTO_INCREMENT,
  nom_categorie VARCHAR(50) NOT NULL
);

CREATE TABLE produit (
  id_produit INT PRIMARY KEY AUTO_INCREMENT,
  libelle VARCHAR(50) NOT NULL,
  prix DECIMAL(10,2) NOT NULL,
  id_categorie_produit INT NOT NULL,
  CONSTRAINT fk_produit_categorie FOREIGN KEY (id_categorie_produit) REFERENCES categorie_produit(id_categorie_produit)
);

CREATE TABLE categorie_fournisseur (
  id_categorie_fournisseur INT PRIMARY KEY AUTO_INCREMENT,
  nom_categorie VARCHAR(50) NOT NULL
);

CREATE TABLE fournisseur (
  id_fournisseur INT PRIMARY KEY AUTO_INCREMENT,
  nom_fournisseur VARCHAR(50) NOT NULL,
  id_categorie_fournisseur INT NOT NULL,
  CONSTRAINT fk_fournisseur_categorie FOREIGN KEY (id_categorie_fournisseur) REFERENCES categorie_fournisseur(id_categorie_fournisseur)
);

CREATE TABLE contient (
  id_commande INT NOT NULL,
  id_produit INT NOT NULL,
  quantite INT NOT NULL DEFAULT 1,
  PRIMARY KEY (id_commande, id_produit),
  CONSTRAINT fk_contient_commande FOREIGN KEY (id_commande) REFERENCES commande(id_commande),
  CONSTRAINT fk_contient_produit FOREIGN KEY (id_produit) REFERENCES produit(id_produit)
);

CREATE TABLE livre (
  id_produit INT NOT NULL,
  id_fournisseur INT NOT NULL,
  PRIMARY KEY (id_produit, id_fournisseur),
  CONSTRAINT fk_livre_produit FOREIGN KEY (id_produit) REFERENCES produit(id_produit),
  CONSTRAINT fk_livre_fournisseur FOREIGN KEY (id_fournisseur) REFERENCES fournisseur(id_fournisseur)
);

CREATE TABLE recommande (
  id_client_source INT NOT NULL,
  id_client_cible INT NOT NULL,
  PRIMARY KEY (id_client_source, id_client_cible),
  CONSTRAINT fk_recommande_source FOREIGN KEY (id_client_source) REFERENCES client(id_client),
  CONSTRAINT fk_recommande_cible FOREIGN KEY (id_client_cible) REFERENCES client(id_client)
);
