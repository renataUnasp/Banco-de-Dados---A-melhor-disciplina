SELECT titulo FROM livros;

SELECT nome FROM autores 
WHERE nascimento < '1900-01-01';

SELECT livros.titulo, nome.escritores FROM livros
INNER JOIN escritores ON livros.escritor_id = escritores.id WHERE nome.escritores = 'J.K. Rowling';

SELECT alunos.nome, matricula.curso FROM alunos
INNER JOIN matriculas ON alunos.id = matriculados.aluno_id WHERE matricula.curso = 'Engenharia de Software';

SELECT produto, SUM(receita) AS receita_numero FROM vendas
GROUP BY produto;

SELECT autores.nome AS autor, COUNT(livros.id) AS livros_todos FROM autores
LEFT JOIN livros ON autores.id = livros.autor_id GROUP BY autores.id ORDER BY autores.id;

SELECT curso, COUNT(aluno_id) AS alunos_matriculados FROM matriculas
GROUP BY curso 
ORDER BY curso;

SELECT produto, AVG(receita) AS num_receita FROM vendas
GROUP BY produto 
ORDER BY produto;

SELECT produto, SUM(receita) AS total_receitas FROM vendas
GROUP BY produto 
HAVING SUM(receita) > '10.000' ORDER BY produto;

SELECT autores.nome AS autor, COUNT(livros.id) AS quant_livros FROM autores
LEFT JOIN livros ON autores.id = livros.autor_id  GROUP BY autores.id 
HAVING COUNT(livros.id) > '2';

SELECT livros.titulo AS livro, escritores.nome AS autor FROM livros
JOIN escritores ON livros.escritor_id = escritores.id ORDER BY escritor, livro;
