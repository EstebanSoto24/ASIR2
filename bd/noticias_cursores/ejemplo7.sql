DELIMITER $$
DROP PROCEDURE IF EXISTS ejer7 $$
CREATE PROCEDURE ejer7
BEGIN
# Declaración de variables principales
DECLARE autor, nn INT;
DECLARE lrf BOOLEAN;

# Declaración de los cursores
DECLARE CURSOR id_autor FOR SELECT * FROM autores ;

DECLARE CURSOR noticias FOR SELECT * FROM noticias WHERE autor_id = autor;

# Declaración de manejador de errores
DECLARE CONTINUE HANDLER FOR NOT FOUND SET lrf = 1;

SET lrf = 0;
SET nn = 0;

OPEN autores;
    bucle1: LOOP
        FETCH autores INTO autor
        IF lrf = 1 THEN
            LEAVE bucle1;
        END IF;
        OPEN noticias;
        SET nn = 0;
            bucle2: LOOP
                FETCH noticias INTO autor
                IF lrf = 1 THEN
                    LEAVE bucle2;
                END IF;
                SET nn = nn + 1;
            END LOOP noticias;
        CLOSE noticias;
        SET lrf = 0;
        SELECT CONCAT('El autor ', autor, ' tiene ', nn, ' noticias') AS RESULTADO;
    END LOOP autores;
CLOSE autores;

END; $$
DELIMITER ;