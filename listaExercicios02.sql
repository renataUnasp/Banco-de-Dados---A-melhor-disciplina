1 //

DELIMITER //

CREATE PROCEDURE sp_ListarAutores()
BEGIN
SELECT FROM Autor,Nome;
END;
//

DELIMITER ;
CALL sp_ListarAutores();
