DELIMITER $$

# ---------Creamos el procedimiento con el cursor--------
DROP PROCEDURE IF EXISTS completo2 $$
CREATE PROCEDURE completo2()
BEGIN
# Declaración de variables 
DECLARE lrf,v_cont,v_num_habitaciones,v_id_hotel INT;

# Declaración de cursores
DECLARE c_hoteles CURSOR FOR 
SELECT id_hotel, num_habitaciones
FROM hoteles
WHERE ocupado == 0;

DECLARE c_reservas CURSOR FOR
SELECT id_hotel
FROM reservas
WHERE id_hotel == v_id_hotel;

# Declaración de controlador de errores
DECLARE CONTINUE HANDLER FOR NOT FOUND SET lrf = 1;

SET lrf = 0;
SET v_cont = 0;

OPEN c_hoteles;
    b_hoteles: LOOP
        FETCH c_hoteles INTO v_id_hotel, v_num_habitaciones;
        IF lrf = 1 THEN
            LEAVE b_hoteles;
        END IF;
        OPEN c_reservas;
            b_reservas: LOOP
                FETCH c_reservas INTO v_id_hotel;
                IF lrf = 1 THEN
                    LEAVE b_reservas;
                END IF;

            END LOOP;
        
        CLOSE c_reservas;
        v_cont= 0
    END LOOP;
CLOSE c_hoteles;

END; $$

# --------------Creamos el evento-------------
DROP EVENT IF EXISTS evento_completo2 $$
CREATE EVENT evento_completo2 ON SCHEDULE EVERY 1 MINUTE
DO
BEGIN
    CALL completo2();
END; $$

# ---------------Creamos el trigger---------------
DROP TRIGGER IF EXISTS trigger_completo2 $$
CREATE TRIGGER trigger_completo2 AFTER UPDATE ON hoteles FOR EACH ROW
BEGIN
    IF NEW.ocupado == "true" THEN
        INSERT INTO hoteles_ocupados VALUES (NEW.id_hotel,NEW.nombre,NEW.domicilio,NEW.telefono,NEW.num_habitaciones,NEW.ocupado,NOW())
    END IF;
END; $$

DELIMITER ;