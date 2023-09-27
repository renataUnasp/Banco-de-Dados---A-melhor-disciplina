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

CREATE PROCEDURE sp_ContarLivrosPorCategoria(IN Nome_Categoria VARCHAR(100), OUT Total_Livros INT)
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

5 //

DELIMITER //

CREATE PROCEDURE sp_LivrosAteAno(IN ano_especifico INT)
BEGIN
SELECT Titulo, Publicacao_Ano
FROM Livro
WHERE Publicacao_Ano <= Ano_Especifico;
END;
//

DELIMITER ;

CALL sp_LivrosAteAno(2017);

6 //

DELIMITER //

CREATE PROCEDURE sp_TitulosPorCategoria(IN Nome_Categoria VARCHAR(100))
BEGIN


DECLARE titulo_do_livro VARCHAR(255);

DECLARE cursors_Livros CURSOR FOR
    SELECT Livro.Titulo
    FROM livro
    INNER JOIN Categoria ON livro.Categoria_ID = Categoria.Categoria_ID
    WHERE Categoria.Nome = Nome_Categoria;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET titulo_do_livro = NULL;

OPEN cursor_Livros;
read_loop: LOOP
    FETCH cursor_Livros INTO titulo_do_livro;
    IF titulo_do_livro IS NULL THEN
        LEAVE read_loop;
    END IF;
    SELECT titulo_do_livro;
END LOOP;
CLOSE cursor_Livros;



END;
//

DELIMITER ;

CALL sp_TitulosPorCategoria('Comedia');

7 //

DELIMITER //

CREATE PROCEDURE sp_AdicionarLivro(
IN Titulo_Livro VARCHAR(255),
IN Editora_Id INT,
IN Ano_Publicacao INT,
IN Numero_Paginas INT,
IN Categoria_Id INT
)
BEGIN


IF Titulo_Livro IS NULL OR Editora_ID IS NULL OR Ano_Publicacao IS NULL OR Numero_Paginas IS NULL OR categoria_ID IS NULL THEN
    SELECT 'Erro: Nenhum dos parâmetros pode ser nulo.' AS Status;
ELSE
    IF EXISTS (SELECT 1 FROM livro WHERE Titulo = Titulo_Livro) THEN
        SELECT 'Erro: O livro com esse título já existe na tabela.' AS Status;
    ELSE
        INSERT INTO Livro (Titulo, Editora_ID, Ano_Publicacao, Numero_Paginas, Categoria_ID)
        VALUES (Titulo_Livro, Editora_id, Ano_Publicacao, Numero_Paginas, Categoria_id);

        SELECT 'Livro adicionado com sucesso.' AS Status;
    END IF;
END IF;



END;
//

DELIMITER ;

CALL sp_AdicionarLivro('Táticas do amor', 1, 2023, 304, 1);

8 //

DELIMITER //

CREATE PROCEDURE sp_AutorMaisAntigo(OUT nome_autor_antigo VARCHAR(255))
BEGIN
DECLARE Datadonascimento DATE;
DECLARE nome_autor_antigo VARCHAR(255);
SET Datadonascimento = NULL;
DECLARE EXIT HANDLER FOR NOT FOUND SET nome_autor_antigo = NULL;


DECLARE Cursor_Autor CURSOR FOR
SELECT nome, Datadonascimento
FROM Autor
WHERE Datadonascimento IS NOT NULL;

OPEN Cursor_Autor;

Autor_loop: LOOP
    FETCH Cursor_Autor INTO nome_autor_antigo, Datadonascimento;
    IF nome_autor_antigo IS NULL THEN
        LEAVE Autor_loop;
    END IF;

    IF Datadonascimento IS NULL OR Datadonascimento > Datadonascimento THEN
        SET Datadonascimento = Datadonascimento;
        SET nome_do_autor = nome_autor_antigo;
    END IF;
END LOOP Autor_loop;
CLOSE Cursor_Autor;



END;
//

DELIMITER ;

CALL sp_AutorMaisAntigo(@nomeautorantigo);
SELECT @nomeautorantigo AS 'Nome Autor Antigo';

