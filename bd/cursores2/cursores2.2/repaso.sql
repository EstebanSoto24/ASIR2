DELIMITER $$
USE ebanca $$
DROP PROCEDURE IF EXISTS repaso $$
CREATE PROCEDURE repaso()
BEGIN
# Declaramos las variables
DECLARE lrf BOOL;
DECLARE v_codigo_cliente, v_dni, v_saldo, v_cod_cuenta INT;
DECLARE v_nombre, v_apellido1, v_apellido2 CHAR(20);
DECLARE v_direccion CHAR(50);
DECLARE v_region VARCHAR(45);

# Declaramos los cursores
DECLARE c_clientes CURSOR FOR
SELECT *
FROM clientes;

DECLARE c_cuentas CURSOR FOR
SELECT cod_cuenta, saldo
FROM cuentas
WHERE saldo < 0 AND cod_cliente = v_codigo_cliente;

# Declaramos el control de errores
DECLARE CONTINUE HANDLER FOR NOT FOUND SET lrf = 1;

SET lrf = 0;

OPEN c_clientes;
	b_clientes: LOOP
		FETCH c_clientes INTO v_codigo_cliente, v_dni, v_nombre, v_apellido1, v_apellido2, v_direccion, v_region;
		IF lrf = 1 THEN
			LEAVE b_clientes;
		END IF;
		OPEN c_cuentas;
			b_cuentas: LOOP
			FETCH c_cuentas INTO v_cod_cuenta, v_saldo;
			IF lrf = 1 THEN
				LEAVE b_cuentas;
			END IF;
			SELECT CONCAT('El cliente con codigo ', v_codigo_cliente, ' con nombre y apellido ', v_nombre,' ', v_apellido1, ' con direccion y region en ', v_direccion, ' ', v_region, ' tiene una cuenta con un total de ', v_saldo, ' en negativo y con codigo ', v_cod_cuenta) AS 'RESULTADO';
			END LOOP b_cuentas;
		CLOSE c_cuentas;
		SET lrf = 0;
	END LOOP b_clientes;
CLOSE c_clientes;

END;$$
DELIMITER ;
