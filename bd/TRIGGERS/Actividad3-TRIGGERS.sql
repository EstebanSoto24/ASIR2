DELIMITER $$

# Ejercicio 1

CREATE TABLE cuentas (
    num_cuenta INT PRIMARY KEY,
    saldo DECIMAL(10,4)
)ENGINE=InnoDB;

CREATE TRIGGER insertar_saldo BEFORE INSERT ON cuentas FOR EACH ROW
BEGIN

SET @sum = @sum + NEW.saldo;

END; $$

INSERT INTO cuentas VALUES (123123, 1000)$$

CREATE TRIGGER restar_saldo AFTER DELETE ON cuentas FOR EACH ROW
BEGIN

SET @sum = @sum - OLD.saldo;

END; $$

DELETE FROM cuentas WHERE num_cuenta = 123123$$

SELECT COUNT(saldo)
FROM cuentas;

# Ejercicio 2

CREATE TRIGGER calcular_comision BEFORE INSERT ON ventas FOR EACH ROW
BEGIN
DECLARE v_result_comision DECIMAL(9,2);

SET v_result_comision = NEW.importeventa * 0.20;

SET importecomision =

END; $$
DELIMITER ;
