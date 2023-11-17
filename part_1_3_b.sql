ALTER TABLE session_table
ADD COLUMN connected_at_month INTEGER;

UPDATE session_table
SET connected_at_month = EXTRACT(MONTH FROM connected_at);
