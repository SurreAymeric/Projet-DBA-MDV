-- Créer la vue tp_and_notebook
CREATE VIEW tp_and_notebook AS
SELECT n.notebook_id, n.tp_id, n.notebook_name, t.tp_name
FROM notebooks n
JOIN tp t ON n.tp_id = t.tp_id;