DELIMITER $$
USE motorblog $$
DROP PROCEDURE IF EXISTS notis_noviembre $$
CREATE PROCEDURE notis_noviembre()
BEGIN
# Decalración de variables
DECLARE lrf BOOL;
DECLARE v_cont, v_result, v_autor INT;
DECLARE v_login, v_login_result VARCHAR(60);

# Declaración de cursores
DECLARE c_autor CURSOR FOR
SELECT id_autor, login
FROM autores;

DECLARE c_noticias CURSOR FOR
SELECT autor_id
FROM noticias
WHERE autor_id = v_autor AND MONTH(fecha_pub) = 11;

# Declaración control de errores
DECLARE CONTINUE HANDLER FOR NOT FOUND SET lrf = 1;

SET lrf = 0;
SET v_cont = 0;
SET v_result = 0;

OPEN c_autor;
    b_autor: LOOP
        FETCH c_autor INTO v_autor, v_login;
        IF lrf = 1 THEN
            LEAVE b_autor;
        END IF;
        OPEN c_noticias;
            b_noticias: LOOP
                FETCH c_noticias INTO v_autor;
                IF lrf = 1 THEN
                    LEAVE b_noticias;
                END IF;
                SET v_cont = v_cont + 1;
            END LOOP;
            IF v_cont > v_result THEN
                SET v_result = v_cont;
                SET v_login_result = v_login; 
            END IF;
            SET v_cont = 0;
        CLOSE c_noticias;
        SET lrf = 0;
    END LOOP;
CLOSE c_autor;
SELECT CONCAT('El autor ',v_login_result,' es el que más noticias subio en noviembre, con un total de ', v_result) AS 'RESULTADO';
END; $$
DELIMITER ;
