//1
SELECT titulo FROM livros;

//2
SELECT nome FROM autores 
WHERE nascimento < '1900-01-01';

//3
SELECT livros.titulo, nome.escritores FROM livros
INNER JOIN escritores ON livros.escritor_id = escritores.id WHERE nome.escritores = 'J.K. Rowling';

//4
SELECT alunos.nome, matricula.curso FROM alunos
INNER JOIN matriculas ON alunos.id = matriculados.aluno_id WHERE matricula.curso = 'Engenharia de Software';

//5
SELECT produto, SUM(receita) AS receita_numero FROM vendas
GROUP BY produto;

//6
SELECT autores.nome AS autor, COUNT(livros.id) AS livros_todos FROM autores
LEFT JOIN livros ON autores.id = livros.autor_id GROUP BY autores.id ORDER BY autores.id;

//7
SELECT curso, COUNT(aluno_id) AS alunos_matriculados FROM matriculas
GROUP BY curso 
ORDER BY curso;

//8
SELECT produto, AVG(receita) AS num_receita FROM vendas
GROUP BY produto 
ORDER BY produto;

//9
SELECT produto, SUM(receita) AS total_receitas FROM vendas
GROUP BY produto 
HAVING SUM(receita) > '10.000' ORDER BY produto;

//10
SELECT autores.nome AS autor, COUNT(livros.id) AS quant_livros FROM autores
LEFT JOIN livros ON autores.id = livros.autor_id  GROUP BY autores.id 
HAVING COUNT(livros.id) > '2';

//11
SELECT livros.titulo AS livro, escritores.nome AS autor FROM livros
JOIN escritores ON livros.escritor_id = escritores.id ORDER BY escritor, livro;

//12
SELECT alunos.nome AS aluno, matriculas.curso FROM alunos 
JOIN matriculas ON alunos.id = matriculas.aluno_id ORDER BY aluno, curso;

//13
SELECT escritores.nome AS escritor, livros.titulo AS livro FROM escritores
LEFT JOIN livros ON escritores.id = livros.escritor_id ORDER BY escritor, livro;

//14
SELECT alunos.nome AS aluno, matriculas.curso FROM matriculas
RIGHT JOIN alunos ON matriculas.aluno_id = alunos.id ORDER BY curso, aluno;

//15
SELECT alunos.nome AS aluno, matriculas.curso FROM matriculas
INNER JOIN alunos ON matriculas.aluno_id = alunos.id ORDER BY aluno, curso;

//16
SELECT nome FROM escritor
WHERE id = (
   SELECT escritor_id
   FROM livros
   GROUP BY escritor_id
   ORDER BY COUNT(*) desc
   LIMIT 1
);

//17
SELECT produto, SUM(receita) AS menor_receita FROM vendas
GROUP BY produto ORDER BY menor_receita LIMIT 1;

//18
SELECT alunos.nome AS aluno, COUNT(matriculas.id) AS numero_matriculas FROM alunos
LEFT JOIN matriculas ON alunos.id = matriculas.alunos_id 
GROUP BY alunos.id ORDER BY aluno;

//19
SELECT produto, COUNT(id) AS numeros_transacoes FROM vendas
GROUP BY produto ORDER BY numeros_transacoes desc LIMIT 1;
