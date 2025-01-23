DELIMITER //

-- Trigger pour incrémenter ou décrémenter la popularité d'une proposition en fonction d'une réaction
CREATE TRIGGER UpvoteDownvoteReaction
AFTER INSERT ON Reagit
FOR EACH ROW
BEGIN
    DECLARE type_reaction INT;
    SELECT typeReaction INTO type_reaction
    FROM Reaction
    WHERE idReaction = NEW.idReaction;

    IF type_reaction = 1 THEN -- Upvote
        UPDATE Proposition
        SET popularite = popularite + 1
        WHERE idProposition = (
            SELECT idProposition
            FROM A_pour_reaction
            WHERE idReaction = NEW.idReaction
        );
    ELSEIF type_reaction = 2 THEN -- Downvote
        UPDATE Proposition
        SET popularite = popularite - 1
        WHERE idProposition = (
            SELECT idProposition
            FROM A_pour_reaction
            WHERE idReaction = NEW.idReaction
        );
    END IF;
END;
//
DELIMITER ; 

DELIMITER //
-- Trigger pour mettre à jour la popularité lors de la suppression d'une réaction
CREATE TRIGGER updateDelProp
AFTER DELETE ON Reagit
FOR EACH ROW
BEGIN
    DECLARE type_reaction INT;
    SELECT typeReaction INTO type_reaction
    FROM Reaction
    WHERE idReaction = OLD.idReaction;

    IF type_reaction = 1 THEN -- Upvote
        UPDATE Proposition
        SET popularite = popularite - 1
        WHERE idProposition = (
            SELECT idProposition
            FROM A_pour_reaction
            WHERE idReaction = OLD.idReaction
        );
    ELSEIF type_reaction = 2 THEN -- Downvote
        UPDATE Proposition
        SET popularite = popularite + 1
        WHERE idProposition = (
            SELECT idProposition
            FROM A_pour_reaction
            WHERE idReaction = OLD.idReaction
        );
    END IF;
END;
//
DELIMITER ;

-- Trigger pour supprimer les commentaires et réactions liés à une proposition supprimée
CREATE TRIGGER DeleteProposition
BEFORE DELETE ON Proposition
FOR EACH ROW
BEGIN
    DELETE FROM Commentaire WHERE idProposition = OLD.idProposition;
    DELETE FROM A_pour_reaction WHERE idProposition = OLD.idProposition;
    DELETE FROM Concerne_la_notification WHERE idProposition = OLD.idProposition;
    DELETE FROM Propose WHERE idProposition = OLD.idProposition;
END$$

-- Trigger pour empêcher un double vote dans un scrutin
CREATE TRIGGER before_insert_vote
BEFORE INSERT ON Vote
FOR EACH ROW
BEGIN
    IF EXISTS (
        SELECT 1
        FROM Vote
        WHERE loginInter = NEW.loginInter
        AND idScrutin = NEW.idScrutin
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Un utilisateur ne peut pas voter deux fois dans le même scrutin.';
    END IF;
END;
//
DELIMITER ;
