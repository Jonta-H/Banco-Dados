USE Constraint_BD


/* 1. Crie uma tabela para cadastro de Funcionários, obedecendo as seguintes regras:
    - Um campo para código deverá ser chave primária com numeração automática
    - Defina as chaves de todas as demais tabelas desta forma
    - Nome é um atributo obrigatório
    - CPF e RG são atributos que têm valor único para cada funcionário
    - Sexo poderá ser: "M" ou "F"
    - Categoria deverá ser um dos seguintes valores: Auxiliar, Supervisor, Terceirizado, Contratado, Coordenador
    - Idade deve estar entre 16 e 65 anos
    - Código de departamento que este funcionário trabalha
  */  
CREATE TABLE Funcionario(
    codFunc INT PRIMARY KEY IDENTITY(1,1),
    nome VARCHAR(80) NOT NULL,
    cpf VARCHAR(11) UNIQUE,
    rg VARCHAR(9) UNIQUE,
    sexo CHAR(1) CHECK(sexo in ('M', 'F')),
    categoria VARCHAR(20) CHECK(categoria in ('Auxiliar', 'Supervisor', 'Terceirizado', 'Contratado', 'Coordenador')),
    idade INT CHECK(idade BETWEEN 16 AND 65),
    codDep INT
)

/* 2. Crie uma tabela para cadastro de Departamentos, com as seguintes restrições:
    - Um campo para código do departamento também com numeração automática
    - Nome do departamento é atributo obrigatório
    - Descrição do departamento
    - Código do funcionário gerente do departamento
*/
CREATE TABLE Departamento(
    codDep INT PRIMARY KEY IDENTITY(1,1),
    nome VARCHAR(30) NOT NULL,
    descricao VARCHAR(100),
    codFuncGerente INT FOREIGN KEY REFERENCES Funcionario(codFunc)
)

/* 3. Crie uma tabela para cadastro de Projetos
    - Código do projeto é atributo obrigatório com numeração automática a partir de 100
    - Nome é atributo obrigatório
    - Descrição do projeto
*/
CREATE TABLE Projetos(
    codProj INT PRIMARY KEY IDENTITY(100, 1),
    nome VARCHAR(80) NOT NULL,
    descricao VARCHAR(100) 
)

/* 4. Crie uma tabela para registrar a participação dos funcionários em projetos
    - Código do funcionário deverá ser obrigatório
    - Código do projeto deverá também ser obrigatório
    - Data de início da participação no projeto
    - Data de fim da participação do projeto
        - A data de início deverá ser menor que a data de fim
*/
CREATE TABLE Participacao(
    codFunc INT NOT NULL,
    codProj INT NOT NULL,
    dtInicio DATE,
    dtFim DATE,
    CONSTRAINT ch_dtInicio CHECK(dtInicio < dtFim)
)

-- 5. Altere a tabela Funcionário criando uma ligação com a tabela de departamentos
ALTER TABLE Funcionario
    ADD CONSTRAINT FK_Departamento FOREIGN KEY(codDep) REFERENCES Departamento(codDep)

-- 6. Crie uma restrição do tipo Chave Primária composta para a tabela Participação
ALTER TABLE Participacao
    ADD CONSTRAINT PK_Participacao PRIMARY KEY(codFunc, codProj)

/* 7. Cadastre os seguintes departamentos:
    - CONTAS A PAGAR
    - CONTAS A RECEBER
    - FATURAMENTO
    - VENDAS
    - COMPRAS
*/
INSERT INTO Departamento(nome, descricao) VALUES
    ('CONTAS A PAGAR', 'Departamento de contas a pagar'),
    ('CONTAS A RECEBER', 'Departamento de consta a receber'),
    ('FATURAMENTO', 'Departamento de faturamento'),
    ('VENDAS', 'Departamento de vendas'),
    ('COMPRAS', 'Departamento de compras')

-- 8. Cadastre 5 projetos 
INSERT INTO Projetos VALUES
    ('Projeto 1', 'Primeiro projeto'),
    ('Projeto 2', 'Segundo projeto'),
    ('Projeto 3', 'Terceiro projeto'),
    ('Projeto 4', 'Quarto projeto'),
    ('Projeto 5', 'Quinto projeto')

