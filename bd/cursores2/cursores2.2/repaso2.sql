DELIMITER $$
USE cursores2 $$
DROP PROCEDURE IF EXISTS menos_ventas $$
CREATE PROCEDURE menos_ventas()
BEGIN
# DECLARACIÓN DE VARIABLES
DECLARE lrf BOOL;
DECLARE v_cont, v_result, v_id_tienda, v_id_tienda_result INT;
DECLARE v_nombre_tienda, v_result_nombre VARCHAR(50);

# DECLARACIÓN DE CURSORES
DECLARE c_tiendas CURSOR FOR
SELECT id_tienda, nombre_tienda
FROM tiendas;

DECLARE c_ventas CURSOR FOR
SELECT id_tienda
FROM ventas
WHERE id_tienda = v_id_tienda AND fecha_venta BETWEEN DATE_ADD(NOW(), INTERVAL -1 MONTH) AND NOW();

# DECLARACIÓN DE CONTROL DE ERRORES
DECLARE CONTINUE HANDLER FOR NOT FOUND SET lrf = 1;

SET lrf = 0;
SET v_cont = 0;
SET v_result = 999999999;

OPEN c_tiendas;
	b_tiendas: LOOP
		FETCH c_tiendas INTO v_id_tienda, v_nombre_tienda;
		IF lrf = 1 THEN
			LEAVE b_tiendas;
		END IF;
		OPEN c_ventas;
			b_ventas: LOOP
			FETCH c_ventas INTO v_id_tienda;
			IF lrf = 1 THEN
				LEAVE b_ventas;
			END IF;
			SET v_cont = v_cont + 1;
			END LOOP b_ventas;
		CLOSE c_ventas;
		IF v_cont < v_result THEN
			SET v_result = v_cont;
			SET v_result_nombre = v_nombre_tienda;
			SET v_id_tienda_result = v_id_tienda;
		END IF;
		SET v_cont = 0;
		SET lrf = 0;
	END LOOP b_tiendas;
CLOSE c_tiendas;
SELECT CONCAT('La tienda que ha vendido menos el último més es ', v_result_nombre, ' con id ', v_id_tienda_result, ' y ha tenido un total de ', v_result, ' ventas') AS 'RESULTADO';

END; $$
DELIMITER ;
