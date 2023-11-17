CREATE TABLE session_count (
    session_count_id SERIAL PRIMARY KEY,
    user_id INT NOT NULL,
    session_count_value INT NOT NULL,
    FOREIGN KEY (user_id) REFERENCES user_table(user_id)
);


-- Fonction du trigger
CREATE OR REPLACE FUNCTION update_session_count()
RETURNS TRIGGER AS $$
BEGIN
    -- Vérifier si l'utilisateur existe déjà dans session_count
    IF EXISTS (SELECT 1 FROM session_count WHERE user_id = NEW.user_id) THEN
        -- Mettre à jour la valeur de session_count
        UPDATE session_count SET session_count_value = session_count_value + 1
        WHERE user_id = NEW.user_id;
    ELSE
        -- Insérer une nouvelle ligne pour l'utilisateur
        INSERT INTO session_count (user_id, session_count_value)
        VALUES (NEW.user_id, 1);
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Création du trigger
CREATE TRIGGER trigger_update_session_count
AFTER INSERT ON session_table
FOR EACH ROW
EXECUTE FUNCTION update_session_count();


-- Insérer des données test dans session_table
INSERT INTO session_table (user_id, connected_at) VALUES (1, CURRENT_TIMESTAMP);
INSERT INTO session_table (user_id, connected_at) VALUES (1, CURRENT_TIMESTAMP);
INSERT INTO session_table (user_id, connected_at) VALUES (2, CURRENT_TIMESTAMP);

-- Vérifier les données dans session_count
SELECT * FROM session_count;