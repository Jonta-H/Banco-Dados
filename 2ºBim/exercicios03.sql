CREATE DATABASE HOTELARIA

USE HOTELARIA

-- DBCC CHECKIDENT ('Refeicao', RESEED, 0);

CREATE TABLE Hospede(
    codHospede INT PRIMARY KEY IDENTITY(1,1),
    nome VARCHAR(80),
    idade INT,
    sexo CHAR(1)
)

CREATE TABLE Quarto(
    codQuarto INT PRIMARY KEY IDENTITY(1,1),
    tipo VARCHAR(30),
    numero INT,
    andar INT
)

CREATE TABLE Reserva(
    codReserva INT PRIMARY KEY IDENTITY(1,1),
    dtEntrada DATE,
    dtSaida DATE,
    codHospede INT FOREIGN KEY REFERENCES Hospede(codHospede) NOT NULL,
    codQuarto INT FOREIGN KEY REFERENCES Quarto(codQuarto) NOT NULL
)

CREATE TABLE Pagamento(
    codPagto INT PRIMARY KEY IDENTITY(1,1),
    valor MONEY,
    dtPagto DATE,
    codReserva INT FOREIGN KEY REFERENCES Reserva(codReserva) NOT NULL
)

CREATE TABLE Refeicao(
    codConsumo INT PRIMARY KEY IDENTITY(1,1),
    descRefeicao VARCHAR(30),
    valor MONEY,
    codReserva INT FOREIGN KEY REFERENCES Reserva(codReserva) NOT NULL
)

-- 2. Cadastre 5 quartos, 8 hóspedes, 4 reservas e 6 refeições
INSERT INTO Hospede VALUES
    ('MIGUEL', 24, 'M'),
    ('MARINA', 21, 'F'),
    ('LAURA A.', 32, 'F'),
    ('ISADORA', 20, 'F'),
    ('JONATA', 23, 'M'),
    ('LAURA C.', 19, 'F'),
    ('ROSA', 19, 'F'),
    ('PEDRO', 20, 'M')

INSERT INTO Quarto VALUES
    ('Suite', 1, 1),
    ('Superior Master', 2, 2),
    ('Solteiro', 4, 1),
    ('Casal', 3, 1),
    ('Superior Master', 5, 2)

INSERT INTO Reserva VALUES
    ('2026-09-20', '2026-09-25', 1, 2),
    ('2026-09-28', '2026-09-30', 3, 3),
    ('2026-10-10', '2026-10-15', 2, 5),
    ('2026-11-20', '2026-11-25', 3, 4)

INSERT INTO Refeicao VALUES
    ('ARROZ', 15.0, 1),
    ('FEIJAO', 20.0, 2),
    ('MACARRAO', 40.0, 3),
    ('COCA-COLA', 10.0, 4),
    ('FRANGO', 50.0, 2),
    ('OVO', 30.0, 3)

-- 3. Qual a quantidade de quartos do tipo 'Superior Master' existe neste hotel?
SELECT COUNT(*) AS quartosMaster FROM Quarto
    WHERE tipo = 'Superior Master'

-- 4. Qual o valor médio pago por uma refeição?
SELECT AVG(valor) AS valorMedioRefeicao FROM Refeicao

-- 5. Exclua o campo Idade e crie um campo para guardar a data de nascimento dos hóspedes
ALTER TABLE Hospede
DROP COLUMN idade

ALTER TABLE Hospede
ADD dtNasc DATE

-- 6. Quantos hóspedes fizeram reserva neste hotel?
SELECT COUNT(DISTINCT(H.codHospede)) AS hospedesComReserva FROM
    Hospede AS H INNER JOIN Reserva AS R
    ON H.codHospede = R.codHospede

-- 7. Selecione os nomes dos hóspedes e as datas de entradas das suas reservas
SELECT H.nome AS nomeHospede, R.dtEntrada AS dataEntrada, R.dtSaida AS dataSaida FROM
    Hospede AS H INNER JOIN Reserva AS R
    ON H.codHospede = R.codHospede

-- 8. Atualize as datas de nascimento de cada hóspede
UPDATE Hospede SET dtNasc = '2002-09-25'
    WHERE nome = 'JONATA'

-- 9. Selecione os nomes dos hóspedes, juntamente com as datas de entrada das hospedagens
-- que aconteceram antes do dia 01/01/2025. Faça esta lista mostrando os hóspedes em ordem alfabética
SELECT H.nome AS nomeHospede, R.dtEntrada AS dataEntrada FROM 
    Hospede AS H INNER JOIN Reserva AS R
    ON H.codHospede = R.codHospede
        WHERE R.dtEntrada < '2025-01-01'

-- 10. Selecione os nomes das mulheres que já se hospedaram no 4º andar
SELECT DISTINCT(H.nome) AS hospedes FROM 
    Hospede AS H INNER JOIN Reserva AS R
    ON H.codHospede = R.codHospede
    INNER JOIN Quarto AS Q
    ON R.codQuarto = Q.codQuarto
    WHERE H.sexo = 'F' AND Q.andar = 4

-- 11. Selecione os números e tipos dos quartos que ainda não tiveram reservas
SELECT Q.numero AS nroQuarto, Q.tipo AS tipoQuarto FROM
    Quarto AS Q LEFT JOIN Reserva AS R
    ON Q.codQuarto = R.codQuarto
    WHERE R.codQuarto IS NULL 

-- 12. O hóspede 'João da Silva' pagou quanto por suas hospedagens?
SELECT SUM(P.valor) AS totalPago FROM
    Hospede AS H INNER JOIN Reserva AS R
    ON H.codHospede = R.codHospede
    INNER JOIN Pagamento AS P
    ON P.codReserva = R.codReserva
    WHERE H.nome = 'João da Silva'

-- 13. Quantos hóspedes ficaram hospedados mais de 5 dias durante o mês de fevereiro deste ano?
SELECT COUNT(H.codHospede) AS qntHospedes FROM 
    Hospede AS H INNER JOIN Reserva AS R
    ON H.codHospede = R.codHospede
    WHERE DATEDIFF(DAY, dtEntrada, dtSaida) >= 5 
        AND R.dtEntrada BETWEEN '2026-02-01' AND '2026-02-28'
    --  AND MONTH(R.dtEntrada) = 2 AND YEAR(R.dtEntrada) = 2026