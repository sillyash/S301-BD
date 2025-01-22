CREATE OR REPLACE VIEW Propositions_Recentes AS
SELECT *
FROM Proposition
ORDER BY dateProp DESC;


CREATE OR REPLACE VIEW Propositions_Populaires AS
SELECT *
FROM Proposition
ORDER BY popularite DESC;
