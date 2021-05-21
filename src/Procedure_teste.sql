Procedure SQL Exemplo estudo

/* PROCEDURE USADA PARA A TABELA DERIVADA CLIENTES TRANSAÇÕES
EM ARQUIVO VERSIONADO. */ 
USE [DS_TRAINING]
GO
/****** Object:  StoredProcedure [dbo].[SP_DRV_CLIENTESTRANSACOES]    Script Date: 7/11/2019 11:13:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Luciano Lessa
-- Create date: 20190708
-- Description:	PROCEDURE QUE CRIA A TAB DRV_CLIENTESTRANSACOES
-- =============================================
ALTER PROCEDURE [dbo].[SP_DRV_CLIENTESTRANSACOES]

AS
BEGIN
-- =============================================
-- DROP TABLE
-- =============================================

IF OBJECT_ID('[dbo].[DRV_CLIENTESTRANSACOES]') IS NOT NULL
DROP TABLE [dbo].[DRV_CLIENTESTRANSACOES]

-- =============================================
-- CRIAÇÃO DA TABELA
-- =============================================

CREATE TABLE DRV_CLIENTESTRANSACOES(
		[ID_DRVCLIENTESTRANSACOES]		INT IDENTITY,
		[Customer ID]					CHAR(7), 
		[City]							VARCHAR(100), 
		[ZipCode]						VARCHAR(10), 
		[Gender]						CHAR(1), 
		[Age]							FLOAT, 
		[Order ID]						INT, 
        [Order Date]					DATE, 
		[Region]						CHAR(1), 
		[Rep]							VARCHAR(100), 
		[Item]							VARCHAR(100), 
		[Units]							NUMERIC, 		
		[Unit Price]					FLOAT
)

-- =============================================
-- TRUNCATE DA TABELA
-- =============================================

TRUNCATE TABLE [dbo].[DRV_CLIENTESTRANSACOES]

-- =============================================
-- INSERÇÃO DOS DADOS
-- =============================================
INSERT INTO [dbo].[DRV_CLIENTESTRANSACOES]
(			
[Customer ID],
[City],
[ZipCode],
[Gender],
[Age],
[Order ID],
[Order Date],
[Region],
[Rep],
[Item],
[Units],
[Unit Price]
)

SELECT        
		dbo.WRK_CLIENTES.[Customer ID], 
		dbo.WRK_CLIENTES.City, 
		dbo.WRK_CLIENTES.ZipCode, 
		dbo.WRK_CLIENTES.Gender, 
		dbo.WRK_CLIENTES.Age, 
		dbo.WRK_TRANSACOES.[Order ID], 
        dbo.WRK_TRANSACOES.[Order Date], 
		dbo.WRK_TRANSACOES.Region, 
		dbo.WRK_TRANSACOES.Rep, 
		dbo.WRK_TRANSACOES.Item, 
		dbo.WRK_TRANSACOES.Units, 		
		dbo.WRK_TRANSACOES.[Unit Price]

FROM    dbo.WRK_CLIENTES 
INNER JOIN dbo.WRK_TRANSACOES 
ON dbo.WRK_CLIENTES.[Customer ID] = dbo.WRK_TRANSACOES.[Customer ID]


END
