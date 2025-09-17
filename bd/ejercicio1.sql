// Ejericio 1
DELIMITER $$
DROP PROCEDURE IF EXISTS proc1;
CREATE PROCEDURE proc1(par1 int)
BEGIN
DECLARE var1 var2 int;
    IF par1 = 17 THEN
        SET var1 = par1;
    ELSE
        SET var2 = 30;
    END IF;
END;
DELIMITER ;