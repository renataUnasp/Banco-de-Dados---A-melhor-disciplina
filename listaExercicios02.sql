1 //

DELIMITER //

CREATE PROCEDURE sp_ListarAutores()
BEGIN
SELECT FROM Autor,Nome;
END;
//

DELIMITER ;
CALL sp_ListarAutores();

2 //

DELIMITER //

CREATE PROCEDURE sp_LivrosPorCategoria(IN Nome_Categoria VARCHAR(100))
BEGIN
SELECT Livro.Titulo
FROM Livro
INNER JOIN Categoria ON Livro.Categoria_ID = Categoria.Categoria_ID 
WHERE Categoria.Nome = Nome_Categoria;
END;
//

DELIMITER ;

--atribuindo valores:
CALL sp_LivrosPorCategoria('Romance');
CALL sp_LivrosPorCategoria('Comedia');
CALL sp_LivrosPorCategoria('Suspense');
CALL sp_LivrosPorCategoria('Mistério');
