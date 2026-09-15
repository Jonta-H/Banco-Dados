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

-- 1. Cidade do Fabricante tem valor padrão como sendo 'FRANCA'
ALTER TABLE Fabricante
    ADD CONSTRAINT DF_Cidade DEFAULT('FRANCA') FOR cidade

-- 2. Campo Razão Social é um campo obrigatório
ALTER TABLE Fabricante
    ALTER COLUMN razaoSocial VARCHAR(80) NOT NULL

-- 3. Só poderão ser cadastrados fabricantes de SP, MG ou RJ
ALTER TABLE Fabricante
    ADD CONSTRAINT CK_UF CHECK(uf in ('SP', 'MG', 'RJ'))

-- 4. Descrição do produto é obrigatório
ALTER TABLE Produto
    ALTER COLUMN descricao VARCHAR(50) NOT NULL

-- 5. Status da categoria pode ser ATIVO ou INATIVO
ALTER TABLE Categoria
    ADD CONSTRAINT CK_Status CHECK(status in ('ATIVO', 'INATIVO'))

-- 6. Crie um campo para guardar o estoque dos produtos. Deverá ser sempre um número positivo
ALTER TABLE Produto
    ADD estoque INT CHECK(estoque >= 0)

-- 7. Preço do produto deverá ser sempre maior que zero
ALTER TABLE Produto
    ADD CONSTRAINT CK_Preco CHECK(preco > 0)

-- 8. Observe as restrições impostas pelas cardinalidades
ALTER TABLE Produto
    ADD codFabr INT CONSTRAINT FK_Fabricante FOREIGN KEY REFERENCES Fabricante(codFabr) NOT NULL

ALTER TABLE Produto
    ADD codCat INT CONSTRAINT FK_Categoria FOREIGN KEY REFERENCES Categoria(codCat) NOT NULL

-- 9. Código da categoria deve ser um número inteiro de 3 dígitos
ALTER TABLE Categoria
    ADD CONSTRAINT CK_codCat CHECK (codCat <= 999)