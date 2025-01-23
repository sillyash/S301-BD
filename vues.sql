CREATE OR REPLACE VIEW PropositionsRecentes AS
SELECT P.idProposition, P.titreProposition, P.descProposition, P.popularite
FROM Proposition P
ORDER BY P.idProposition DESC;

CREATE OR REPLACE VIEW PropositionsPopulaires AS
SELECT P.idProposition, P.titreProposition, P.descProposition, P.popularite
FROM Proposition P
ORDER BY P.popularite DESC;

CREATE OR REPLACE VIEW GroupesUtilisateur AS
SELECT FPD.loginInter, G.idGroupe, G.nomGroupe, R.nomRole 
FROM Fait_partie_de FPD 
INNER JOIN Groupe G ON FPD.idGroupe = G.idGroupe 
INNER JOIN Role R ON FPD.idRole = R.idRole;

CREATE OR REPLACE VIEW PropositionsUtilisateur AS
SELECT PR.loginInter, P.idProposition, P.titreProposition, P.descProposition, P.popularite, P.dateProp 
FROM Propose PR 
INNER JOIN Proposition P ON PR.idProposition = P.idProposition;

CREATE OR REPLACE VIEW MembresGroupe AS
SELECT G.idGroupe, G.nomGroupe, I.loginInter, I.nomInter, I.prenomInter, R.nomRole 
FROM Fait_partie_de FPD 
INNER JOIN Groupe G ON FPD.idGroupe = G.idGroupe 
INNER JOIN Internaute I ON FPD.loginInter = I.loginInter 
INNER JOIN Role R ON FPD.idRole = R.idRole;


