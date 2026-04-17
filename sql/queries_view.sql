CREATE OR REPLACE VIEW v_alertes_transactions AS
SELECT 
    t.transaction_id,
    t.date_transaction,
    t.montant,
    t.compte_id,
    t.is_anomaly,
    t.is_outlier_montant,
    t.statut
FROM transactions t
WHERE t.is_anomaly = TRUE 
   OR t.is_outlier_montant = TRUE;


   CREATE OR REPLACE VIEW v_performance_agences AS
SELECT 
    a.nom_agence,
    COUNT(t.transaction_id) AS nombre_transactions,
    ROUND(AVG(t.montant_eur)::numeric, 2) AS moyenne_montants,
    COUNT(CASE WHEN t.is_rejected = TRUE THEN 1 END) AS nombre_rejets
FROM agences a
JOIN comptes c ON a.agence_id = c.agence_id
JOIN transactions t ON c.compte_id = t.compte_id
GROUP BY a.nom_agence;




CREATE OR REPLACE VIEW v_infos_clients_complet AS
SELECT 
    c.compte_id,             
    cl.client_id,
    cl.score_credit,
    cl.categorie_risque,
    s.nom_segment,
    p.type_produit,
    a.nom_agence,
    c.solde_avant          
FROM comptes c
LEFT JOIN clients cl ON c.client_id = cl.client_id
LEFT JOIN segments s ON cl.segment_id = s.segment_id
LEFT JOIN produits p ON c.produit_id = p.produit_id
LEFT JOIN agences a ON c.agence_id = a.agence_id;