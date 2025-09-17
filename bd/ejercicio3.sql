DELIMITER $$
DROP PROCEDURE IF EXISTS proc3;
CREATE PROCEDURE proc3(par1 int)
BEGIN
    CASE par1
        WHEN 1 THEN INSERT INTO tabla VALUES ('primero');
        WHEN 2 THEN INSERT INTO tabla VALUES ('segundo');
        WHEN 3 THEN INSERT INTO tabla VALUES ('tercero');
        ELSE THEN INSERT INTO tabla VALUES ('otro');
    END CASE;
END;
DELIMITER ;