DELIMITER $$
USE ejemplo $$
DROP PROCEDURE IF EXISTS ejer1 $$
CREATE PROCEDURE ejer1
BEGIN
# Decalración de variables
DECLARE lrf BOOLEAN;
DECLARE cont, result, autor_result INT;
DECLARE autor VARCHAR(50);

# Declaración de cursores
DECLARE CURSOR autor FOR
SELECT id_autor INTO autor
FROM autores;

DECLARE CURSOR noticias FOR
SELECT id_autor
FROM noticias
WHERE id_autor = autor AND MONTH(fecha) = 11;

# Declaración control de errores
DECLARE CONTINUE HANDLER FOR NOT FOUND SET lrf = 1;

SET lrf = 0;
SET cont = 0;

OPEN autor;
    autor: LOOP
        FETCH autor INTO autor;
        OPEN noticias;
            noticias: LOOP
                FETCH noticias INTO autor;
                IF lrf = 1 THEN
                    LEAVE noticias;
                END IF;
                SET cont = cont + 1;
            END LOOP;
            IF cont > result THEN
                SET result = cont
                SET autor_result = autor; 
            END IF;
            SET cont = 0;
        CLOSE noticias;
        IF lrf = 1 THEN
            LEAVE autor;
        END IF;
    END LOOP;
CLOSE autor;

END; $$
DELIMITER ;