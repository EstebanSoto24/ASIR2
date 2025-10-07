DELIMITER $$
USE motorblog $$
DROP PROCEDURE IF EXISTS cursor22 $$
CREATE PROCEDURE cursor22
BEGIN
# Declaración de variables
DECLARE lrf,cont,resultado,id_venta INT;
DECLARE vtienda, vnombre_tienda, rnombre_tienda VARCHAR(255);

# Declaración de cursores
DECLARE CURSOR ctiendas FOR
SELECT id_tienda, nombre_tienda
FROM Tiendas;

DECLARE CURSOR cventas FOR
SELECT cantidad
FROM Ventas
WHERE id_tienda = tienda_id AND   fecha_venta BETWEEN DATE_ADD(now(), INTERVAL -1 MONTH) AND NOW();

# Declaración de control de errores
DECLARE CONTINUE HANDLER FOR NOT FOUND SET lrf = 1;

SET lrf = 0;
SET resultado=999999999;

OPEN ctiendas;
    ctiendas: LOOP
        FETCH ctiendas INTO vtienda, vnombre_tienda;
        IF lrf = 1 THEN
            LEAVE ctiendas;
        END IF;
        OPEN cventas;
            cventas: LOOP
                FETCH cventas INTO cantidad;
                IF lrf = 1 THEN
                    LEAVE cventas;
                END IF;
                SET cont = cantiad + cont;
            END LOOP;
            IF cont < resultado THEN
                SET resultado = cont;
                SET rnombre_tienda = vnombre_tienda;
            END IF;
            SET cont = 0;
        CLOSE cventas;
        SET lrf = 1;
    END LOOP;
CLOSE ctiendas;


END; $$
DELIMITER ;