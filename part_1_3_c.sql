CREATE VIEW very_active_users_may AS
WITH may_sessions AS (
    SELECT 
        user_id, 
        COUNT(*) AS session_count
    FROM 
        session_table
    WHERE 
        EXTRACT(MONTH FROM connected_at) = 5
    GROUP BY 
        user_id
),
average_sessions AS (
    SELECT 
        AVG(session_count) * 0.60 AS avg_session_count
    FROM 
        may_sessions
)
SELECT 
    u.username
FROM 
    may_sessions ms
JOIN 
    user_table u ON ms.user_id = u.user_id
JOIN 
    average_sessions avgs ON ms.session_count > avgs.avg_session_count;
