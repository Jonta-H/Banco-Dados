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
    codMedico INT FOREIGN KEY REFERENCES medico(codMedico) NOT NULL,  -- Campo Obrigatório
    codPac INT FOREIGN KEY REFERENCES paciente(codPac) NOT NULL -- Não existe consulta sem Medico/Paciente
)

SELECT M.nome AS nomeMedico, C.data, P.nome AS nomePaciente -- Selecione colunas 'nome' como nomeMedico e nomePaciente, respectivamente
    FROM medico AS M INNER JOIN consulta AS C -- da intersecção (INNER) entre as tabelas 'medico' e 'consulta', tratadas como 'M' e 'C'
    ON M.codMedico = C.codMedico  -- em que o 'codMedico' sejam iguais (Relacionamento);
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
4. A data para consulta número 3 é '15/MAIO/2026' (atualize essa informação);
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

SELECT * FROM paciente
SELECT * FROM medico
SELECT * FROM especialidade
SELECT * FROM consulta

-- 1. Cadastre 6 pacientes;
INSERT INTO paciente VALUES
    ('JOÃO', '1699999999'),
    ('MARCELO', '1688888888'),
    ('MARIA', '1677777777'),
    ('PEDRO', '1666666666'),
    ('SERGIO', '1655555555'),
    ('ANA', '1644444444')

-- 2. Cadastre 10 consultas para médicos e pacientes diversos;
INSERT INTO consulta VALUES
    ('2026/05/01', 14, 5),
    ('2026/04/04', 7, 1),
    ('2026/04/14', 4, 4),
    ('2026/04/15', 11, 6),
    ('2026/01/30', 4, 5),
    ('2026/01/24', 11, 6),
    ('2026/03/02', 3, 3),
    ('2026/02/28', 8, 2),
    ('2026/05/02', 10, 1),
    ('2026/03/03', 3, 3)

-- 3. Atualize o nome do Médico 'João' para 'João da Silva';
UPDATE medico SET nome = 'JOÃO DA SILVA'
    WHERE nome = 'JOÃO'

-- 4. A data para consulta número 3 é  '15/MAIO/2026' (atualize essa informação);
UPDATE consulta SET data = '2026/05/15'
    WHERE codCons = 3

-- 5. Exclua a primeira consulta cadastrada;
DELETE FROM consulta
    WHERE codCons = 1

-- 6. Liste os nomes dos médicos e a especialidades de cada um;
SELECT M.nome AS nomeMedico, E.nome AS especialidade FROM
    medico AS M INNER JOIN especialidade AS E
    ON M.codEspec = E.codEspec

-- 7. Liste os médicos que não tem especialidades;
SELECT M.nome AS medicosSemEspecialidades FROM medico AS M
    WHERE M.codEspec IS NULL

-- 8. Liste as consultas feitas pelo convênio UNIMED no mês de Abril;
ALTER TABLE consulta ADD convenio varchar(20)
UPDATE consulta SET convenio = 'UNIMED' WHERE codCons <= 5
UPDATE consulta SET convenio = 'SUS' WHERE codCons > 5

SELECT C.data, M.nome AS nomeMedico, P.nome AS nomePaciente FROM
    medico AS M INNER JOIN consulta AS C
    ON M.codMedico = C.codMedico
    INNER JOIN paciente AS P
    ON P.codPac = C.codPac
        WHERE C.convenio = 'UNIMED' AND C.data BETWEEN '2026/03/31' AND '2026/05/01';

-- 9. Liste os nomes dos pacientes e os convênios que usaram nas suas consultas;
SELECT P.nome AS nomePaciente, C.convenio AS convenio, C.data FROM
    paciente AS P INNER JOIN consulta AS C
    ON P.codPac = C.codPac ORDER BY P.nome ASC

-- 10. Liste os telefones dos pacientes que nunca consultaram;
INSERT INTO paciente VALUES ('HENRIQUE', '17994513568'), ('JOSÉ', '16999543225')
SELECT P.nome AS nomePaciente, P.fone AS telefone FROM
    paciente AS P LEFT JOIN consulta AS C
    ON P.codPac = C.codPac
        WHERE C.codPac IS NULL

-- 11. Liste os convênios das consultas feitas por ORTOPEDISTAS;
UPDATE medico SET codEspec = 6 WHERE codMedico <= 4

SELECT C.data, M.nome AS nomeMedico, P.nome AS nomePaciente, C.convenio FROM
    consulta AS C INNER JOIN medico AS M
    ON C.codMedico = M.codMedico
    INNER JOIN paciente AS P
    ON C.codPac = P.codPac
    INNER JOIN especialidade AS E
    ON E.codEspec = M.codEspec
        WHERE E.nome = 'ORTOPEDISTA'

-- 12. Cadastre a especialidade 'NEUROLOGISTA' e atualize as especialidades de 2 médicos para esta nova;
INSERT INTO especialidade VALUES ('NEUROLOGISTA')

UPDATE medico SET codEspec = 7
    WHERE codMedico IN (6, 9, 12)

-- 13. Crie 3 consultas para médicos NEUROLOGISTAS no mês de MAIO/2026;
INSERT INTO consulta VALUES 
    ('2026/05/10', 6, 8),
    ('2026/05/15', 9, 9),
    ('2026/05/30', 12, 8)

-- 14. As consultas feitas pelos PEDIATRAS em ABRIL/2026 devem ser somente do convênio SUS. Atualize essa informação.
UPDATE consulta SET convenio = 'SUS' FROM   
    consulta AS C INNER JOIN medico AS M    -- faz junção para a partir dela
    ON C.codMedico = M.codMedico            -- alterar os dados desejados
    INNER JOIN especialidade AS E   
    ON E.codEspec = M.codEspec
        WHERE C.data BETWEEN '2026/03/31' AND '2026/05/01'
            AND E.nome = 'PEDIATRA'
