CREATE TABLE aluno (
    RA int,
    nome varchar(80),
    CPF varchar(11),
    mae varchar(80)
);

INSERT INTO aluno
VALUES (103, 'MATEUS', '12345678909', 'ANA'), 
(1002, 'MARCOS', '90876543212', 'ANA'),
(1004, 'LUCAS', '12345678345', 'MARINA');

SELECT * FROM aluno;

SELECT nome, CPF FROM aluno
WHERE mae = 'ANA';

UPDATE aluno SET mae = 'Luciana Ferreira'
WHERE RA = 103;

DELETE aluno
WHERE RA = 1002;

SELECT * FROM aluno
ORDER BY nome;