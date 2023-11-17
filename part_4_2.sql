CREATE TABLE username_history (
    username_history_id SERIAL PRIMARY KEY,
    user_id INT NOT NULL,
    username_new VARCHAR(255) NOT NULL,
    FOREIGN KEY (user_id) REFERENCES user_table(user_id)
);

-- Fonction du trigger
CREATE OR REPLACE FUNCTION log_username_change()
RETURNS TRIGGER AS $$
BEGIN
    -- Insérer une nouvelle ligne dans username_history pour chaque insertion/mise à jour
    INSERT INTO username_history (user_id, username_new)
    VALUES (NEW.user_id, NEW.username);

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Création du trigger pour INSERT
CREATE TRIGGER trigger_update_username_after_insert
AFTER INSERT ON user_table
FOR EACH ROW
EXECUTE FUNCTION log_username_change();

-- Création du trigger pour UPDATE
CREATE TRIGGER trigger_update_username_after_update
AFTER UPDATE OF username ON user_table
FOR EACH ROW
EXECUTE FUNCTION log_username_change();


-- Test avec des INSERT
INSERT INTO user_table (firstname, lastname, email, username, password, created_at)
VALUES ('Jo', 'Dop', 'jo.dop@example.com', 'jodop', 'password123', CURRENT_TIMESTAMP);

INSERT INTO user_table (firstname, lastname, email, username, password, created_at)
VALUES ('Jane', 'Smith', 'jane.smith@example.com', 'janesmith', 'password456', CURRENT_TIMESTAMP);

INSERT INTO user_table (firstname, lastname, email, username, password, created_at)
VALUES ('Alice', 'Johnson', 'alice.johnson@example.com', 'alicejohnson', 'password789', CURRENT_TIMESTAMP);

INSERT INTO user_table (firstname, lastname, email, username, password, created_at)
VALUES ('Bob', 'Williams', 'bob.williams@example.com', 'bobwilliams', 'password101', CURRENT_TIMESTAMP);

INSERT INTO user_table (firstname, lastname, email, username, password, created_at)
VALUES ('Charlie', 'Brown', 'charlie.brown@example.com', 'charliebrown', 'password102', CURRENT_TIMESTAMP);

-- Test avec des UPDATE
UPDATE user_table SET username = 'johndoeupdated' WHERE user_id = 1;
UPDATE user_table SET username = 'janesmithupdated' WHERE user_id = 2;
UPDATE user_table SET username = 'alicejohnsonupdated' WHERE user_id = 3;
UPDATE user_table SET username = 'bobwilliamsupdated' WHERE user_id = 4;
UPDATE user_table SET username = 'charliebrownupdated' WHERE user_id = 5;


-- Vérifier les données dans username_history
SELECT * FROM username_history;
