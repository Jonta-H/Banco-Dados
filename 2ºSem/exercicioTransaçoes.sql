CREATE DATABASE TRANSACOES_VENDAS
GO
USE TRANSACOES_VENDAS

CREATE TABLE FINANCEIRO (
    codFinanceiro INT CONSTRAINT PK_Financeiro PRIMARY KEY IDENTITY(1,1),
    dtLancamento DATE,
    dtVencimento DATE,
    dtLiq DATE,
    valor MONEY,

    CONSTRAINT CK_Financeiro_DtVencto_DtLancto CHECK(dtVencimento >= dtLancamento)
)

CREATE TABLE PRODUTO (
    codProduto INT CONSTRAINT PK_Produto PRIMARY KEY IDENTITY(1,1),
    estoque INT,
    unidade VARCHAR(30),
    nome VARCHAR(80),

    -- 5.e. Para os produtos vendidos com unidade 'PÇ' o estoque não poderá ser negativo
    CONSTRAINT CK_Produto_UnidadeEstoque CHECK((unidade = 'PÇ' AND estoque >= 0) OR unidade != 'PÇ')
)

CREATE TABLE CLIENTE (
    codCliente INT CONSTRAINT PK_Cliente PRIMARY KEY IDENTITY(1,1),
    -- 5.a. Nome do cliente é um campo obrigatório
    nome VARCHAR(80) NOT NULL, 
    fone VARCHAR(11),
    lmtCredito MONEY
)

CREATE TABLE ENDERECO (
    codEndereco INT CONSTRAINT PK_Endereco PRIMARY KEY IDENTITY(1,1),
    cep VARCHAR(8),
    bairro VARCHAR(80),
    nro INT,
    rua VARCHAR(160),
    codCliente INT CONSTRAINT FK_Endereco_Cliente FOREIGN KEY REFERENCES CLIENTE(codCliente)
)

CREATE TABLE VENDEDOR (
    codVendedor INT CONSTRAINT PK_Vendedor PRIMARY KEY IDENTITY(1,1),
    -- 5.d. Função do vendedor só pode ser 'Balcão', 'Externo', 'Aprendiz', 'Supervisor'
    funcao VARCHAR(30) CONSTRAINT CK_Vendedor_Funcao CHECK(funcao IN ('Balcão', 'Externo', 'Aprendiz', 'Supervisor')),
    fone VARCHAR(11),
    nome VARCHAR(80)
)

CREATE TABLE SALARIO (
    codSalario INT CONSTRAINT PK_Salario PRIMARY KEY IDENTITY(1,1),
    dtAlteracao DATE,
    vlFixo MONEY,
    vlComissao MONEY,
    codVendedor INT CONSTRAINT FK_Salario_Vendedor FOREIGN KEY REFERENCES VENDEDOR(codVendedor),

    -- 5.f. Quando o salário fixo for maior que R$ 2.000,00 a comissão não poderá ser maior que R$ 1.800,00
    CONSTRAINT CK_Salario_LimiteComissao CHECK((vlFixo > 2000 AND vlComissao <= 1800) OR vlFixo <= 2000)
)

CREATE TABLE COMISSAO (
    codComissao INT CONSTRAINT PK_Comissao PRIMARY KEY IDENTITY(1,1),
    -- 5.c. Valor da comissão deve ser sempre maior que zero
    valor MONEY CONSTRAINT CK_Comissao_ValorMinimo CHECK(valor > 0),
    codSalario INT CONSTRAINT FK_Comissao_Salario FOREIGN KEY REFERENCES SALARIO(codSalario)
)

CREATE TABLE VENDA (
    codVenda INT CONSTRAINT PK_Venda PRIMARY KEY IDENTITY(1,1),
    -- 5.b. Data da venda tem valor padrão como sendo a data atual do sistema
    dtVenda DATE CONSTRAINT DF_Venda_DataPadrão DEFAULT(GETDATE()),
    vlFrete MONEY,
    situacao VARCHAR(30),
    codFinanceiro INT CONSTRAINT FK_Venda_Financeiro FOREIGN KEY REFERENCES FINANCEIRO(codFinanceiro),
    codCliente INT CONSTRAINT FK_Venda_Cliente FOREIGN KEY REFERENCES CLIENTE(codCliente),
    codVendedor INT CONSTRAINT FK_Venda_Vendedor FOREIGN KEY REFERENCES VENDEDOR(codVendedor),
    codComissao INT CONSTRAINT FK_Venda_Comissao FOREIGN KEY REFERENCES COMISSAO(codComissao)
)

CREATE TABLE ITEM_VENDA (
    codItem INT CONSTRAINT PK_ItemVenda PRIMARY KEY IDENTITY(1,1),
    qntde INT,
    vlUnitario MONEY,
    codProduto INT CONSTRAINT FK_ItemVenda_Produto FOREIGN KEY REFERENCES PRODUTO(codProduto),
    codVenda INT CONSTRAINT FK_ItemVenda_Venda FOREIGN KEY REFERENCES VENDA(codVenda)
)

-- 6.a. Os registro de financeiro só poderão ser inseridos no momento em que um registro de venda for atualizado para 'Registrado'
BEGIN TRANSACTION RegistroFinanceiro
    BEGIN TRY 
        INSERT INTO FINANCEIRO(dtLancamento, dtVencimento, valor) VALUES (GETDATE(), GETDATE(), 1000)
        INSERT INTO VENDA(codFinanceiro) VALUES (1)
        UPDATE VENDA SET situacao = 'REGISTRADO' WHERE codFinanceiro = 1
        -- 6.c. Quando uma venda for inserida, sua comissão pode ser inserida
        INSERT INTO COMISSAO(valor) VALUES (100)
        COMMIT TRANSACTION RegistroFinanceiro
    END TRY
    BEGIN CATCH
        SELECT ERROR_LINE() AS LINHA, ERROR_MESSAGE() AS ERRO
        ROLLBACK TRANSACTION RegistroFinanceiro
    END CATCH

INSERT INTO PRODUTO VALUES (15, 'PÇ', 'PREGO')

-- 6.b. Após a inserção de cada item da venda, os estoques dos produtos deverão ser atualizados
BEGIN TRANSACTION VendaEstoque
    BEGIN TRY
        INSERT INTO ITEM_VENDA VALUES (2, 3, 1, 4)
        UPDATE PRODUTO SET estoque = estoque - 2 WHERE codProduto = 1
        COMMIT TRANSACTION VendaEstoque
    END TRY
    BEGIN CATCH
        SELECT ERROR_LINE() AS LINHA, ERROR_MESSAGE() AS ERRO
        ROLLBACK TRANSACTION VendaEstoque
    END CATCH