-- 9. Cadastre 10 funcionários
INSERT INTO Funcionario(nome, cpf, rg, sexo, categoria, idade) VALUES
    ('Ana', '12345678901', '123456789', 'F', 'Auxiliar', 24),
    ('Bruno', '23456789012', '234567890', 'M', 'Supervisor', 35),
    ('Carla', '34567890123', '345678901', 'F', 'Terceirizado', 29),
    ('Diego', '45678901234', '456789012', 'M', 'Contratado', 41),
    ('Elisa', '56789012345', '567890123', 'F', 'Coordenador', 38),
    ('Fabio', '67890123456', '678901234', 'M', 'Auxiliar', 19),
    ('Gabriela', '78901234567', '789012345', 'F', 'Supervisor', 32),
    ('Henrique', '89012345678', '890123456', 'M', 'Terceirizado', 27),
    ('Isabela', '90123456789', '901234567', 'F', 'Contratado', 45),
    ('Joao', '01234567890', '012345678', 'M', 'Coordenador', 50)
    
-- 10. Vincule 3 funcionários para cada um dos projetos cadastrados
INSERT INTO Participacao VALUES
    (1, 100, '2026-01-10', '2026-03-10'),
    (2, 100, '2026-01-15', '2026-03-15'),
    (3, 100, '2026-02-01', '2026-04-01'),
    (4, 101, '2026-01-20', '2026-03-20'),
    (5, 101, '2026-02-05', '2026-04-05'),
    (6, 101, '2026-02-10', '2026-04-10'),
    (7, 102, '2026-03-01', '2026-05-01'),
    (8, 102, '2026-03-05', '2026-05-05'),
    (9, 102, '2026-03-10', '2026-05-10'),
    (10, 103, '2026-04-01', '2026-06-01'),
    (1, 103, '2026-04-05', '2026-06-05'),
    (2, 103, '2026-04-10', '2026-06-10'),
    (3, 104, '2026-05-01', '2026-07-01'),
    (4, 104, '2026-05-05', '2026-07-05'),
    (5, 104, '2026-05-10', '2026-07-10')

-- 11. Cadastre os chefes dos departamentos
UPDATE Departamento SET codFuncGerente = 2
    WHERE codDep = 1

UPDATE Departamento SET codFuncGerente = 5
    WHERE codDep = 2

UPDATE Departamento SET codFuncGerente = 7
    WHERE codDep = 3

UPDATE Departamento SET codFuncGerente = 10
    WHERE codDep = 4

UPDATE Departamento SET codFuncGerente = 9
    WHERE codDep = 5

-- 12. Crie um campo para cidade do funcionário com valor padrão sendo 'Franca'
ALTER TABLE Funcionario
    ADD COLUMN cidade VARCHAR(20) DEFAULT('FRANCA')

-- 13. Cadastre um novo funcionário sem preencher a cidade para testar sua constraint
INSERT INTO Funcionario(nome) VALUES ('Kaique')

-- 14. Crie um novo projeto e vincule 5 funcionários a este projeto
INSERT INTO Projetos VALUES ('Projeto 6', 'Sexto projeto')

INSERT INTO Participacao VALUES 
    (1, 105, GETDATE(), '2026-09-30'),
    (2, 105, GETDATE(), '2026-09-30'),
    (3, 105, GETDATE(), '2026-09-30'),
    (4, 105, GETDATE(), '2026-09-30'),
    (5, 105, GETDATE(), '2026-09-30')

-- 15. Verifique se existe algum funcionário sem departamento, se houver, vincule os funcionários a algum departamento
SELECT F.nome, F.codFunc, D.codDep FROM
    Funcionario AS F LEFT JOIN Departamento AS D
    ON F.codDep = D.codDep
    WHERE F.codDep IS NULL

UPDATE Funcionario SET codDep = 2 
    WHERE nome = 'Kaique'

-- 16. Crie uma restrição para os campos Descricao das tabelas que possuem. Esta restrição deverá inserir um valor padrão para o campo
ALTER TABLE Departamento 
    ADD CONSTRAINT DF_Descricao DEFAULT('Descricao do departamento') FOR descricao

ALTER TABLE Projetos 
    ADD CONSTRAINT DF_Projetos DEFAULT('Descricao do projeto') FOR descricao

-- 17. Exclua as tabelas que você criou
DROP TABLE Participacao
DROP TABLE Projetos

ALTER TABLE Funcionario DROP CONSTRAINT FK_Departamento

DROP TABLE Departamento
DROP TABLE Funcionario