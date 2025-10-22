DELIMITER $$
DROP EVENT IF EXISTS segundo_evento $$
CREATE EVENT segundo_evento ON SCHEDULE EVERY 1 DAY DO
BEGIN
    INSERT INTO temp (cod_cuenta,saldo,fecha)
    SELECT cod_cuenta,saldo,fecha
    FROM movimientos
    WHERE saldo > 1000 AND fecha >= DATE_SUB(NOW(), INTERVAL 1 DAY);
END; $$
DELIMITER ;
