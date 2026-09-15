CREATE DATABASE Constraint_BD

USE Constraint_BD

CREATE TABLE TB_CLIENTE(
    cod INT PRIMARY KEY IDENTITY(1,1),
    nome VARCHAR(50) NOT NULL,
    telefone VARCHAR(20) NOT NULL,
    tipo_cliente VARCHAR(20) CHECK(tipo_cliente in ('TITULAR', 'DEPENDENTE')) NOT NULL,
    dt_cadastro DATETIME DEFAULT(GETDATE()) NOT NULL,
    nr_dependentes INT CHECK(nr_dependentes BETWEEN 0 AND 3) NOT NULL,
)

-- Teste com todos os dados corretos
INSERT INTO TB_CLIENTE VALUES 
    ('Marina', '123456789', 'TITULAR', DEFAULT, 0)

-- Teste com nr_dependentes negativo
INSERT INTO TB_CLIENTE VALUES
    ('Laura', '987654321', 'TITULAR', DEFAULT, -1)

-- Teste com tipo_cliente inválido
INSERT INTO TB_CLIENTE VALUES
    ('Laura', '987654321', 'TESTE', DEFAULT, 1)