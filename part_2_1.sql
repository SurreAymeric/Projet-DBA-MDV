CREATE TABLE subscription_table (
    subscription_id SERIAL PRIMARY KEY,
    subscribed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    user_id INT,
    paid INT,
    subscription_plan VARCHAR(255),
    FOREIGN KEY (user_id) REFERENCES user_table(user_id)
);

INSERT INTO subscription_table (user_id, subscribed_at, paid, subscription_plan)
SELECT 
    s.user_id, 
    s.last_session + interval '1 day' * ROUND(RANDOM() * 30), -- Ajoute de 1 à 30 jours à la dernière session
    CASE 
        WHEN plan = 'monthly' THEN 10 
        WHEN plan = 'yearly' THEN 100 
        ELSE 1000 
    END AS paid,
    plan AS subscription_plan
FROM 
    (SELECT user_id, MAX(connected_at) AS last_session FROM session_table GROUP BY user_id) AS s,
    (SELECT 
        CASE 
            WHEN RANDOM() < 0.33 THEN 'monthly' 
            WHEN RANDOM() < 0.66 THEN 'yearly' 
            ELSE 'lifetime' 
        END AS plan
    ) AS random_plan
LIMIT 60;
