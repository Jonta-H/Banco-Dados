USE REVISAO_2026

-- FUNÇÕES DE AGREGAÇÃO:

-- MAX = retorna o valor máximo
SELECT MAX(estoque) AS maiorEstoque
    FROM produto

--- MIN = retorna o valor mínimo
SELECT MIN(estoque) AS menorEstoque
    FROM produto

SELECT MIN(estoque) AS menorEstoque, MAX(estoque) AS maiorEstoque
    FROM produto

-- SUM = retorna a soma
SELECT SUM(preco) AS precoTotal
    FROM produto

SELECT SUM(estoque * preco) AS ValorTotalEstoque 
    FROM produto

-- AVG = calcula a média
SELECT AVG(preco) AS precoMedio
    FROM produto

-- ROUND = função para arredondamento
SELECT ROUND(AVG(preco), 2) AS precoMedio
    FROM produto

-- COUNT = conta o número de ocorrências
SELECT COUNT(descricao) AS contagem
    FROM produto

SELECT COUNT(*) AS contagem
    FROM produto

-- SUBTRAÇÃO NO SELECT
SELECT COUNT(*) - COUNT(codCat) AS totalSemCategoria
    FROM produto

-- MULTIPLICAÇÃO PARA CRIAR CAMPO CALCULADO
-- Qual seria o novo preço dos produtos se aplicasse 10% de acréscimo?
SELECT descricao, preco, preco * 1.1 AS precoReajustado
    FROM produto

-- OUTRAS FUNÇÕES IMPORTANTES
-- DISTINCT = selecionar linhas exclusivas
SELECT DISTINCT(codCat) AS categoriasProdutos
    FROM produto

