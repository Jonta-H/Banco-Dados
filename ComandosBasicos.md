## Comando para criar uma nova tabela
CREATE TABLE aluno (  
  -- Declarar colunas e tipos de dados  
    RA int,  
    nome varchar(80),  
    fone varchar(30),  
    pai varchar(80),  
    mae varchar(80),  
    data_nasc date  
);  
  
## Comando para inserir (cadastrar) um registro na tabela  
INSERT INTO aluno  
VALUES (26387, 'MARINA', '16999951475', 'MARCOS', 'SILVIA', '2005/06/03'),  
(502043, 'JOÃO', '17332932592', 'PEDRO', 'CARLA', '2005/05/15'),  
(562346, 'ANA', '162432402505', 'JORGE', 'MARTA', '2003/08/30'),  
(98593, 'MATHIAS', '35949523752', 'JEREMIAS', 'RENATA', '2010/02/28');
  
## Comando para selecionar todos os registros de uma tabela  
SELECT * FROM aluno;  
  
## Comando para crescentar uma coluna nova à tabela  
ALTER TABLE aluno  
 ADD email varchar(50);  
  
SELECT * FROM aluno;  
  
## Comando para excluir uma coluna da tabela  
ALTER TABLE aluno  
 DROP COLUMN pai;  
  
SELECT * FROM aluno;  
  
## Comando para atualizar valores de uma coluna da tabela  
## CUIDADO! Este comando precisa de um filtro para não afetar todas as linhas da tabela  
UPDATE aluno SET email = 'marinanevesa@gmail.com'  
WHERE RA = 26387;  

SELECT * FROM aluno;  

## O comando WHERE pode ser usado para filtrar linhas da tabela junto com outros comandos  
SELECT * FROM aluno  
WHERE RA < 30000;  
  
SELECT * FROM aluno  
WHERE mae <> 'SILVIA'; -- <> funciona como !=  
  
## Comando para excluir regitros da tabela (apagar a linha  
DELETE aluno  
WHERE mae = 'MARTA';  
  
## Comando para ordenar o resultado de uma consulta  
SELECT * FROM aluno  
ORDER BY nome;  
  
## Deleta todas as linhas  
DELETE aluno -- Deleta toda a tabela  
SELECT * FROM aluno  
