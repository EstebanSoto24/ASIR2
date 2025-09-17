DELIMITER $$
DROP PROCEDURE IF EXISTS proc4;
CREATE PROCEDURE proc4()
BEGIN
DECLARE var1 INT DEFAULT 0;
    bucle: LOOP
        IF MOD(var1/2) = 1 THEN
            SELECT var1;
        END IF;
        IF var1 > 10 THEN
            LEAVE bucle;
        END IF;
        SET var1 = var1 + 1;
    END LOOP;
END;
DELIMITER ;