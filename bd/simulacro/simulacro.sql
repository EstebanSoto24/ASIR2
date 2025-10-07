//Desarrolla usando cursores una rutina que muestre los datos del cliente, la cuenta y el saldo de los clientes con saldo negativo en alguna de sus cuentas.

DELIMITER $$
USE ebanca $$
DROP PROCEDURE IF EXISTS cursor2.3;
CREATE PROCEDURE cursor2.3;
BEGIN

# Decalración de variables
DECLARE vcodigo_cliente, vdni, lrf INT;
DECLARE vnombre,vapellido1,vapellido2,vdireccion,vregion VARCHAR(50);

# Declaración de cursores
DECLARE CURSOR cclientes FOR
SELECT * 
FROM clientes;

DECLARE CURSOR ccuentas FOR
SELECT cod_cuenta, saldo
FROM cuentas
WHERE cod_cuenta = codigo_cuenta AND saldo < 0;

SET lrf = 0

OPEN cclientes;
    lclientes: LOOP
        FETCH cclientes INTO vcodigo_cliente,vdni,vnombre,vapellido1,vapellido2,vdireccion,vregion;
        IF lrf = 1 THEN
            LEAVE lclientes;
        END IF;
        OPEN ccuentas;
            lcuentas: LOOP
                FETCH ccuentas INTO cod_cuentas, saldo;
                IF lrf = 1 THEN
                    LEAVE lcuentas;
                END IF;
            END LOOP;
            SET cont = 0;
        CLOSE ccuentas;
    END LOOP;
CLOSE cclientes;


END; $$
DELIMITER ;