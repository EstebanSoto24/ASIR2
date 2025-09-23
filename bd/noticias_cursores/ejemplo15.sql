DELIMITER $$
DROP PROCEDURE IF EXISTS ejemplo14 $$
CREATE PROCEDURE ejemplo14()

BEGIN

DECLARE tmp VARCHAR(200);
DECLARE lrf BOOL;
DECLARE nn INT;

#Declarar un cursor
DECLARE cursor14 CURSOR FOR
SELECT titulo
FROM noticias;

#Declarar un manejador de errores que detecte cuando llegamos a la ultima fila 
DECLARE CONTINUE HANDLER FOR NOT FOUND SET lrf=1;

SET lrf=0, nn=0;
OPEN cursor14;
l_cursor14: WHILE lrf = 0 DO
    FETCH cursor14 INTO tmp
    SET nn=nn+1;
END WHILE l_cursor14;
CLOSE cursor14;

SELECT nn;

END;$$
DELIMITER ;