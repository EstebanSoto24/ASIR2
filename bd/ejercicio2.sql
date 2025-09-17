// Ejercicio 2.

DELIMITER $$
DROP PROCEDURE IF EXISTS proc2;
CREATE PROCEDURE proc2(par1 int)
BEGIN
DECLARE var1 int;
SET var1 = par1 + 1;
    IF var1 = 1 THEN
        WHEN 0 THEN UPDATE tabla SET s1 = s1 + 1;
        WHEN 1 THEN INSERT INTO tabla VALUES (var1);
        ELSE UPDATE tabla SET s1 = s1 + 2;
    END IF;
END;
DELIMITER ;
