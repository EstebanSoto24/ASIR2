DELIMITER $$
USE motorblog $$
DROP PROCEDURE IF EXISTS cursor22 $$
CREATE PROCEDURE cursor22
BEGIN
# Declaración de variables
DECLARE lrf,cont,vid_tienda INT;

# Declaración de cursores
DECLARE CURSOR vtiendas FOR
SELECT id_tienda
FROM Tiendas;

DECLARE CURSOR cventas FOR
SELECT id_tienda
FROM Ventas
WHERE fecha_venta BETWEEN DATE_ADD(now(), INTERVAL -1 MONTH);

# Declaración de control de errores
DECLARE CONTINUE HANDLER FOR NOT FOUND SET lrf = 1;


END; $$
DELIMITER ;