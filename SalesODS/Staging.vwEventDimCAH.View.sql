USE [SalesODS]
GO
/****** Object:  View [Staging].[vwEventDimCAH]    Script Date: 12/22/2020 7:58:50 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [Staging].[vwEventDimCAH]

AS

SELECT ROW_NUMBER() OVER(ORDER BY (SELECT NULL)) AS EventKey
, a.DateKey 
, a.[INVOICE_NO] AS InvoiceNumber 
, a.[InvoiceLineNumber] AS[InvoiceLineNumber] 
, a.[INV_DATE] AS [InvoiceDate] 
, a.[PMID] 
, a.DC AS	[DistributionCenter] 
, a.[NDC] 
, CONVERT(VARCHAR(25), LEFT(a.ContractNo, 25)) AS [ContractNumber] 
, CONVERT(VARCHAR(250), CASE
	WHEN a.[ContractDesc] NOT LIKE '%[a-zA-Z0-9]%' THEN NULL
	ELSE LEFT(a.[ContractDesc], 250)
	END
	)	AS [ContractDescription] 
, CONVERT(VARCHAR(25), LEFT(a.[UPC], 25)) AS  [UPC]
, CONVERT(VARCHAR(25), LEFT(a.[ITEM_NO], 25)) AS [ItemNumber] 
, a.[ITEM_DESCR] AS ItemDescription 
, a.[ITEM_TYPE] AS [ItemType] 
, a.[OrderNo] AS [OrderNumber] 
, ISNULL(f1.[IsBackupSource], 0) AS IsBackupSource
, ISNULL(f1.[IsTenSource], 0) AS IsTenSource
, ISNULL(f1.[IsSourceWeekly], 0) AS [IsSourceWeekly]
, ISNULL(f1.[IsTopGenerics], 0) AS [IsTopGenerics]
, ID AS [CHPH_AAP_ID]
FROM SalesODS.Staging.CHPH_AAP AS a
LEFT OUTER JOIN (SELECT [CorrectedNDCUPC]
					, [IsBackupSource]
					, [IsTenSource]
					, [IsSourceWeekly]
					, [IsTopGenerics]
					FROM CAHODS.dbo.CAH_FormularyFile AS c
					CROSS APPLY(SELECT MAX(DateKey) AS MAXDate
								FROM CAHODS.dbo.CAH_FormularyFile		
								) AS ca
					WHERE ca.MAXDate = c.DateKey
					) AS f1 ON a.NDC = f1.CorrectedNDCUPC	
GO
