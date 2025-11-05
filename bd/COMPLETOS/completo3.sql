DELIMITER $$
USE ebanca $$
CREATE TABLE deudores (
    id_deudor INT PRIMARY KEY,
    nom_deudor CHAR(20),
    deuda DOUBLE
)ENGINE=InnoDB;

# ---------Creamos el procedimiento con el cursor--------
DROP PROCEDURE IF EXISTS completo3 $$
CREATE PROCEDURE completo3()
BEGIN
# Declaración de variables 
DECLARE lrf,v_id_deudor INT;
DECLARE v_nom_deudor CHAR(20);
DECLARE v_deuda, v_total_deuda DOUBLE;


# Declaración de cursores
DECLARE c_clientes CURSOR FOR
SELECT codigo_cliente, nombre
FROM clientes;

DECLARE c_cuentas CURSOR FOR
SELECT saldo
FROM cuentas
WHERE saldo < 0 AND cod_cliente = v_id_deudor;


# Declaración de controlador de errores
DECLARE CONTINUE HANDLER FOR NOT FOUND SET lrf = 1;

SET lrf = 0;
SET v_total_deuda = 0;
SET v_deuda = 0;

OPEN c_clientes;
    b_clientes: LOOP
        FETCH c_clientes INTO v_id_hotel, v_num_habitaciones;
        IF lrf = 1 THEN
            LEAVE b_clientes;
        END IF;
        OPEN c_cuentas;
            b_cuentas: LOOP
                FETCH c_cuentas INTO v_id_hotel;
                IF lrf = 1 THEN
                    LEAVE b_cuentas;
                END IF;
                SET v_total_deuda = v_total_deuda + v_deuda;
            END LOOP;
            
        CLOSE c_cuentas;
        SET lrf = 0;
    END LOOP;
CLOSE c_clientes;

END; $$

# --------------Creamos el evento-------------
/*
DROP EVENT IF EXISTS evento_completo3 $$
CREATE EVENT evento_completo3 ON SCHEDULE EVERY 1 MINUTE
DO
BEGIN
    CALL completo3();
END; $$
*/

# ---------------Creamos el trigger---------------
DROP TRIGGER IF EXISTS trigger_completo3_1 $$
CREATE TRIGGER trigger_completo3_1 AFTER INSERT ON movimientos FOR EACH ROW
BEGIN
    UPDATE cuentas 
    SET saldo = NEW.cantidad + saldo 
    WHERE cod_cuenta = NEW.cod_cuenta;
END; $$

DROP TRIGGER IF EXISTS trigger_completo3_2 $$
CREATE TRIGGER trigger_completo3_2 AFTER UPDATE ON cuentas FOR EACH ROW
BEGIN
    CALL completo3();
END; $$
DELIMITER ;