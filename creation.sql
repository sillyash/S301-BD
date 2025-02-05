DROP TABLE IF EXISTS Vote;
DROP TABLE IF EXISTS Propose;
DROP TABLE IF EXISTS Est_envoye_au_membre;
DROP TABLE IF EXISTS Concerne_la_notification;
DROP TABLE IF EXISTS Reagit;
DROP TABLE IF EXISTS A_pour_reaction;
DROP TABLE IF EXISTS Fait_partie_de;
DROP TABLE IF EXISTS A_pour_theme;
DROP TABLE IF EXISTS Signalement;
DROP TABLE IF EXISTS Theme;
DROP TABLE IF EXISTS Scrutin;
DROP TABLE IF EXISTS Commentaire;
DROP TABLE IF EXISTS Role;
DROP TABLE IF EXISTS Notification;
DROP TABLE IF EXISTS Reaction;
DROP TABLE IF EXISTS Internaute;
DROP TABLE IF EXISTS Proposition;
DROP TABLE IF EXISTS Budget;
DROP TABLE IF EXISTS Groupe;

CREATE TABLE Groupe(
   idGroupe INT AUTO_INCREMENT,
   nomGroupe VARCHAR(50)  NOT NULL,
   descGroupe VARCHAR(200)  NOT NULL,
   couleurGroupe VARCHAR(10)  NOT NULL,
   ppGroupe BLOB,
   PRIMARY KEY(idGroupe),
   UNIQUE(nomGroupe),
   UNIQUE(descGroupe)
);

/*
CREATE TABLE Theme(
   idTheme INT AUTO_INCREMENT,
   nomTheme VARCHAR(50)  NOT NULL,
   budgetTheme INT NOT NULL,
   PRIMARY KEY(idTheme),
   UNIQUE(nomTheme)
);
*/

CREATE TABLE Theme(
   idTheme INT AUTO_INCREMENT,
   nomTheme VARCHAR(50)  NOT NULL,
   budgetTheme INT NOT NULL,
   idGroupe INT NOT NULL,
   PRIMARY KEY(idTheme),
   UNIQUE(nomTheme),
   FOREIGN KEY(idGroupe) REFERENCES Groupe(idGroupe)
);

CREATE TABLE Internaute(
   loginInter VARCHAR(50) ,
   nomInter VARCHAR(50)  NOT NULL,
   prenomInter VARCHAR(50)  NOT NULL,
   emailInter VARCHAR(50)  NOT NULL,
   mdpInter VARCHAR(90)  NOT NULL,
   adrInter VARCHAR(50) ,
   compteValide BOOLEAN NOT NULL DEFAULT False,
   PRIMARY KEY(loginInter)
);

CREATE TABLE Budget(
   idBudget INT AUTO_INCREMENT,
   titreBudget VARCHAR(50)  NOT NULL,
   limiteBudgetGlobal INT NOT NULL,
   idGroupe INT NOT NULL,
   PRIMARY KEY(idBudget),
   UNIQUE(idGroupe),
   FOREIGN KEY(idGroupe) REFERENCES Groupe(idGroupe) ON DELETE CASCADE
);

CREATE TABLE Reaction(
   idReaction INT AUTO_INCREMENT,
   typeReaction INT NOT NULL,
   PRIMARY KEY(idReaction)
);

CREATE TABLE Notification(
   idNotification INT AUTO_INCREMENT,
   typeNotification VARCHAR(50)  NOT NULL,
   messageNotification VARCHAR(50)  NOT NULL,
   etatNotification VARCHAR(50) ,
   frequenceNotification VARCHAR(50) ,
   PRIMARY KEY(idNotification)
);

CREATE TABLE Role(
   idRole INT AUTO_INCREMENT,
   nomRole VARCHAR(50)  NOT NULL,
   PRIMARY KEY(idRole),
   UNIQUE(nomRole)
);

CREATE TABLE Proposition(
   idProposition INT AUTO_INCREMENT,
   descProposition VARCHAR(1000) ,
   titreProposition VARCHAR(200)  NOT NULL,
   popularite INT NOT NULL,
   dateProp DATETIME NOT NULL,
   validee BOOLEAN NOT NULL,
   coutProp INT NOT NULL,
   confirmee BOOLEAN DEFAULT FALSE,
   idBudget INT NOT NULL,
   PRIMARY KEY(idProposition),
   FOREIGN KEY(idBudget) REFERENCES Budget(idBudget) ON DELETE CASCADE
);

CREATE TABLE Commentaire(
   idCommentaire INT AUTO_INCREMENT,
   descCommentaire VARCHAR(300)  NOT NULL,
   dateCommentaire DATETIME NOT NULL,
   loginInter VARCHAR(50)  NOT NULL,
   idProposition INT NOT NULL,
   PRIMARY KEY(idCommentaire),
   FOREIGN KEY(loginInter) REFERENCES Internaute(loginInter) ON DELETE CASCADE,
   FOREIGN KEY(idProposition) REFERENCES Proposition(idProposition) ON DELETE CASCADE
);

