USE Constraint_BD

SELECT F.nome AS Funcionario, F.cpf, D.nome AS Departamento FROM
    Funcionario AS F INNER JOIN Departamento AS D
    ON F.codDep = D.codDep

SELECT F.nome AS Funcionario, F.categoria AS Categoria FROM 
    Funcionario AS F LEFT JOIN Departamento AS D
    ON F.codFunc = D.codFuncGerente
        WHERE D.codFuncGerente IS NULL

SELECT COUNT(*) AS qntAuxiliarCompras FROM 
    Funcionario AS F INNER JOIN Departamento AS D
    ON F.codDep = D.codDep
        WHERE F.categoria = 'Auxiliar' AND D.nome = 'COMPRAS'

SELECT F.nome AS Funcionario, F.cpf, P.dtInicio FROM
    Funcionario AS F INNER JOIN Participacao AS P
    ON F.codFunc = P.codFunc
        WHERE P.dtInicio BETWEEN '2026-08-01' AND '2026-08-31'

SELECT D.nome AS Departamento, F.nome AS Gerente FROM
    Departamento AS D INNER JOIN Funcionario AS F
    ON D.codFuncGerente = F.codFunc

SELECT MAX(F.idade) AS maiorIdade, AVG(F.idade) AS idadeMedia FROM
    Funcionario AS F INNER JOIN Departamento AS D
    ON F.codDep = D.codDep
        WHERE D.nome IN ('FATURAMENTO', 'VENDAS', 'COMPRAS')

SELECT F.nome AS funcionario, PJ.nome AS nomeProjeto, PJ.descricao AS descricaoProjeto FROM
    