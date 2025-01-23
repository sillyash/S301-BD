DELIMITER //
CREATE OR REPLACE TRIGGER IncrementerPopularite
AFTER INSERT ON A_pour_reaction
FOR EACH ROW
BEGIN
    DECLARE typeReaction INT;

    -- Récupérer le type de réaction
    SELECT typeReaction INTO typeReaction 
    FROM Reaction 
    WHERE idReaction = NEW.idReaction;

    -- Si le type de réaction est un Upvote (typeReaction = 1)
    IF typeReaction = 1 THEN
        UPDATE Proposition
        SET popularite = popularite + 1
        WHERE idProposition = NEW.idProposition;
    END IF;
END
//
DELIMITER ;


DELIMITER //
CREATE TRIGGER DecrementerPopularite
AFTER INSERT ON A_pour_reaction
FOR EACH ROW
BEGIN
    DECLARE typeReaction INT;

    -- Récupérer le type de réaction
    SELECT typeReaction INTO typeReaction 
    FROM Reaction 
    WHERE idReaction = NEW.idReaction;

    -- Si le type de réaction est un Downvote (typeReaction = 2)
    IF typeReaction = 2 THEN
        UPDATE Proposition
        SET popularite = popularite - 1
        WHERE idProposition = NEW.idProposition;
    END IF;
END
//
DELIMITER ;


DELIMITER //
CREATE TRIGGER AjusterPopularite
AFTER DELETE ON A_pour_reaction
FOR EACH ROW
BEGIN
    DECLARE typeReaction INT;

    -- Récupérer le type de réaction supprimée
    SELECT typeReaction INTO typeReaction 
    FROM Reaction 
    WHERE idReaction = OLD.idReaction;

    -- Ajuster la popularité en fonction du type de réaction
    IF typeReaction = 1 THEN -- Suppression d'un Upvote
        UPDATE Proposition
        SET popularite = popularite - 1
        WHERE idProposition = OLD.idProposition;
    ELSEIF typeReaction = 2 THEN -- Suppression d'un Downvote
        UPDATE Proposition
        SET popularite = popularite + 1
        WHERE idProposition = OLD.idProposition;
    END IF;
END
//
DELIMITER ;


DELIMITER //
CREATE TRIGGER SupprimerCommentairesEtReactions
BEFORE DELETE ON Proposition
FOR EACH ROW
BEGIN
    -- Supprimer tous les commentaires associés à la proposition
    DELETE FROM Commentaire WHERE idProposition = OLD.idProposition;

    -- Supprimer toutes les réactions associées à la proposition
    DELETE FROM A_pour_reaction WHERE idProposition = OLD.idProposition;
END
//
DELIMITER ;


DELIMITER //
CREATE TRIGGER EmpecherDoubleVote
BEFORE INSERT ON Vote
FOR EACH ROW
BEGIN
    -- Vérifier si l'utilisateur a déjà voté dans ce scrutin
    IF EXISTS (
        SELECT 1
        FROM Vote
        WHERE loginInter = NEW.loginInter AND idScrutin = NEW.idScrutin
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Un utilisateur ne peut pas voter plusieurs fois dans le même scrutin.';
    END IF;
END
//
DELIMITER ;



