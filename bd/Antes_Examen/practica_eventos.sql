DELIMITER $$
# ------ EJERCICIO 1 -------
CREATE EVENT cada_cinco_mins ON SCHEDULE EVERY 5 MINUTE
DO
BEGIN
    INSERT INTO momentos VALUES (now());
END $$

# ------ EJERCICIO 2 -------
CREATE EVENT dentro_dos_mins ON SCHEDULE AT 2 MINUTE
DO
BEGIN
    INSERT INTO log_eventos VALUES ('hola');
END $$

# ------ EJERCICIO 3 -------
CREATE EVENT a_las_tres ON SCHEDULE EVERY 1 DAY
STARTS '03:00:00'
DO
BEGIN
    DELETE FROM logs WHERE fecha > DATE_ADD(NOW(),INTERVAL 7 DAY);
END $$

# ------ EJERCICIO 4 -------
CREATE EVENT a_las_nueve_los_lunes ON SCHEDULE $$

# ------ EJERCICIO 5 -------
CREATE EVENT cada_hora ON SCHEDULE EVERY 1 HOUR
DO
BEGIN
    DECLARE v_registros INT;
    SELECT COUNT(*) INTO v_registros
    FROM ventas;
    IF v_registros > 0 THEN
        INSERT INTO auditoría VALUES ('hubo ventas');
    END IF;
END $$
DELIMITER ;