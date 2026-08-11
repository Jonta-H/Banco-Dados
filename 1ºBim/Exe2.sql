USE vendas2026

CREATE TABLE marca(
	idMarca int PRIMARY KEY,
	nome varchar(80),
	situacao char(1)
)

INSERT INTO marca
	VALUES (1, 'COCA-COLA', 'A'),
		(2, 'PEPSI', 'A'),
		(3, 'ANTARCTICA', 'A')


CREATE TABLE produto(
	idPro int PRIMARY KEY IDENTITY(1,1), -- Auto-incremento (início, incremento)
	nome varchar(100),
	preco money,
	cor varchar(40),
	idMarca int FOREIGN KEY REFERENCES marca(idMarca)
)

INSERT INTO produto(nome, preco)
VALUES ('COCA LATA 340 ml', 8.94)

UPDATE produto SET idMarca = 3
WHERE idPro = 1

CREATE TABLE fornecedor(
	idFor int PRIMARY KEY IDENTITY(1,1),
	razaoSocial varchar(50),
	cnpj varchar(20)
	)

ALTER TABLE produto
	ADD idFor INT FOREIGN KEY REFERENCES fornecedor(idfor)

----- Atividade Fixação

-- Exe 1
INSERT INTO produto(nome, preco)
	VALUES('Produto 2', 20.00),
		('Produto 3', 30.00),
		('Produto 4', 40.00)


-- Exe 2
INSERT INTO fornecedor VALUES
		-- (Razao, CNPJ)
		('Fornecedor 1', '987654321'),
		('Fornecedor 2', '234567891'),
		('Fornecedor 3', '345678912'),
		('Fornecedor 4', '456789123')


-- Exe 3
INSERT INTO marca VALUES (4, 'SKOL', 'A')

UPDATE marca SET nome = 'LEVÍSSIMA'
	WHERE nome = 'SKOL'


-- Exe 4
INSERT INTO produto VALUES
		-- (Nome, Preco, Cor, idMarca, idFor)
		('Produto 5', 50.00, 'Azul', 4, 2),
		('Produto 6', 60.00, 'Preto', 4, 3)


-- Exe 5
UPDATE fornecedor SET cnpj = '123456789'
	WHERE idFor = 3;


-- Exe 6
UPDATE produto SET idMarca = 2
	WHERE idMarca IS NULL;


-- Exe 7
DELETE FROM produto 
	WHERE idPro = 2;


-- Exe 8
UPDATE produto SET idMarca = 3
	WHERE idMarca = 4;

DELETE FROM marca
	WHERE idMarca = 4;


-- Exe 9
UPDATE produto SET preco = preco * 1.1
	where preco > 0;

-- Exe 10
UPDATE produto SET idFor = NULL
	WHERE idFor IS NOT NULL

DELETE FROM fornecedor