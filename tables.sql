CREATE TABLE clients (
    id_client       SERIAL PRIMARY KEY,
    nom             VARCHAR(50) NOT NULL,
    prenom          VARCHAR(50) NOT NULL,
    date_naissance  DATE NOT NULL,
    ville           VARCHAR(50) NOT NULL,
    date_inscription DATE NOT NULL
);
CREATE TABLE comptes (
    id_compte       SERIAL PRIMARY KEY,
    id_client       INT NOT NULL REFERENCES clients(id_client),
    type_compte     VARCHAR(20) NOT NULL,   -- Courant, Épargne, Professionnel
    solde           NUMERIC(12,2) NOT NULL,
    date_ouverture  DATE NOT NULL
);

CREATE TABLE categories_transaction (
    id_categorie    SERIAL PRIMARY KEY,
    nom_categorie   VARCHAR(40) NOT NULL
);

CREATE TABLE cartes (
    id_carte        SERIAL PRIMARY KEY,
    id_compte       INT NOT NULL REFERENCES comptes(id_compte),
    type_carte      VARCHAR(20) NOT NULL,   -- Visa, Mastercard
    plafond         NUMERIC(10,2) NOT NULL,
    date_expiration DATE NOT NULL
);

CREATE TABLE transactions (
    id_transaction  SERIAL PRIMARY KEY,
    id_compte       INT NOT NULL REFERENCES comptes(id_compte),
    id_categorie    INT NOT NULL REFERENCES categories_transaction(id_categorie),
    type_transaction VARCHAR(20) NOT NULL,  -- Débit, Crédit
    montant         NUMERIC(10,2) NOT NULL,
    date_transaction DATE NOT NULL,
    description     VARCHAR(100)
);
-- ---------------------------------------------------------------------
-- 3. INSERTION DES DONNÉES
-- ---------------------------------------------------------------------

-- 3.1 Clients (20 lignes)
INSERT INTO clients (nom, prenom, date_naissance, ville, date_inscription) VALUES
('Dossou', 'Akim', '1990-03-12', 'Cotonou', '2019-01-15'),
('Agossou', 'Fabrice', '1985-07-22', 'Porto-Novo', '2018-05-09'),
('Houngbedji', 'Rosine', '1992-11-03', 'Abomey-Calavi', '2020-02-20'),
('Boko', 'Sandrine', '1988-09-17', 'Parakou', '2017-08-11'),
('Gbenou', 'Marius', '1995-01-29', 'Cotonou', '2021-03-05'),
('Toko', 'Élise', '1991-06-14', 'Bohicon', '2019-09-23'),
('Kpogan', 'Yves', '1983-12-05', 'Cotonou', '2016-11-30'),
('Adjovi', 'Carine', '1994-04-08', 'Porto-Novo', '2020-07-18'),
('Sossou', 'Patrick', '1989-02-27', 'Ouidah', '2018-12-02'),
('Hounsou', 'Linda', '1996-10-19', 'Cotonou', '2022-01-10'),
('Tognon', 'Bruno', '1987-08-30', 'Parakou', '2017-04-25'),
('Aplogan', 'Nadège', '1993-05-16', 'Abomey-Calavi', '2019-06-14'),
('Dansou', 'Cyrille', '1990-09-09', 'Cotonou', '2020-10-01'),
('Mensah', 'Joël', '1986-03-21', 'Lokossa', '2018-02-19'),
('Codjo', 'Anita', '1997-07-11', 'Bohicon', '2021-09-07'),
('Houessou', 'Eric', '1984-01-25', 'Cotonou', '2016-06-13'),
('Zinsou', 'Pauline', '1992-12-30', 'Porto-Novo', '2019-11-22'),
('Bossou', 'Richard', '1991-04-04', 'Parakou', '2020-05-08'),
('Akpovi', 'Stella', '1995-08-23', 'Ouidah', '2021-01-29'),
('Lawani', 'Hervé', '1988-11-15', 'Cotonou', '2017-10-10');


-- 3.2 Catégories de transaction (8 lignes)
INSERT INTO categories_transaction (nom_categorie) VALUES
('Alimentation'),
('Transport'),
('Logement'),
('Santé'),
('Loisirs'),
('Salaire'),
('Virement'),
('Éducation');

-- 3.3 Comptes (25 lignes)
INSERT INTO comptes (id_client, type_compte, solde, date_ouverture) VALUES
(1, 'Courant', 450000.00, '2019-01-20'),
(1, 'Épargne', 1200000.00, '2020-03-01'),
(2, 'Courant', 230000.00, '2018-05-15'),
(3, 'Épargne', 870000.00, '2020-02-25'),
(3, 'Courant', 150000.00, '2020-02-25'),
(4, 'Courant', 95000.00, '2017-08-20'),
(5, 'Épargne', 2300000.00, '2021-03-10'),
(6, 'Courant', 310000.00, '2019-09-28'),
(7, 'Professionnel', 4500000.00, '2016-12-05'),
(7, 'Courant', 600000.00, '2016-12-05'),
(8, 'Courant', 75000.00, '2020-07-22'),
(9, 'Épargne', 980000.00, '2019-01-02'),
(10, 'Courant', 1250000.00, '2022-01-15'),
(11, 'Courant', 60000.00, '2017-05-01'),
(12, 'Épargne', 530000.00, '2019-06-19'),
(13, 'Professionnel', 3100000.00, '2020-10-05'),
(13, 'Courant', 280000.00, '2020-10-05'),
(14, 'Courant', 40000.00, '2018-02-25'),
(15, 'Épargne', 1750000.00, '2021-09-12'),
(16, 'Courant', 890000.00, '2016-06-18'),
(17, 'Courant', 320000.00, '2019-11-27'),
(18, 'Épargne', 410000.00, '2020-05-13'),
(19, 'Courant', 25000.00, '2021-02-03'),
(20, 'Professionnel', 2200000.00, '2017-10-15'),
(20, 'Courant', 510000.00, '2017-10-15');

