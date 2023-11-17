CREATE VIEW subscription_per_plan_per_month AS
SELECT 
    TO_CHAR(subscribed_at, 'Mon') AS month,
    subscription_plan,
    SUM(paid) AS total_paid,
    COUNT(*) AS total_subscriptions
FROM 
    subscription_table
GROUP BY 
    TO_CHAR(subscribed_at, 'Mon'), subscription_plan, EXTRACT(MONTH FROM subscribed_at)
ORDER BY 
    EXTRACT(MONTH FROM subscribed_at), subscription_plan;
