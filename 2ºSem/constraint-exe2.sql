USE Constraint_BD

CREATE TABLE Marca(
    id_marca INT PRIMARY KEY IDENTITY(1,1),
    nome VARCHAR(40) UNIQUE
)

CREATE TABLE Produto(
    id_pro NUMERIC(4) PRIMARY KEY,
    nome_produto VARCHAR(40) NOT NULL,
    id_marca INT FOREIGN KEY REFERENCES Marca(id_marca) NOT NULL,
    estoque INT CHECK(estoque >= 0),
    preco MONEY,
    CONSTRAINT total_estoque CHECK(estoque * preco <= 250.000)
)

CREATE TABLE Pedido(
    id_pedido INT PRIMARY KEY IDENTITY(1,1),
    data DATE DEFAULT(GETDATE()),
    valor_desc MONEY,
    valor_total MONEY
)

CREATE TABLE ItemPedido(
    id_pedido INT FOREIGN KEY REFERENCES Pedido(id_pedido),
    id_pro NUMERIC(4) FOREIGN KEY REFERENCES Produto(id_pro),
    qtde INT,
    valor_unit MONEY,
    CHECK(valor_unit <= 1000 OR qtde < 100),
    CONSTRAINT pk_itemPedido PRIMARY KEY(id_pedido, id_pro)
)

-- Teste de registro sem nome_produto
INSERT INTO Marca VALUES ('COCA-COLA')
INSERT INTO Produto(nome_produto, id_marca, estoque, preco) VALUES ('Coca Lata', 1, 10, 9)

-- Teste registro com id_pro diferente de 4 dígitos
INSERT INTO Produto VALUES (11111, 'COCA-COLA LATA', 1, 5, 8) 

-- Teste data do pedido utilizando o valor padrão (GETDATE())
INSERT INTO Pedido VALUES (DEFAULT, 0, 8)

-- Tente de registro de item duplicado no mesmo pedido
INSERT INTO ItemPedido VALUES 
    (1, 1, 1, 8),
    (1, 1, 2, 8)

-- Teste de restrição de valor valor > 1000 e quantidade > 100
INSERT INTO ItemPedido VALUES (1, 1, 150, 1010)

-- Teste de restrição do valor total de estoque
INSERT INTO Produto VALUES (1020, 'GUARANA LATA', 1, 150, 7)