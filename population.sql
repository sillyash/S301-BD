-- Insertions pour la table Groupe
INSERT INTO Groupe (nomGroupe) VALUES
('Développement Durable'),
('Éducation'),
('Santé'),
('Culture');

-- Insertions pour la table Theme
INSERT INTO Theme (nomTheme, idGroupe) VALUES
('Energies Renouvelables', 1),
('Sensibilisation Écologique', 1),
('Réforme Scolaire', 2),
('Accès à l’Éducation', 2),
('Prévention Sanitaire', 3),
('Bien-être Mental', 3),
('Art Contemporain', 4),
('Patrimoine Historique', 4);

-- Insertions pour la table Internaute
INSERT INTO Internaute (loginInter, nomInter, prenomInter, emailInter, mdpInter, adrInter) VALUES
('user123', 'Dupont', 'Marie', 'marie.dupont@example.com', 'password123', '12 rue des Lilas'),
('user456', 'Martin', 'Paul', 'paul.martin@example.com', 'securepwd456', '34 avenue Victor Hugo'),
('user789', 'Lemoine', 'Sophie', 'sophie.lemoine@example.com', 's0ph1epwd!', '56 boulevard Haussmann');

-- Insertions pour la table Budget
INSERT INTO Budget (limiteBudgetGlobal) VALUES
(100000),
(50000),
(75000);

-- Insertions pour la table Reaction
INSERT INTO Reaction (typeReaction) VALUES
(1), -- "J'aime"
(2), -- "Je n'aime pas"
(3); -- "Indifférent"

-- Insertions pour la table Notification
INSERT INTO Notification (typeNotification, messageNotification, etatNotification, frequenceNotification) VALUES
('Alerte', 'Nouvelle proposition disponible', 'Non lue', 'Hebdomadaire'),
('Rappel', 'Scrutin en cours', 'Non lue', 'Quotidienne'),
('Info', 'Nouvelle réaction sur votre proposition', 'Lue', 'Instantanée');

-- Insertions pour la table Role
INSERT INTO Role (nomRole) VALUES
('Admin'),
('Modérateur'),
('Utilisateur');

-- Insertions pour la table Proposition
INSERT INTO Proposition (titreProposition, descProposition, idBudget, validee) VALUES
('Plan de plantation urbaine', 'Augmenter les espaces verts dans les zones urbaines.', 1, TRUE),
('Modernisation des écoles', 'Fournir des équipements technologiques aux établissements.', 2, FALSE),
('Campagne anti-tabac', 'Sensibiliser aux dangers du tabac.', 3, TRUE);

-- Insertions pour la table Commentaire
INSERT INTO Commentaire (descCommentaire, dateCommentaire, loginInter, idProposition) VALUES
('Très bonne idée !', '2025-01-20 10:15:00', 'user123', 1),
('Je pense que cela pourrait coûter cher.', '2025-01-21 12:30:00', 'user456', 2),
('C’est une priorité.', '2025-01-22 14:00:00', 'user789', 3);

-- Insertions pour la table Scrutin
INSERT INTO Scrutin (dureeDiscussion, dureeScrutin, natureScrutin, resultatScrutin, idProposition) VALUES
(14, 7, 'Vote public', 'Adopté', 1),
(10, 5, 'Vote privé', NULL, 2);

-- Insertions pour la table Signalement
INSERT INTO Signalement (nbSignalements, loginInter, idProposition, idCommentaire) VALUES
(2, 'user123', 2, 1),
(1, 'user456', 3, 2);

-- Insertions pour la table A_pour_theme
INSERT INTO A_pour_theme (idProposition, idTheme) VALUES
(1, 1),
(2, 3),
(3, 5);

-- Insertions pour la table Fait_partie_de
INSERT INTO Fait_partie_de (idGroupe, loginInter, idRole) VALUES
(1, 'user123', 3),
(2, 'user456', 2),
(3, 'user789', 3);

-- Insertions pour la table A_pour_reaction
INSERT INTO A_pour_reaction (idProposition, idReaction) VALUES
(1, 1),
(2, 2),
(3, 3);

-- Insertions pour la table Reagit
INSERT INTO Reagit (loginInter, idReaction) VALUES
('user123', 1),
('user456', 2),
('user789', 3);

-- Insertions pour la table Concerne_la_notification
INSERT INTO Concerne_la_notification (idProposition, idNotification) VALUES
(1, 1),
(2, 2),
(3, 3);

-- Insertions pour la table Est_envoye_au_membre
INSERT INTO Est_envoye_au_membre (loginInter, idNotification) VALUES
('user123', 1),
('user456', 2),
('user789', 3);

-- Insertions pour la table Propose
INSERT INTO Propose (idProposition, loginInter) VALUES
(1, 'user123'),
(2, 'user456'),
(3, 'user789');

-- Insertions pour la table Vote
INSERT INTO Vote (loginInter, idScrutin) VALUES
('user123', 1),
('user456', 1),
('user789', 2);

