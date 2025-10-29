DELIMITER $$
# Creación de tabla cuentas
USE pruebas_triggers $$
DROP TABLE IF EXISTS cuentas $$
CREATE TABLE cuentas (
    num_cuenta INT PRIMARY KEY,
    saldo DECIMAL(10,2)
)Engine=InnoDB $$

# Creación de Trigger que guarde variable global.
SET @total_saldo = 0;
DROP TRIGGER IF EXISTS trigger1 $$
CREATE TRIGGER trigger1 BEFORE INSERT ON cuentas FOR EACH ROW
BEGIN
    SET @total_saldo = @total_saldo + NEW.saldo;
END $$

# Insertar valores y comprobar el total de salgo insertado
INSERT INTO cuentas VALUES (123123, 550) $$
INSERT INTO cuentas VALUES (345345, 290) $$
INSERT INTO cuentas VALUES (567567, 430) $$

SELECT @total_saldo AS 'Comprobamos valor de total_saldo' $$

# Creación del segundo trigger
DROP TRIGGER IF EXISTS trigger2 $$
CREATE TRIGGER trigger2 AFTER DELETE ON cuentas FOR EACH ROW
BEGIN
    SET @total_saldo = @total_saldo - OLD.saldo;
END $$

DELETE FROM cuentas WHERE num_cuenta = 123123 $$
DELETE FROM cuentas WHERE num_cuenta = 345345 $$

SELECT @total_saldo AS 'Comprobamos valor de total_saldo' $$

# Ejercicio 2
# Creación de la tabla
DROP TABLE IF EXISTS ventas;
CREATE TABLE ventas (
    codigo INT AUTO_INCREMENT PRIMARY KEY,
    codigocliente INT,
    codigocomercial INT,
    importeventa DECIMAL(9,2),
    importecomision DECIMAL(9,2)
)ENGINE=InnoDB $$

# Creación del procedimiento
DROP PROCEDURE IF EXISTS calcular_comision $$
CREATE PROCEDURE calcular_comision()
BEGIN

END $$

# Creación del trigger
DROP TRIGGER IF EXISTS comision $$
CREATE TRIGGER comision BEFORE INSERT ON ventas 
FOR EACH ROW
BEGIN
    SET NEW.importecomision = NEW.importeventa / 5;
END $$

DELIMITER ;