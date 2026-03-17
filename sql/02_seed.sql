INSERT INTO client (nom, prenom, email) VALUES
('Durand', 'Alice', 'alice@boutikpro.fr'),
('Martin', 'Bruno', 'bruno@boutikpro.fr'),
('Petit', 'Chloe', 'chloe@boutikpro.fr');

INSERT INTO carte_fidelite (date_creation, points_fidelite, id_client) VALUES
('2026-01-10', 120, 1),
('2026-01-12', 80, 2);

INSERT INTO categorie_produit (nom_categorie) VALUES
('Ordinateurs'), ('Accessoires');

INSERT INTO produit (libelle, prix, id_categorie_produit) VALUES
('PC Portable 14 pouces', 799.99, 1),
('Souris sans fil', 24.90, 2),
('Clavier mécanique', 69.90, 2);

INSERT INTO categorie_fournisseur (nom_categorie) VALUES
('Grossiste'), ('Constructeur');

INSERT INTO fournisseur (nom_fournisseur, id_categorie_fournisseur) VALUES
('TechDistrib', 1),
('MegaHardware', 2);

INSERT INTO livre (id_produit, id_fournisseur) VALUES
(1, 2), (2, 1), (3, 1);

INSERT INTO commande (date_commande, montant_total, id_client) VALUES
('2026-02-10 10:00:00', 824.89, 1),
('2026-02-11 11:30:00', 69.90, 2);

INSERT INTO contient (id_commande, id_produit, quantite) VALUES
(1, 1, 1), (1, 2, 1), (2, 3, 1);

INSERT INTO facture (montant_ttc, date_facture, id_commande) VALUES
(824.89, '2026-02-10', 1),
(69.90, '2026-02-11', 2);

INSERT INTO recommande (id_client_source, id_client_cible) VALUES
(1, 2), (2, 3);
