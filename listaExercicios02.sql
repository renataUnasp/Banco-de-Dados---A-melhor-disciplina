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

3 //

DELIMITER //

CREATE PROCEDURE sp_ContarLivrosPorCategoria(IN Nome_Categoria VARCHAR(200), OUT Total_Livros INT)
BEGIN
SELECT COUNT(*) INTO Total_Livros
FROM Livro
INNER JOIN Categoria ON Livro.Categoria_ID = Categoria.Categoria_ID
WHERE Categoria.Nome = Nome_Categoria;
END;
//

DELIMITER ;

--atribuindo valores:
CALL sp_ContarLivrosPorCategoria('Romance', @Total_Livros);
CALL sp_ContarLivrosPorCategoria('Comedia', @Total_Livros);
CALL sp_ContarLivrosPorCategoria('Suspense', @Total_Livros);
CALL sp_ContarLivrosPorCategoria('Mistério', @Total_Livros);

4 // 

DELIMITER //

CREATE PROCEDURE sp_VerificarLivrosCategoria(IN Nome_Categoria VARCHAR(100), OUT Livros_Possuidos VARCHAR(3))
BEGIN


DECLARE contador INT;
SET contador = 0;

SELECT COUNT(*) INTO contador
FROM livro
INNER JOIN Categoria ON livro.Categoria_ID = Categoria.Categoria_ID
WHERE Categoria.Nome = Nome_Categoria;

IF contador > 0 THEN
    SET Livros_Possuidos = 'Sim';
ELSE
    SET Livros_Possuidos = 'Não';
END IF;



END;
//

DELIMITER ;

CALL sp_VerificarLivrosCategoria('Romance', @Livros_Possuidos);
CALL sp_VerificarLivrosCategoria('Comedia', @Livros_Possuidos);
CALL sp_VerificarLivrosCategoria('Suspense',@Livros_Possuidos);
CALL sp_VerificarLivrosCategoria('Mistério', @Livros_Possuidos);

SELECT @Livros_Possuidos;
