-- Création de la table user_table
CREATE TABLE user_table (
    user_id SERIAL PRIMARY KEY,
    firstname VARCHAR(255),
    lastname VARCHAR(255),
    email VARCHAR(255) UNIQUE,
    username VARCHAR(255) UNIQUE,
    password VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Ajout des contraintes sur les colonnes
ALTER TABLE user_table
ADD CONSTRAINT username_length_check CHECK (LENGTH(username) > 8),
ADD CONSTRAINT password_length_check CHECK (LENGTH(password) > 8);

-- Création de la table user_email_verification
CREATE TABLE user_email_verification (
    uev_id SERIAL PRIMARY KEY,
    user_id INT,
    verified_at TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES user_table(user_id)
);

-- Création de la table session_table
CREATE TABLE session_table (
    session_id SERIAL PRIMARY KEY,
    user_id INT,
    connected_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES user_table(user_id)
);
