CREATE DATABASE VENDAS

USE VENDAS

CREATE TABLE Fabricante(
    codFabr INT PRIMARY KEY IDENTITY(100,1),
    razaoSocial VARCHAR(80),
    cidade VARCHAR(30),
    uf CHAR(2)
)

CREATE TABLE Categoria(
    codCat INT PRIMARY KEY IDENTITY(1,1),
    descricao VARCHAR(100),
    status VARCHAR(20)
)

CREATE TABLE Produto(
    codPro INT PRIMARY KEY IDENTITY(1,1),
    descricao VARCHAR(50),
    preco MONEY
)
-- 1.
-- a) Cidade do Fabricante tem valor padrão como sendo 'FRANCA'
ALTER TABLE Fabricante
    ADD CONSTRAINT DF_Cidade DEFAULT('FRANCA') FOR cidade

-- b) Campo Razão Social é um campo obrigatório
ALTER TABLE Fabricante
    ALTER COLUMN razaoSocial VARCHAR(80) NOT NULL

-- c) Só poderão ser cadastrados fabricantes de SP, MG ou RJ
ALTER TABLE Fabricante
    ADD CONSTRAINT CK_UF CHECK(uf in ('SP', 'MG', 'RJ'))

-- d) Descrição do produto é obrigatório
ALTER TABLE Produto
    ALTER COLUMN descricao VARCHAR(50) NOT NULL

-- e) Status da categoria pode ser ATIVO ou INATIVO
ALTER TABLE Categoria
    ADD CONSTRAINT CK_Status CHECK(status in ('ATIVO', 'INATIVO'))

-- f) Crie um campo para guardar o estoque dos produtos. Deverá ser sempre um número positivo
ALTER TABLE Produto
    ADD estoque INT CHECK(estoque >= 0)

-- g) Preço do produto deverá ser sempre maior que zero
ALTER TABLE Produto
    ADD CONSTRAINT CK_Preco CHECK(preco > 0)

-- h) Observe as restrições impostas pelas cardinalidades
ALTER TABLE Produto
    ADD codFabr INT CONSTRAINT FK_Fabricante FOREIGN KEY REFERENCES Fabricante(codFabr) NOT NULL

ALTER TABLE Produto
    ADD codCat INT CONSTRAINT FK_Categoria FOREIGN KEY REFERENCES Categoria(codCat) NOT NULL

-- i) Código da categoria deve ser um número inteiro de 3 dígitos
ALTER TABLE Categoria
    ADD CONSTRAINT CK_codCat CHECK (codCat <= 999)

-- 2.
-- a) Listar o código do produto, sua descrição e preço, a categoria, o nome e a cidade do fabricante
CREATE VIEW vProdCateg AS
    SELECT P.codPro, P.descricao, P.preco, C.descricao AS categoria, F.razaoSocial AS fabricante, F.cidade
    FROM Fabricante AS F INNER JOIN Produto AS P
    ON F.codFabr = P.codFabr
    INNER JOIN Categoria AS C
    ON P.codCat = C.codCat

-- b) Listar os produtos dos fabricantes do RJ
CREATE VIEW vFabrRJ AS
    SELECT P.codPro, P.descricao, P.preco FROM
    Produto AS P INNER JOIN Fabricante AS F
    ON P.codFabr = F.codFabr
        WHERE F.uf = 'RJ'

-- c) Selecionar de forma exclusiva as categorias que possuem produtos fornecidos para o estado de SP e que estão em categorias inativas
CREATE VIEW vCategSPInat AS
    SELECT C.codCat, C.descricao, C.status FROM
    Categoria AS C INNER JOIN Produto AS P
    ON C.codCat = P.codCat
    INNER JOIN Fabricante AS F
    ON P.codFabr = F.codFabr
    WHERE F.uf = 'SP' AND C.status = 'INATIVO'

-- d) Listar os nomes dos produtos, o preço total dos seus estoques (considerando o preço de venda) e o nome das categorias
-- que eles pertencem. Somente de produtos fabricados em SP
CREATE VIEW vProdEstoq AS 
    SELECT P.descricao, (P.preco * P.estoque) AS totalEstoque, C.descricao AS categoria FROM
    Produto AS P INNER JOIN Categoria AS C
    ON P.codCat = C.codCat
    INNER JOIN Fabricante AS F
    ON P.codFabr = F.codFabr
        WHERE F.uf = 'SP'

-- 3. Crie uma nova tabela para cadastro de Marcas com os campos CodMarca e NomeMarca. 
-- O código deverá ser chave primária com numeração automática a partir de 5000 e o Nome da marca precisará ser único e de preenchimento obrigatório.
CREATE TABLE Marca(
    codMarca INT PRIMARY KEY IDENTITY(5000, 1),
    nomeMarca VARCHAR(80) UNIQUE NOT NULL
)

-- 4. Cada produto poderá ter apenas uma marca
ALTER TABLE Produto
    ADD codMarca INT CONSTRAINT FK_Marca FOREIGN KEY REFERENCES Marca(codMarca) NOT NULL

-- 5. Cadastre 5 marcas
INSERT INTO Marca (nomeMarca) VALUES
    ('Nike'),
    ('Adidas'),
    ('Puma'),
    ('Asics'),
    ('Mizuno');

-- 6. Crie uma view que informe quais são os fabricantes e as marcas dos produtos que estão nas categorias inativas
CREATE VIEW vProdFabrINTV AS
    SELECT DISTINCT(F.codFabr), F.razaoSocial AS fabricante, M.nomeMarca FROM
    Fabricante AS F INNER JOIN Produto AS P
    ON F.codFabr = P.codFabr
    INNER JOIN Marca AS M
    ON P.codMarca = M.codMarca
    INNER JOIN Categoria AS C
    ON P.codCat = C.codCat
        WHERE C.status = 'INATIVO'

-- 7. Crie uma nova view para mostrar a descrição e os preços dos produtos e suas respectivas marcas, ordenado por produto
CREATE VIEW vProduto AS
    SELECT P.descricao, P.preco, M.nomeMarca FROM
    Produto AS P INNER JOIN Marca AS M
    ON P.codMarca = M.codMarca

SELECT * FROM vProduto ORDER BY descricao