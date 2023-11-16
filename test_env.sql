-- Créer la table tp
CREATE TABLE tp (
    tp_id SERIAL PRIMARY KEY,
    tp_name VARCHAR(50) NOT NULL
);

-- Créer la table notebooks
CREATE TABLE notebooks (
    notebook_id SERIAL PRIMARY KEY,
    tp_id INT,
    notebook_name VARCHAR(255) NOT NULL,
    FOREIGN KEY (tp_id) REFERENCES tp(tp_id)
);

-- Insérer des données dans la table tp
INSERT INTO tp (tp_name) VALUES ('tp1'), ('tp2');

-- Insérer des données dans la table notebooks
-- Remarque : Vous devez remplacer les identifiants tp_id avec les valeurs correctes après insertion
INSERT INTO notebooks (tp_id, notebook_name) VALUES 
(1, '0_sql_intro_northwind.ipynb'),
(2, 'un_autre_notebook.ipynb');