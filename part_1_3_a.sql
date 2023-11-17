CREATE VIEW session_and_user AS
SELECT 
    s.session_id,
    s.user_id,
    s.connected_at,
    u.firstname,
    u.lastname,
    u.email,
    u.username,
    u.password,
    u.created_at
FROM 
    session_table s
JOIN 
    user_table u ON s.user_id = u.user_id;
