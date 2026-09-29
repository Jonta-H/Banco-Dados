CREATE DATABASE REVISAO_2026

USE REVISAO_2026

CREATE TABLE categoria(
    codCat INT PRIMARY KEY IDENTITY(1,1),
    nomeCat varchar(50)
)

CREATE TABLE produto(
    codPro INT PRIMARY KEY IDENTITY(1,1),
    descricao VARCHAR(100),
    codBarras VARCHAR(30),
    estoque INT,
    codCat INT FOREIGN KEY REFERENCES categoria(codCat)
)

INSERT INTO categoria VALUES
    ('BEBIDAS'),
    ('ALIMENTOS'),
    ('HIGIENE'),
    ('LIMPEZA'),
    ('ELETRONICOS')

INSERT INTO produto VALUES
    ('COCA-COLA', '789456123', 400, 1),
    ('PEPSI', '45612356', 300, 1),
    ('ARROZ', '872349873', 220, 2),
    ('SABÃO EM PÓ', '842903475', 90, 4),
    ('SHAMPOO', '13413551235', 100, 3),
    ('DETERGENTE', '4156664312', 150, 4),
    ('TELEVISAO', '9812347413', 80, 5),
    ('NOTEBOOK', '341235935', 180, 5)

-- 4. Altere o estoque do produto de código 4 para 350
UPDATE produto SET estoque = 350
    WHERE codPro = 4

-- 5. Liste a descrição, código de barras e estoque dos produtos que têm estoque maior que 500
SELECT descricao, codBarras, estoque FROM produto
    WHERE estoque > 500

-- 6. Exclua os produtos da categoria de código 3
DELETE produto WHERE codCat = 3

-- 7. Cadastre um novo produto sem preencher o código de barras
INSERT INTO produto(descricao, estoque, codCat) VALUES
    ('CELULAR', 850, 5)

-- 8. Exclua a coluna código de barras
ALTER TABLE produto
    DROP COLUMN codBarras

-- 9. Liste a descrição e os estoques dos produtos em ordem decrescente
SELECT descricao, estoque FROM produto
    ORDER BY estoque DESC

-- 10. Crie uma nova coluna para guardar o preço unitário dos produtos
ALTER TABLE produto 
    ADD preco MONEY

-- 11. Exclua os produtos cujas categorias sejam dos códigos 1, 3 ou 5
DELETE produto 
    WHERE codCat IN (1,3,5)

-- 12. Atualize cada preço unitário dos produtos (não deixe todos os valores iguais)
UPDATE produto SET preco = 1.99
    WHERE codPro = 1

-- 13. Liste a descrição dos produtos e os nomes das categorias que pertencem
SELECT P.descricao, C.nomeCat FROM 
    produto AS P INNER JOIN categoria AS C
    ON P.codCat = C.codCat

-- 14. Liste as categorias que não possuem produtos vinculados à ela
SELECT nomeCat FROM  
    categoria AS C LEFT JOIN produto AS P
    ON C.codCat = P.codCat
    WHERE P.codCat IS NULL

-- 15. Aumente o preço dos produtos em 5%. Esta alteração deve atingir somente produtos que possuem estoque menor que 400
UPDATE produto SET preco = preco * 1.05
    WHERE estoque > 400