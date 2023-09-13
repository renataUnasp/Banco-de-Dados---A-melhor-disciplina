SELECT titulo FROM livros;

SELECT nome FROM autores 
WHERE nascimento < '1900-01-01';

SELECT livros.titulo, nome.escritores FROM livros
INNER JOIN escritores ON livros.escritor_id = escritores.id WHERE nome.escritores = 'J.K. Rowling';

SELECT alunos.nome, matricula.curso FROM alunos
INNER JOIN matriculas ON alunos.id = matriculados.aluno_id WHERE matricula.curso = 'Engenharia de Software';

SELECT produto, SUM(receita) AS receita_numero FROM vendas
GROUP BY produto;
