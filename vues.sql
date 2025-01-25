CREATE OR REPLACE VIEW PropositionsRecentes AS
SELECT P.idProposition, P.titreProposition, P.descProposition, P.popularite, P.validee, P.idBudget
FROM Proposition P
ORDER BY P.idProposition DESC;

/*CREATE OR REPLACE VIEW PropositionsPopulaires AS
SELECT P.idProposition, P.titreProposition, P.descProposition, P.popularite, P.validee
FROM Proposition P
ORDER BY P.popularite DESC;
*/

CREATE OR REPLACE VIEW PropositionsPopulaires AS
SELECT p.idProposition, g.nomGroupe, t.nomTheme, p.titreProposition, p.descProposition, p.popularite
FROM Groupe g
JOIN Theme t ON g.idGroupe = t.idGroupe
JOIN A_pour_theme apt ON t.idTheme = apt.idTheme
JOIN Proposition p ON apt.idProposition = p.idProposition
ORDER BY p.popularite DESC;

CREATE OR REPLACE VIEW PropositionsValidees AS
SELECT p.idProposition, g.nomGroupe, t.nomTheme,p.titreProposition, p.descProposition, p.popularite AS Popularite, p.validee
FROM Groupe g
INNER JOIN Theme t ON g.idGroupe = t.idGroupe
INNER JOIN A_pour_theme apt ON t.idTheme = apt.idTheme
INNER JOIN Proposition p ON apt.idProposition = p.idProposition
WHERE p.validee = TRUE;

CREATE OR REPLACE VIEW GroupesUtilisateur AS
SELECT FPD.loginInter, G.idGroupe, G.nomGroupe, R.nomRole 
FROM Fait_partie_de FPD 
INNER JOIN Groupe G ON FPD.idGroupe = G.idGroupe 
INNER JOIN Role R ON FPD.idRole = R.idRole;

CREATE OR REPLACE VIEW PropositionsUtilisateur AS
SELECT PR.loginInter, P.idProposition, P.titreProposition, P.descProposition, P.popularite, P.dateProp, P.validee
FROM Propose PR 
INNER JOIN Proposition P ON PR.idProposition = P.idProposition;

CREATE OR REPLACE VIEW MembresGroupe AS
SELECT G.idGroupe, G.nomGroupe, I.loginInter, I.nomInter, I.prenomInter, R.nomRole 
FROM Fait_partie_de FPD 
INNER JOIN Groupe G ON FPD.idGroupe = G.idGroupe 
INNER JOIN Internaute I ON FPD.loginInter = I.loginInter 
INNER JOIN Role R ON FPD.idRole = R.idRole;

CREATE OR REPLACE VIEW BudgetsParThematique AS
SELECT p.idProposition, g.nomGroupe, t.nomTheme, b.limiteBudgetGlobal, SUM(p.popularite) AS PopulariteTotale
FROM Groupe g
INNER JOIN Theme t ON g.idGroupe = t.idGroupe
INNER JOIN Proposition p ON p.idProposition = (SELECT idProposition FROM A_pour_theme WHERE idTheme = t.idTheme)
INNER JOIN Budget b ON p.idBudget = b.idBudget
GROUP BY g.nomGroupe, t.nomTheme, b.limiteBudgetGlobal;


// A ajouter dans la vraie base ;

CREATE OR REPLACE VIEW PropositionsDetaillees AS
SELECT 
    p.idProposition,
    p.titreProposition,
    p.descProposition,
    p.popularite,
    p.idBudget,
    t.nomTheme,
    g.nomGroupe,
    b.limiteBudgetGlobal AS cout
FROM Proposition p
JOIN A_pour_theme apt ON p.idProposition = apt.idProposition
JOIN Theme t ON apt.idTheme = t.idTheme
JOIN Groupe g ON t.idGroupe = g.idGroupe
JOIN Budget b ON p.idBudget = b.idBudget
ORDER BY p.popularite DESC;
