CREATE OR REPLACE VIEW PropositionsRecentes AS
SELECT P.idProposition, P.titreProposition, P.descProposition, P.popularite, P.validee, P.idBudget
FROM Proposition P
ORDER BY P.idProposition DESC;

CREATE OR REPLACE VIEW PropositionsPopulaires AS
SELECT p.idProposition, g.nomGroupe, t.nomTheme, p.titreProposition, p.descProposition, p.popularite
FROM Proposition p
JOIN A_pour_theme apt ON p.idProposition = apt.idProposition
JOIN Theme t ON apt.idTheme = t.idTheme
JOIN Budget b ON p.idBudget = b.idBudget
JOIN Groupe g ON b.idGroupe = g.idGroupe
ORDER BY p.popularite DESC;

CREATE OR REPLACE VIEW PropositionsValidees AS
SELECT p.idProposition, g.nomGroupe, t.nomTheme,p.titreProposition, p.descProposition, p.popularite AS Popularite, p.validee
FROM Proposition p
JOIN A_pour_theme apt ON p.idProposition = apt.idProposition
JOIN Theme t ON apt.idTheme = t.idTheme
JOIN Budget b ON p.idBudget = b.idBudget
JOIN Groupe g ON b.idGroupe = g.idGroupe
WHERE p.validee = TRUE;

CREATE OR REPLACE VIEW GroupesUtilisateur AS
SELECT FPD.loginInter, G.idGroupe, G.nomGroupe, R.nomRole, R.idRole
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

CREATE OR REPLACE VIEW PropositionsDetaillees AS
SELECT 
    p.idProposition,
    p.titreProposition,
    p.descProposition,
    p.popularite,
    p.coutProp AS cout,
    p.idBudget,
    t.nomTheme,
    g.idGroupe,
    g.nomGroupe,
    s.idScrutin,
    s.natureScrutin,
    s.dureeScrutin,
    s.dureeDiscussion,
    s.resultatScrutin,
    b.limiteBudgetGlobal,
    b.titreBudget,
    SUM(CASE WHEN v.valeurVote = 1 THEN 1 ELSE 0 END) AS Pour,
    SUM(CASE WHEN v.valeurVote = -1 THEN 1 ELSE 0 END) AS Contre
FROM Proposition p
JOIN A_pour_theme apt ON p.idProposition = apt.idProposition
JOIN Theme t ON apt.idTheme = t.idTheme
JOIN Budget b ON p.idBudget = b.idBudget
JOIN Groupe g ON b.idGroupe = g.idGroupe
LEFT JOIN Scrutin s ON p.idProposition = s.idProposition
LEFT JOIN Vote v ON s.idScrutin = v.idScrutin
GROUP BY p.idProposition
ORDER BY p.idProposition DESC;

CREATE OR REPLACE VIEW PropositionsGroupe AS
SELECT 
    g.idGroupe,
    p.idProposition,
    p.titreProposition,
    p.descProposition,
    p.coutProp AS cout,
    p.popularite,
    p.idBudget,
    t.nomTheme,
    b.limiteBudgetGlobal,
    b.titreBudget
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
    p.coutProp AS cout,
    p.popularite,
    p.idBudget,
    t.nomTheme,
    b.limiteBudgetGlobal,
    b.titreBudget,
    SUM(CASE WHEN v.valeurVote = 1 THEN 1 ELSE 0 END) AS Pour,
    SUM(CASE WHEN v.valeurVote = -1 THEN 1 ELSE 0 END) AS Contre
FROM Scrutin s
JOIN Proposition p ON s.idProposition = p.idProposition
JOIN Budget b ON p.idBudget = b.idBudget
JOIN Groupe g ON b.idGroupe = g.idGroupe
JOIN A_pour_theme apt ON p.idProposition = apt.idProposition
JOIN Theme t ON apt.idTheme = t.idTheme
LEFT JOIN Vote v ON s.idScrutin = v.idScrutin
GROUP BY g.idGroupe
ORDER BY g.idGroupe, s.idScrutin DESC;

CREATE OR REPLACE VIEW BudgetsGroupe AS
SELECT 
    g.idGroupe,
    b.idBudget,
    b.limiteBudgetGlobal,
    b.titreBudget
FROM Groupe g
JOIN Budget b ON b.idGroupe = g.idGroupe
GROUP BY g.idGroupe, b.idBudget, b.limiteBudgetGlobal, b.titreBudget
ORDER BY g.idGroupe, b.idBudget DESC;

CREATE OR REPLACE VIEW ThemesGroupe AS
SELECT 
    g.idGroupe,
    t.idTheme,
    t.nomTheme
FROM Groupe g
JOIN Theme t ON t.idGroupe = g.idGroupe
GROUP BY g.idGroupe, t.idTheme, t.nomTheme
ORDER BY g.idGroupe, t.idTheme DESC;
