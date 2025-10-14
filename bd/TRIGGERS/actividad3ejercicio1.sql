DELIMITER $$
CREATE TABLE cuentas (
    num_cuenta INT PRIMARY KEY,
    saldo DECIMAL(10,4)
)ENGINE=InnoDB;

CREATE TRIGGER insertar_saldo BEFORE INSERT ON cuentas FOR EACH ROW
BEGIN

SET @sum = @sum + NEW.saldo;

END; $$

INSERT INTO cuentas VALUES (123123, 1000)$$


DELIMITER ;