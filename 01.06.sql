CREATE DATABASE hospital;
USE hospital;

CREATE TABLE medico(
    codMedico int PRIMARY KEY IDENTITY(1,1),
    nome varchar(80),
    idade int,  -- o correto é guardar a data de nascimento
    salario money
)

CREATE TABLE especialidade(
    codEspec int PRIMARY KEY IDENTITY(1,1),
    nome varchar(30)
)

ALTER TABLE medico
    add codEspec int FOREIGN KEY REFERENCES especialidade(codEspec)

-- Cadastro das Especialidades
INSERT INTO especialidade VALUES
    ('OTORRINO'),
    ('OBSTRETA'),
    ('PEDIATRA'),
    ('CARDIOLOGISTA'),
    ('DERMATOLOGISTA'),
    ('ORTOPEDISTA')

SELECT * FROM especialidade

-- Cadastro dos Médicos
INSERT INTO medico VALUES
    ('JOÃO', 48, 800, 1),
    ('JOSÉ', 35, 1200, 1),
    ('ANA', 47, 1400, 3),
    ('IVO', 51, 750, NULL),
    ('SILVIO', NULL, 2550, 2),
    ('ADÃO', 62, 1950, 5),
    ('EVA', 42, 800, NULL),
    ('JOANA', 39, 1200, 1),
    ('AFONSO', NULL, 800, 3)

-- Cadastro de Médicos preenchendo apenas alguns campos
INSERT INTO medico(nome, idade, salario) VALUES
    ('KARINA', 40, 750),
    ('CARLA', 41, 1950)

-- Cadastro de Médicos preenchendo apenas alguns campos
INSERT INTO medico(nome, salario) VALUES
    ('RODOLFO', 1330)

SELECT * FROM medico

-- AS renomeia para resposta
SELECT M.nome AS nomeMed, E.nome AS nomeEspec FROM
    medico AS M LEFT JOIN especialidade AS E
    on M.codEspec = E.codEspec
    WHERE E.codEspec IS NULL;