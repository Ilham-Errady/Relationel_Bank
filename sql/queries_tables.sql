-- DROP TABLE IF EXISTS Transactions CASCADE;
-- DROP TABLE IF EXISTS Comptes CASCADE;
-- DROP TABLE IF EXISTS Clients CASCADE;
-- DROP TABLE IF EXISTS Produits CASCADE;
-- DROP TABLE IF EXISTS Agences CASCADE;
-- DROP TABLE IF EXISTS Segments CASCADE;


CREATE TABLE  IF NOT EXISTS Segments (
  segment_id SERIAL PRIMARY KEY,
  nom_segment VARCHAR(50)
);


CREATE TABLE IF NOT EXISTS Agences (
  agence_id SERIAL PRIMARY KEY AUTO INCREMENT,
  nom_agence VARCHAR(100)
);


CREATE TABLE IF NOT EXISTS Produits (
  produit_id SERIAL PRIMARY KEY,
  type_produit VARCHAR(50)
);


CREATE TABLE IF NOT EXISTS Clients (
  client_id VARCHAR(50) PRIMARY KEY,
  nom_client VARCHAR(100),
  score_credit INT,
  categorie_risque VARCHAR(50),
  segment_id INT REFERENCES Segments(segment_id)
);


CREATE TABLE IF NOT EXISTS Comptes (
  compte_id SERIAL PRIMARY KEY,
  numero_compte VARCHAR(50) UNIQUE,
  solde_net DECIMAL(15, 2),
  client_id VARCHAR(50) REFERENCES Clients(client_id),
  produit_id INT REFERENCES Produits(produit_id),
  agence_id INT REFERENCES Agences(agence_id)
);

CREATE TABLE IF NOT EXISTS Transactions (
  transaction_id VARCHAR(50) PRIMARY KEY, 
  compte_id INT REFERENCES Comptes(compte_id),
  date_transaction TIMESTAMP,
  montant DECIMAL(15, 2),
  devise VARCHAR(10),
  taux_change_eur DECIMAL(10, 5),
  montant_eur DECIMAL(15, 2), 
  type_operation VARCHAR(50),
  statut VARCHAR(50),
  is_anomaly BOOLEAN DEFAULT FALSE,
  is_outlier_montant BOOLEAN DEFAULT FALSE,  
  is_rejected BOOLEAN DEFAULT FALSE       
);