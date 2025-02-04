CREATE OR REPLACE VIEW PropositionsRecentes AS
SELECT P.idProposition, P.titreProposition, P.descProposition, P.popularite, P.validee, P.idBudget
FROM Proposition P
ORDER BY P.idProposition DESC;

/*CREATE OR REPLACE VIEW PropositionsPopulaires AS
SELECT P.idProposition, P.titreProposition, P.descProposition, P.popularite, P.validee, P.idBudget
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

CREATE OR REPLACE VIEW PropositionsDetaillees AS
SELECT 
    p.idProposition,
    p.titreProposition,
    p.descProposition,
    p.popularite,
    p.idBudget,
    t.nomTheme,
    g.idGroupe,
    g.nomGroupe,
    s.idScrutin,
    s.natureScrutin,
    s.dureeScrutin,
    s.dureeDiscussion,
    s.resultatScrutin,
    b.limiteBudgetGlobal AS cout,
    SUM(CASE WHEN v.valeurVote = 1 THEN 1 ELSE 0 END) AS Pour,
    SUM(CASE WHEN v.valeurVote = -1 THEN 1 ELSE 0 END) AS Contre
FROM Proposition p
JOIN A_pour_theme apt ON p.idProposition = apt.idProposition
JOIN Theme t ON apt.idTheme = t.idTheme
JOIN Budget b ON p.idBudget = b.idBudget
JOIN Groupe g ON b.idGroupe = g.idGroupe
JOIN Scrutin s ON p.idProposition = s.idProposition
JOIN Vote v ON s.idScrutin = v.idScrutin
GROUP BY
    p.idProposition,
    p.titreProposition,
    p.descProposition,
    p.popularite,
    p.idBudget,
    t.nomTheme,
    g.idGroupe,
    g.nomGroupe,
    s.idScrutin,
    s.natureScrutin,
    s.dureeScrutin,
    s.dureeDiscussion,
    s.resultatScrutin,
    b.limiteBudgetGlobal
ORDER BY p.popularite DESC;

CREATE OR REPLACE VIEW PropositionsGroupe AS
SELECT 
    g.idGroupe,
    p.idProposition,
    p.titreProposition,
    p.descProposition,
    p.popularite,
    p.idBudget,
    t.nomTheme,
    b.limiteBudgetGlobal
FROM Groupe g
JOIN Budget b ON b.idGroupe = g.idGroupe
JOIN Proposition p ON p.idBudget = b.idBudget
JOIN A_pour_theme apt ON p.idProposition = apt.idProposition
JOIN Theme t ON apt.idTheme = t.idTheme
ORDER BY p.idProposition DESC;

CREATE OR REPLACE VIEW ScrutinsGroupe AS
SELECT 
    g.idGroupe,
    s.idScrutin,
    s.natureScrutin,
    s.dureeScrutin,
    s.dureeDiscussion,
    s.resultatScrutin,
    s.idProposition,
    p.titreProposition,
    p.descProposition,
    p.popularite,
    p.idBudget,
    t.nomTheme,
    b.limiteBudgetGlobal,
    SUM(CASE WHEN v.valeurVote = 1 THEN 1 ELSE 0 END) AS Pour,
    SUM(CASE WHEN v.valeurVote = -1 THEN 1 ELSE 0 END) AS Contre
FROM Scrutin s
JOIN Proposition p ON s.idProposition = p.idProposition
JOIN Budget b ON p.idBudget = b.idBudget
JOIN Groupe g ON b.idGroupe = g.idGroupe
JOIN A_pour_theme apt ON p.idProposition = apt.idProposition
JOIN Theme t ON apt.idTheme = t.idTheme
JOIN Vote v ON s.idScrutin = v.idScrutin
GROUP BY
    g.idGroupe,
    s.idScrutin,
    s.natureScrutin,
    s.dureeScrutin,
    s.dureeDiscussion,
    s.resultatScrutin,
    s.idProposition,
    p.titreProposition,
    p.descProposition,
    p.popularite,
    p.idBudget,
    t.nomTheme,
    b.limiteBudgetGlobal
ORDER BY g.idGroupe, s.idScrutin DESC;
