DELIMITER $$
DROP PROCEDURE IF EXISTS ejercicio5 $$
CREATE PROCEDURE ejercicio5 (nombre VARCHAR(30), edad INT)
BEGIN
IF edad >= 18 THEN
    INSERT INTO adultos VALUES (nombre, edad);
ELSE
    INSERT INTO peques VALUES (nombre, edad);
END IF;
END ;
DELIMITER ;