CREATE OR REPLACE VIEW PropositionsRecentes AS
SELECT P.idProposition, P.titreProposition, P.descProposition, P.popularite
FROM Proposition P
ORDER BY P.idProposition DESC;

CREATE OR REPLACE VIEW PropositionsPopulaires AS
SELECT P.idProposition, P.titreProposition, P.descProposition, P.popularite
FROM Proposition P
ORDER BY P.popularite DESC;

CREATE OR REPLACE VIEW GroupesUtilisateur AS
SELECT G.idGroupe, G.nomGroupe, M.idMembre
FROM Groupe G
INNER JOIN Fait_partie_de FPD ON G.idGroupe = FPD.idGroupe
INNER JOIN Membre M ON FPD.idMembre = M.idMembre;

CREATE OR REPLACE VIEW PropositionsUtilisateur AS
SELECT P.idProposition, P.titreProposition, P.descProposition, P.popularite, M.idMembre
FROM Proposition P
INNER JOIN Membre M ON P.idProposition = M.idProposition;

CREATE OR REPLACE VIEW MembresGroupe AS
SELECT G.idGroupe, G.nomGroupe, M.idMembre, M.roleMembre
FROM Groupe G
INNER JOIN Fait_partie_de FPD ON G.idGroupe = FPD.idGroupe
INNER JOIN Membre M ON FPD.idMembre = M.idMembre;

