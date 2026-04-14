-- DROP TABLE IF EXISTS Transactions CASCADE;
-- DROP TABLE IF EXISTS Comptes CASCADE;
-- DROP TABLE IF EXISTS Clients CASCADE;
-- DROP TABLE IF EXISTS Produits CASCADE;
-- DROP TABLE IF EXISTS Agences CASCADE;
-- DROP TABLE IF EXISTS Segments CASCADE;



CREATE TABLE segments (segment_id INT PRIMARY KEY, nom_segment VARCHAR(50));
CREATE TABLE agences (agence_id INT PRIMARY KEY, nom_agence VARCHAR(100));
CREATE TABLE produits (produit_id INT PRIMARY KEY, type_produit VARCHAR(100));


CREATE TABLE clients (
    client_id VARCHAR(50) PRIMARY KEY,
    nom_client VARCHAR(100),
    score_credit FLOAT,    
    categorie_risque VARCHAR(50),
    segment_id INT REFERENCES segments(segment_id)
);

CREATE TABLE comptes (
    compte_id VARCHAR(50) PRIMARY KEY,
    client_id VARCHAR(50) REFERENCES clients(client_id),
    type_compte VARCHAR(100),
    solde_avant FLOAT,
    date_formatted VARCHAR(20),
    agence_id INT REFERENCES agences(agence_id),    
    produit_id INT REFERENCES produits(produit_id)
);


CREATE TABLE transactions (
    transaction_id VARCHAR(50) PRIMARY KEY,
    compte_id VARCHAR(50) REFERENCES comptes(compte_id),
    date_transaction TIMESTAMP,
    montant FLOAT,
    devise VARCHAR(10),
    taux_change_eur FLOAT,
    montant_eur FLOAT,
    type_operation VARCHAR(50),
    statut VARCHAR(50),
    is_anomaly BOOLEAN,
    is_outlier_montant BOOLEAN,
    is_rejected BOOLEAN
);