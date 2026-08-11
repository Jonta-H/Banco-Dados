CREATE DATABASE vendas2026
USE vendas2026

-- CRIAR A TABELA MARCA JÁ COM CHAVE PRIMÁRIA
CREATE TABLE marca(
    idMarca int PRIMARY KEY,
    nome varchar(80),
    situacao char(1)
)

-- CRIAR A TABELA PRODUTO COM PK MAS AINDA SEM FK
CREATE TABLE produto(
    idPro int PRIMARY KEY,
    nome varchar(100),
    preco money,
    cor varchar(40)
)