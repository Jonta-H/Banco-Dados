CREATE DATABASE ClinicaVet

USE ClinicaVet

CREATE TABLE Veterinario(
    codMed INT PRIMARY KEY IDENTITY(1,1),
    nome VARCHAR(80),
    dataNasc DATE
)

CREATE TABLE Animal(
    codPac INT PRIMARY KEY IDENTITY(1,1),
    nomeAnimal VARCHAR(50),
    especie VARCHAR(30)
)

CREATE TABLE Consulta(
    codCons INT PRIMARY KEY IDENTITY(1,1),
    dataCons DATE,
    valor MONEY,
    codPac INT FOREIGN KEY REFERENCES Animal(codPac) NOT NULL,
    codMed INT FOREIGN KEY REFERENCES Veterinario(codMed) NOT NULL
)

INSERT INTO Veterinario VALUES 
    ('DR. JOSÉ', '2002-09-25'),
    ('DRA. MARIA', '2005-06-03'),
    ('DR. JOÃO', '2001-09-24'),
    ('DR. PEDRO', '1999-02-05'),
    ('DRA. ANA', '2000-11-15')

INSERT INTO Animal VALUES
    ('ZECA', 'CACHORRO'),
    ('NICA', 'CACHORRO'),
    ('NICO', 'CACHORRO'),
    ('CINZA', 'CALOPSITA'),
    ('BOB', 'COELHO'),
    ('LUNA', 'GATO'),
    ('LUKE', 'COELHO'),
    ('CAT', 'CACHORRO'),
    ('ZECA', 'GATO'),
    ('SCOOBY', 'CACHORRO')

INSERT INTO Consulta VALUES
    ('2026-01-01', 100.0, 1, 5),
    ('2026-02-07', 120.0, 2, 4),
    ('2026-03-01', 80.0, 3, 3),
    ('2026-04-14', 70.0, 4, 2),
    ('2026-05-15', 110.0, 5, 1),
    ('2026-06-23', 120.0, 6, 5),
    ('2026-07-26', 130.0, 7, 4),
    ('2026-08-28', 60.0, 8, 3),
    ('2026-07-17', 200.0, 9, 2),
    ('2026-06-15', 230.0, 10, 1),
    ('2026-05-12', 210.0, 10, 5),
    ('2026-04-10', 220.0, 9, 4),
    ('2026-03-31', 200.0, 8, 3),
    ('2026-02-28', 60.0, 7, 2),
    ('2026-01-16', 100.0, 6, 1),
    ('2025-10-15', 80.0, 5, 5),
    ('2025-09-16', 100.0, 4, 4),
    ('2025-09-23', 300.0, 3, 3),
    ('2025-10-14', 20.0, 2, 2),
    ('2025-11-30', 180.0, 1, 1)

-- 1. Selecione o maior valor pago por uma consulta
SELECT MAX(valor) FROM Consulta AS maiorValor

-- 2. Selecione o valor médio, maior valor e menor valor das consultas realizadas no mês passado
SELECT AVG(valor) AS valorMedio, MAX(valor) AS maiorValor, MIN(valor) AS menorValor
    FROM Consulta
    WHERE dataCons BETWEEN '2026-07-01' AND '2026-07-31'

-- 3. Cadastre uma nova consulta para um paciente que já está cadastrado
INSERT INTO Consulta VALUES
    ('2026-08-14', 100.0, 10, 3)

-- 4. Atualize o nome do méditoc cujo código é 3 para o seu nome
UPDATE Veterinario SET nome = 'JONATA'
    WHERE codMed = 3

-- 5. Selecione as espécies de pacientes que estão cadastrados
SELECT especie FROM Animal

-- 6. Quantas consultas você já realizou nesta clínica?
SELECT COUNT(*) AS consultasRealizadas FROM 
    Veterinario AS V INNER JOIN Consulta AS C
    ON V.codMed = C.codMed
        WHERE V.nome = 'JONATA'

-- 7. Quantas consultas foram feitas por todos os médicos?
SELECT COUNT(*) AS consultasRealizadas FROM Consulta

-- 8. Selecione, de forma exclusiva, as espécies de pacientes que estão cadastrados
SELECT DISTINCT(especie) FROM Animal

-- 9. Liste os nomes dos pacientes em ordem alfabética
SELECT nomeAnimal FROM Animal
    ORDER BY nomeAnimal

-- 10. Qual o valor total de todas as consultas feitas por você?
SELECT SUM(valor) AS valorTotal FROM
    Consulta AS C INNER JOIN Veterinario AS V
    ON C.codMed = V.codMed
    WHERE V.nome = 'JONATA'

-- 11. Qual a quantidade de médicos que esta clínica possui?
SELECT COUNT(*) AS qntMedicos FROM Veterinario

-- 12. Quanto seria o total das consultas que você realizou se estas consultas tivessem um aumento de 10%?
SELECT SUM(valor * 1.1)AS valorTotal FROM 
    Consulta AS C INNER JOIN Veterinario AS V
    ON C.codMed = V.codMed
    WHERE V.nome = 'JONATA'

-- 13. Quantas consultas foram feitas por você entre os dias 01/01/2026 e 31/03/2026
SELECT COUNT(*) AS consultasTrimestre FROM
    Consulta AS C INNER JOIN Veterinario AS V
    ON C.codMed = V.codMed
    WHERE V.nome = 'JONATA' AND C.dataCons BETWEEN '2026-01-01' AND '2026-03-31'