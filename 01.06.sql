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

CREATE TABLE paciente(
    codPac INT PRIMARY KEY IDENTITY(1,1),
    nome varchar(40),
    fone varchar(30)
)

CREATE TABLE consulta(
    codCons INT PRIMARY KEY IDENTITY(1,1),
    data date,
    codMed INT FOREIGN KEY REFERENCES medico(codMed) NOT NULL,  -- Campo Obrigatório
    codPac INT FOREIGN KEY REFERENCES paciente(codPac) NOT NULL -- Não existe consulta sem Medico/Paciente
)


SELECT M.nome AS nomeMedico, C.data, P.nome AS nomePaciente -- Selecione colunas 'nome' como nomeMedico e nomePaciente, respectivamente
    FROM medico AS M INNER JOIN consulta AS C -- da intersecção (INNER) entre as tabelas 'medico' e 'consulta', tratadas como 'M' e 'C'
    ON M.codMed = C.codMed  -- em que o 'codMedico' sejam iguais (Relacionamento);
    INNER JOIN paciente AS P -- interseccionado com a tabela 'paciente', tratado como 'P',
    ON P.codPac = C.codPac  -- onde 'codPac' de 'consulta' e 'paciente' correspondam entre si;
    INNER JOIN especialidade as E   -- interseccionado com 'especialidade', tratada como 'E',
    ON M.codEspec = E.codEspec  -- que tenha um 'medico' correspondendo à sua chave 'codEspec';
    WHERE C.data BETWEEN '2026/05/01' AND '2026/05/31'  -- filtrado para buscar um período específico
        AND E.nome = 'PEDIATRA' -- e uma especialidade específica

/* EXERCÍCIOS DE FIXAÇÃO
1. Cadastre 6 pacientes;
2. Cadastre 10 consultas para médicos e pacientes diversos;
3. Atualize o nome do Médico 'João' para 'João da Silva';
4. A data para consulta número 3 é  '15/MAIO/2026' (atualize essa informação);
5. Exclua a primeira consulta cadastrada;
6. Liste os nomes dos médicos e a especialidades de cada um;
7. Liste os médicos que não tem especialidades;
8. Liste as consultas feitas pelo convênio UNIMED no mês de Abril;
9. Liste os nomes dos pacientes e os convênios que usaram nas suas consultas;
10. Liste os telefones dos pacientes que nunca consultaram;
11. Liste os convênios das consultas feitas por ORTOPEDISTAS;
12. Cadastre a especialidade 'NEUROLOGISTA' e atualize as especialidades de 2 médicos para esta nova;
13. Crie 3 consultas para médicos NEUROLOGISTAS no mês de MAIO/2026;
14. As consultas feitas pelos PEDIATRAS em ABRIL/2026 devem ser somente do convênio SUS. Atualize essa informação.
*/