-- 1. Procédure pour créer un groupe et ajouter un utilisateur en tant qu'admin
DELIMITER $$
CREATE PROCEDURE CreerGroupe(
    IN nomGroupe VARCHAR(50),
    IN loginInter VARCHAR(50)
)
BEGIN
    DECLARE groupeID INT;
    DECLARE adminRoleID INT;
    
    -- Vérifier si le rôle 'Administrateur' existe
    SELECT idRole INTO adminRoleID FROM Role WHERE nomRole = 'Admin' LIMIT 1;
    IF adminRoleID IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Le rôle Admin n\'existe pas';
    END IF;
    
    -- Création du groupe
    INSERT INTO Groupe (nomGroupe) VALUES (nomGroupe);
    SET groupeID = LAST_INSERT_ID();
    
    -- Ajouter l'utilisateur au groupe en tant qu'admin
    INSERT INTO Fait_partie_de (idGroupe, loginInter, idRole) VALUES (groupeID, loginInter, adminRoleID);
END $$
DELIMITER ;

-- 2. Événement MySQL pour clôturer automatiquement un vote après une période
DELIMITER $$
CREATE EVENT cloturer_votes
ON SCHEDULE EVERY 1 HOUR
DO
BEGIN
    UPDATE Scrutin 
    SET resultatScrutin = 'Fermé'
    WHERE resultatScrutin IS NULL 
    AND DATE_ADD(NOW(), INTERVAL -dureeScrutin HOUR) > NOW();
END $$
DELIMITER ;

-- 3. Procédure pour calculer le résultat des votes
DELIMITER $$
CREATE PROCEDURE CalculerResultatVote(
    IN scrutinID INT
)
BEGIN
    DECLARE votesPour INT;
    DECLARE votesContre INT;
    
    -- Compter les votes
    SELECT COUNT(*) INTO votesPour FROM Vote WHERE idScrutin = scrutinID AND idReaction = (SELECT idReaction FROM Reaction WHERE typeReaction = 1);
    SELECT COUNT(*) INTO votesContre FROM Vote WHERE idScrutin = scrutinID AND idReaction = (SELECT idReaction FROM Reaction WHERE typeReaction = 2);
    
    -- Mise à jour du résultat
    IF votesPour > votesContre THEN
        UPDATE Scrutin SET resultatScrutin = 'Accepté' WHERE idScrutin = scrutinID;
    ELSE
        UPDATE Scrutin SET resultatScrutin = 'Rejeté' WHERE idScrutin = scrutinID;
    END IF;
END $$
DELIMITER ;
