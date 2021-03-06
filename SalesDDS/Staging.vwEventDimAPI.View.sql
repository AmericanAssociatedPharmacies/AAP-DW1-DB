USE [SalesDDS]
GO
/****** Object:  View [Staging].[vwEventDimAPI]    Script Date: 12/22/2020 7:55:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






CREATE VIEW [Staging].[vwEventDimAPI]

AS


 SELECT RowID
 , APISalesDetailID
 , DateKey
, [InvNbr] AS [InvoiceNumber]
, CONVERT(INT, [InvLine]) AS [InvoiceLineNumber]
, [InvDate] AS [InvoiceDate]
, CASE WHEN [Territory] NOT LIKE '%[a-zA-Z0-9]%' THEN NULL 
		ELSE [Territory]
		END AS [TerritoryManagerNumber]
, CASE WHEN [WHAccountID] NOT LIKE '%[a-zA-Z0-9]%' THEN NULL 
		ELSE LEFT([WHAccountID], 8) 
		END AS [AccountNumber]
, CASE WHEN [CustomerRef] NOT LIKE '%[a-zA-Z0-9]%' THEN NULL 
		ELSE[CustomerRef] 
		END AS [CustomerReference]
, CASE WHEN PMID NOT LIKE '%[a-zA-Z0-9]%' THEN NULL 
		ELSE PMID
		END AS PMID
, CASE WHEN [WHNbr] NOT LIKE '%[a-zA-Z0-9]%' THEN NULL 
		ELSE [WHNbr] 
		END AS [WarehouseNumber]
, CASE WHEN [ItemGrp] NOT LIKE '%[a-zA-Z0-9]%' THEN NULL 
		ELSE [ItemGrp] 
		END AS [ItemGroupNumber]
, CASE WHEN [AcctGrp] NOT LIKE '%[a-zA-Z0-9]%' THEN NULL 
		ELSE [AcctGrp] 
		END AS [AccountGroupNumber]
, CASE WHEN [NDC_orig] NOT LIKE '%[a-zA-Z0-9]%' THEN NULL 
		ELSE [NDC_orig] 
		END AS [NDCOriginal]
, CASE WHEN NDC NOT LIKE '%[a-zA-Z0-9]%' THEN NULL 
		ELSE NDC
		END AS NDC
, CASE WHEN [APIItemNbr] NOT LIKE '%[a-zA-Z0-9]%' THEN NULL 
		ELSE [APIItemNbr] 
		END AS [ItemNumber]
, CASE WHEN ItemDescription NOT LIKE '%[a-zA-Z0-9]%' THEN NULL 
		ELSE ItemDescription 
		END AS ItemDescription
, CONVERT(BIT, CASE WHEN ItemDescription LIKE '%credit%' THEN 1 
		ELSE 0
		END) AS IsCredit
, CASE WHEN [Type] NOT LIKE '%[a-zA-Z0-9]%' THEN NULL 
		ELSE [Type] 
		END AS [Type]
, CONVERT(BIT, CASE WHEN ItemDescription LIKE '%order%' THEN 1 
		ELSE 0
		END
		) AS IsOrderFee
, s.TransTypeCode
, s.TransTypeCodeDesc
, CONVERT(VARBINARY(8), [RowversionID]) AS [RowversionID]
FROM Staging.API AS s






GO
