DELIMITER $$
DROP EVENT IF EXISTS tercer_evento $$
CREATE EVENT tercer_evento ON starts last_day(now()) 
DO
BEGIN
    INSERT INTO transacciones (id_cuenta,fecha,ajuste) 
    SELECT id_cuenta,NOW(),50
    FROM cuentas
    WHERE saldo < 100;
END; $$
DELIMITER ;