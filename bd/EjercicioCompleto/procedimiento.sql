DELIMITER $$
USE prueba1 $$
DROP PROCEDURE IF EXISTS completo1 $$
CREATE PROCEDURE completo1()
BEGIN
# Declaración de variables convencionales.
DECLARE lrf,v_dni,v_cont INT;

# Declaración de cursores
DECLARE c_usuarios CURSOR FOR
SELECT dni 
FROM usuarios;

DECLARE c_publicaciones CURSOR FOR
SELECT Id_usuario
FROM publicaciones 
WHERE Id_usuario = v_dni AND Fecha BETWEEN DATE_ADD(NOW(),INTERVAL -3 MONTH) AND NOW();

# Declaración de errores
DECLARE HANDLER FOR NOT FOUND set lrf = 1;

SET lrf = 0;
SET v_cont = 0;

OPEN c_usuarios;
    b_usuarios LOOP
        FETCH c_usuarios INTO v_dni;    
        IF lrf = 1 THEN
            LEAVE b_usuarios;
        END IF;
        OPEN c_publicaciones;
            b_publicaciones LOOP
                FETCH b_publicaciones INTO v_dni;
                IF lrf = 1 THEN
                    LEAVE b_publicaciones;
                END IF;
                SET v_cont = v_cont + 1;
            END LOOP b_publicaciones;
            IF v_cont = 0 THEN
                DELETE FROM usuarios WHERE dni = v_dni;
            END IF;
        CLOSE c_publicaciones;
        SET v_cont = 0;
        SET lrf = 0;
    END LOOP b_usuarios;
CLOSE c_usuarios;

END; $$
DELIMITER ;