-- 3.4 Cartes (20 lignes)
INSERT INTO cartes (id_compte, type_carte, plafond, date_expiration) VALUES
(1, 'Visa', 500000.00, '2027-01-31'),
(2, 'Mastercard', 1000000.00, '2026-03-31'),
(3, 'Visa', 300000.00, '2025-05-31'),
(4, 'Mastercard', 700000.00, '2026-02-28'),
(6, 'Visa', 250000.00, '2025-09-30'),
(7, 'Mastercard', 2000000.00, '2027-03-31'),
(8, 'Visa', 400000.00, '2026-09-30'),
(9, 'Mastercard', 3500000.00, '2028-12-31'),
(10, 'Visa', 600000.00, '2026-12-31'),
(11, 'Visa', 100000.00, '2025-07-31'),
(12, 'Mastercard', 800000.00, '2026-01-31'),
(13, 'Visa', 900000.00, '2027-01-15'),
(14, 'Mastercard', 90000.00, '2025-05-01'),
(15, 'Visa', 450000.00, '2026-06-19'),
(16, 'Mastercard', 2500000.00, '2027-10-05'),
(17, 'Visa', 60000.00, '2025-02-25'),
(18, 'Mastercard', 1300000.00, '2026-09-12'),
(19, 'Visa', 700000.00, '2027-06-18'),
(20, 'Visa', 350000.00, '2025-11-27'),
(22, 'Mastercard', 1700000.00, '2028-10-15');

-- 3.5 Transactions (30 lignes)
INSERT INTO transactions (id_compte, id_categorie, type_transaction, montant, date_transaction, description) VALUES
(1, 1, 'Débit', 15000.00, '2024-01-05', 'Achat supermarché'),
(1, 6, 'Crédit', 350000.00, '2024-01-31', 'Salaire janvier'),
(2, 7, 'Crédit', 200000.00, '2024-02-02', 'Virement épargne'),
(3, 2, 'Débit', 8000.00, '2024-01-10', 'Taxi'),
(3, 6, 'Crédit', 180000.00, '2024-01-30', 'Salaire janvier'),
(4, 4, 'Débit', 25000.00, '2024-02-14', 'Consultation médicale'),
(5, 1, 'Débit', 12000.00, '2024-02-15', 'Marché Dantokpa'),
(6, 5, 'Débit', 30000.00, '2024-01-20', 'Cinéma et sorties'),
(7, 6, 'Crédit', 900000.00, '2024-01-31', 'Salaire entreprise'),
(8, 6, 'Crédit', 250000.00, '2024-01-29', 'Salaire janvier'),
(9, 8, 'Débit', 7000.00, '2024-02-01', 'Achat divers'),
(4, 3, 'Débit', 60000.00, '2024-02-05', 'Loyer'),
(10, 6, 'Crédit', 220000.00, '2024-01-31', 'Salaire janvier'),
(11, 7, 'Crédit', 50000.00, '2024-02-10', 'Virement reçu'),
(12, 1, 'Débit', 9000.00, '2024-02-11', 'Courses'),
(13, 6, 'Crédit', 200000.00, '2024-01-31', 'Salaire janvier'),
(14, 8, 'Débit', 45000.00, '2024-02-18', 'Frais de formation'),
(15, 6, 'Crédit', 1100000.00, '2024-01-31', 'Revenus professionnels'),
(16, 4, 'Débit', 18000.00, '2024-02-20', 'Pharmacie'),
(17, 2, 'Débit', 5000.00, '2024-02-21', 'Carburant'),
(18, 6, 'Crédit', 150000.00, '2024-01-30', 'Salaire janvier'),
(19, 3, 'Débit', 40000.00, '2024-02-03', 'Loyer'),
(20, 1, 'Débit', 11000.00, '2024-02-06', 'Alimentation'),
(21, 5, 'Débit', 22000.00, '2024-02-08', 'Loisirs week-end'),
(22, 6, 'Crédit', 700000.00, '2024-01-31', 'Salaire entreprise'),
(23, 7, 'Crédit', 100000.00, '2024-02-12', 'Virement familial'),
(24, 4, 'Débit', 13000.00, '2024-02-13', 'Soins médicaux'),
(25, 6, 'Crédit', 280000.00, '2024-01-31', 'Salaire janvier'),
(1, 5, 'Débit', 20000.00, '2024-02-22', 'Sortie restaurant'),
(7, 3, 'Débit', 150000.00, '2024-02-25', 'Loyer bureau');

/*  Quel est le solde total détenu par la banque, tous comptes confondus ?*/