CREATE TABLE Scrutin(
   idScrutin INT AUTO_INCREMENT,
   dureeDiscussion INT NOT NULL,
   dureeScrutin INT NOT NULL,
   natureScrutin VARCHAR(50)  NOT NULL,
   resultatScrutin VARCHAR(50) ,
   idProposition INT NOT NULL,
   PRIMARY KEY(idScrutin),
   FOREIGN KEY(idProposition) REFERENCES Proposition(idProposition) ON DELETE CASCADE
);

CREATE TABLE Signalement(
   idSignalement INT AUTO_INCREMENT,
   nbSignalements INT NOT NULL,
   loginInter VARCHAR(50)  NOT NULL,
   idProposition INT NOT NULL,
   idCommentaire INT NOT NULL,
   PRIMARY KEY(idSignalement),
   UNIQUE(loginInter),
   UNIQUE(idProposition),
   UNIQUE(idCommentaire),
   FOREIGN KEY(loginInter) REFERENCES Internaute(loginInter) ON DELETE CASCADE,
   FOREIGN KEY(idProposition) REFERENCES Proposition(idProposition) ON DELETE CASCADE,
   FOREIGN KEY(idCommentaire) REFERENCES Commentaire(idCommentaire) ON DELETE CASCADE
);

CREATE TABLE A_pour_theme(
   idProposition INT,
   idTheme INT,
   PRIMARY KEY(idProposition, idTheme),
   FOREIGN KEY(idProposition) REFERENCES Proposition(idProposition) ON DELETE CASCADE,
   FOREIGN KEY(idTheme) REFERENCES Theme(idTheme) ON DELETE CASCADE
);

CREATE TABLE Fait_partie_de(
   idGroupe INT,
   loginInter VARCHAR(50) ,
   idRole INT,
   PRIMARY KEY(idGroupe, loginInter, idRole),
   FOREIGN KEY(idGroupe) REFERENCES Groupe(idGroupe) ON DELETE CASCADE,
   FOREIGN KEY(loginInter) REFERENCES Internaute(loginInter) ON DELETE CASCADE,
   FOREIGN KEY(idRole) REFERENCES Role(idRole) ON DELETE CASCADE
);

CREATE TABLE A_pour_reaction(
   idProposition INT,
   idReaction INT,
   PRIMARY KEY(idProposition, idReaction),
   FOREIGN KEY(idProposition) REFERENCES Proposition(idProposition) ON DELETE CASCADE,
   FOREIGN KEY(idReaction) REFERENCES Reaction(idReaction) ON DELETE CASCADE
);

CREATE TABLE Reagit(
   loginInter VARCHAR(50) ,
   idReaction INT,
   PRIMARY KEY(loginInter, idReaction),
   FOREIGN KEY(loginInter) REFERENCES Internaute(loginInter) ON DELETE CASCADE,
   FOREIGN KEY(idReaction) REFERENCES Reaction(idReaction) ON DELETE CASCADE
);

CREATE TABLE Concerne_la_notification(
   idProposition INT,
   idNotification INT,
   PRIMARY KEY(idProposition, idNotification),
   FOREIGN KEY(idProposition) REFERENCES Proposition(idProposition) ON DELETE CASCADE,
   FOREIGN KEY(idNotification) REFERENCES Notification(idNotification) ON DELETE CASCADE
);

CREATE TABLE Est_envoye_au_membre(
   loginInter VARCHAR(50) ,
   idNotification INT,
   PRIMARY KEY(loginInter, idNotification),
   FOREIGN KEY(loginInter) REFERENCES Internaute(loginInter) ON DELETE CASCADE,
   FOREIGN KEY(idNotification) REFERENCES Notification(idNotification) ON DELETE CASCADE
);

CREATE TABLE Propose(
   idProposition INT,
   loginInter VARCHAR(50) ,
   PRIMARY KEY(idProposition, loginInter),
   FOREIGN KEY(idProposition) REFERENCES Proposition(idProposition) ON DELETE CASCADE,
   FOREIGN KEY(loginInter) REFERENCES Internaute(loginInter) ON DELETE CASCADE
);

CREATE TABLE Vote(
   loginInter VARCHAR(50) ,
   idScrutin INT,
   valeurVote TINYINT NOT NULL,
   PRIMARY KEY(loginInter, idScrutin),
   FOREIGN KEY(loginInter) REFERENCES Internaute(loginInter) ON DELETE CASCADE,
   FOREIGN KEY(idScrutin) REFERENCES Scrutin(idScrutin) ON DELETE CASCADE
);
