-- Insertion des groupes
INSERT INTO Groupe (nomGroupe, descGroupe, couleurGroupe) VALUES
('Groupe Écologie', 'Le velo c cool', '#1f5e30'),
('Groupe Éducation', 'Les maths c cool', '#855258'),
('Groupe Santé', 'Le cancer c cool', '#538a82'),
('Groupe Technologie', 'Le code c cool', '#1f3c5e'),
('Groupe Urbanisme', 'Les arbres c cool', '#523c41');

-- Insertion des thèmes
INSERT INTO Theme (nomTheme, budgetTheme) VALUES
('Énergies renouvelables', 50000),
('Réduction des déchets', 30000),
('Réforme scolaire', 70000);

-- Insertion des internautes
INSERT INTO Internaute (loginInter, nomInter, prenomInter, emailInter, mdpInter, adrInter, compteValide) VALUES
('jdoe', 'Doe', 'John', 'jdoe@example.com', 'pass123', '123 Rue Principale', 1),
('asmith', 'Smith', 'Alice', 'asmith@example.com', 'secure456', '456 Avenue Centrale', 1);

-- Insertion des budgets
INSERT INTO Budget (limiteBudgetGlobal, titreBudget, idGroupe) VALUES
(100000, 'Energie', 1),
(150000, 'Services Mairie', 2),
(250000, 'Education', 3);

-- Insertion des rôles
INSERT INTO Role (nomRole) VALUES
('Membre'),
('Modérateur'),
('Admin');

-- Insertion des réactions
INSERT INTO Reaction (typeReaction) VALUES
(1), (2), (3);

-- Insertion des notifications
INSERT INTO Notification (typeNotification, messageNotification, etatNotification, frequenceNotification) VALUES
('Alerte', 'Nouvelle proposition publiée', 'Non lu', 'Quotidienne');

-- Insertion des propositions
INSERT INTO Proposition (descProposition, titreProposition, popularite, dateProp, validee, coutProp, idBudget) VALUES
('Mise en place de panneaux solaires dans les écoles', 'Énergie solaire scolaire', 85, '2025-02-01 10:00:00', TRUE, 45000, 1),
('Développement de pistes cyclables en ville', 'Mobilité douce', 72, '2025-02-03 15:30:00', TRUE, 60000, 2),
('Création d’un espace de coworking public', 'Innovation et travail', 90, '2025-02-05 09:45:00', TRUE, 80000, 3);

-- Insertion des commentaires
INSERT INTO Commentaire (descCommentaire, dateCommentaire, loginInter, idProposition) VALUES
('Très bonne idée pour la transition énergétique !', '2025-02-02 12:00:00', 'jdoe', 1);

-- Insertion des scrutins
INSERT INTO Scrutin (dureeDiscussion, dureeScrutin, natureScrutin, resultatScrutin, idProposition) VALUES
(10, 5, 'Vote majoritaire', 'En cours', 1);

-- Insertion des votes
INSERT INTO Vote (loginInter, idScrutin, valeurVote) VALUES
('jdoe', 1, 1);

-- Insertion des signalements
INSERT INTO Signalement (nbSignalements, loginInter, idProposition, idCommentaire) VALUES
(1, 'asmith', 1, 1);

-- Associations diverses
INSERT INTO A_pour_theme (idProposition, idTheme) VALUES
(1, 1);

INSERT INTO Fait_partie_de (idGroupe, loginInter, idRole) VALUES
(1, 'jdoe', 1);

INSERT INTO A_pour_reaction (idProposition, idReaction) VALUES
(1, 1);

INSERT INTO Reagit (loginInter, idReaction) VALUES
('asmith', 1);

INSERT INTO Concerne_la_notification (idProposition, idNotification) VALUES
(1, 1);

INSERT INTO Est_envoye_au_membre (loginInter, idNotification) VALUES
('jdoe', 1);

INSERT INTO Propose (idProposition, loginInter) VALUES
(1, 'jdoe'),
(2, 'asmith'),
(3, 'jdoe');
