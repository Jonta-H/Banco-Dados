CREATE DATABASE HOTELARIA

USE HOTELARIA

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
    ('2026-11-20', '2026-11-25', 7, 4)

INSERT INTO Refeicao VALUES
    ('ARROZ', 15.0, 1),
    ('FEIJAO', 20.0, 2),
    ('MACARRAO', 40.0, 3),
    ('COCA-COLA', 10.0, 4),
    ('FRANGO', 50.0, 2),
    ('OVO', 30.0, 3)

-- 3. Qual a quantidade de quartos do tipo 'Superior Master' existe neste hotel?

-- 4. Qual o valor médio pago por uma refeição?

-- 5. Exclua o campo Idade e crie um campo para guardar a data de nascimento dos hóspedes

-- 6. Quantos hóspedes fizeram reserva neste hotel?

-- 7. Selecione os nomes dos hóspedes e as datas de entradas das suas reservas

-- 8. Atualize as datas de nascimentos de cada hóspede

-- 9. Selecione os nomes dos hóspedes, juntamente com as datas de entrada das hospedagens
-- que aconteceram antes do dia 01/01/2025. Faça esta lista mostrando os hóspedes em ordem alfabética

-- 10. Selecione os nomes das mulheres que já se hospedaram no 4º andar

-- 11. Selecione os números e tipos dos quartos que ainda não tiveram reservas

-- 12. O hóspede 'João da Silva' pagou quanto por suas hospedagens?

-- 13. Quantos hóspedes ficaram hospedados mais de 5 dias durante o mês de fevereiro deste ano?
