USE [ODSIntake]
GO
/****** Object:  View [Staging].[vwCHPH_AAP]    Script Date: 12/22/2020 7:30:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [Staging].[vwCHPH_AAP]

AS

SELECT TRY_CONVERT(INT, TRY_CONVERT(VARCHAR(20), InvDate, 112)) AS DateKey
, TRY_CONVERT(INT,  DC) AS DC -- This is a 3 character value in the flat file. Data type is an INT on DB1
, TRY_CONVERT(VARCHAR(63), CustomerName) AS [CUSTOMER_NAME]
, TRY_CONVERT(VARCHAR(31), CustomerNumber) AS [CUSTOMER_NO]
, TRY_CONVERT(VARCHAR(31), CASE 
					   WHEN ItemNumber NOT LIKE '%[0-9]%' THEN NULL
					   ELSE ItemNumber
					   END
					   ) AS ITEM_NO
, TRY_CONVERT(VARCHAR(31), CASE 
					   WHEN Store NOT LIKE '%[0-9]%' THEN NULL
					   ELSE Store
					   END
					   ) AS STORE
, TRY_CONVERT(VARCHAR(15), CASE 
					   WHEN NDC NOT LIKE '%[0-9]%' THEN NULL
					   ELSE NDC
					   END
					   ) AS NDC
, TRY_CONVERT(VARCHAR(15), CASE 
					   WHEN ItemType NOT LIKE '%[a-zA-Z0-9]%' THEN NULL
					   ELSE ItemType
					   END
					   ) AS ITEM_TYPE
, TRY_CONVERT(VARCHAR(127), CASE 
					   WHEN ItemDescr NOT LIKE '%[a-zA-Z0-9]%' THEN NULL
					   ELSE ItemDescr
					   END
					   ) AS ITEM_DESCR
, TRY_CONVERT(VARCHAR(127), CASE 
					   WHEN GenericName NOT LIKE '%[a-zA-Z0-9]%' THEN NULL
					   ELSE GenericName
					   END
					   ) AS GENERIC_NAME
, TRY_CONVERT(VARCHAR(127), CASE 
					   WHEN TradeName NOT LIKE '%[a-zA-Z0-9]%' THEN NULL
					   ELSE TradeName
					   END
					   ) AS TRADE_NAME
, TRY_CONVERT(datetime, InvDate) AS INV_DATE
, TRY_CONVERT(VARCHAR(15), CASE 
					   WHEN InvoiceNumber NOT LIKE '%[a-zA-Z0-9]%' THEN NULL
					   ELSE InvoiceNumber
					   END 
					   ) AS [INVOICE_NO]
, TRY_CONVERT(VARCHAR(15), CASE 
					   WHEN Type NOT LIKE '%[a-zA-Z0-9]%' THEN NULL
					   ELSE Type
					   END 
					   ) AS Type
, TRY_CONVERT(NUMERIC(18,0), OrderQty) AS [ORDER_QTY]
, TRY_CONVERT(NUMERIC(18,0), ShipQty) AS [SHIP_QTY]
, TRY_CONVERT(FLOAT, UnitCost) AS [UNIT_COST]
, TRY_CONVERT(FLOAT, ExtCost) AS [EXT_COST]
, TRY_CONVERT(FLOAT, CorpAWP) AS [CORP_AWP]
, TRY_CONVERT(FLOAT, WAC) AS WAC
, TRY_CONVERT(VARCHAR(127), CASE 
					   WHEN VendorName NOT LIKE '%[a-zA-Z0-9]%' THEN NULL
					   ELSE VendorName
					   END
					   ) AS VENDOR_NAME
, TRY_CONVERT(VARCHAR(127), CASE 
					   WHEN UPC NOT LIKE '%[a-zA-Z0-9]%' THEN NULL
					   ELSE UPC
					   END
					   ) AS UPC
, TRY_CONVERT(VARCHAR(31), CASE 
					   WHEN ContractFlag NOT LIKE '%[a-zA-Z0-9]%' THEN NULL
					   ELSE ContractFlag
					   END
					   ) AS [CONTRACT_FLAG]
, TRY_CONVERT(VARCHAR(31), CASE 
					   WHEN Brand NOT LIKE '%[a-zA-Z0-9]%' THEN NULL
					   ELSE Brand
					   END
					   ) AS BRAND
, TRY_CONVERT(VARCHAR(31), CASE 
					   WHEN GenericCode NOT LIKE '%[a-zA-Z0-9]%' THEN NULL
					   ELSE GenericCode
					   END
					   ) AS [GENERIC_CODE]
, TRY_CONVERT(VARCHAR(127), CASE 
					   WHEN Strength NOT LIKE '%[a-zA-Z0-9]%' THEN NULL
					   ELSE Strength
					   END
					   ) AS STRENGTH
, TRY_CONVERT(VARCHAR(31), CASE 
					   WHEN ShortCode NOT LIKE '%[a-zA-Z0-9]%' THEN NULL
					   ELSE ShortCode
					   END
					   ) AS [SHORT_CODE]
, TRY_CONVERT(VARCHAR(31), CASE 
					   WHEN Encoding NOT LIKE '%[a-zA-Z0-9]%' THEN NULL
					   ELSE Encoding
					   END
					   ) AS ENCODING
, TRY_CONVERT(VARCHAR(31), CASE 
					   WHEN ContractNumber NOT LIKE '%[a-zA-Z0-9]%' THEN NULL
					   ELSE ContractNumber
					   END
					   ) AS [ContractNo]
, TRY_CONVERT(VARCHAR(255), CASE 
					   WHEN ContrDescr NOT LIKE '%[a-zA-Z0-9]%' THEN NULL
					   ELSE ContrDescr
					   END 
					   ) AS [ContractDesc]
, GETDATE() AS MM_DD_YY_LOAD
, TRY_CONVERT(VARCHAR(20), CASE 
					   WHEN OrderNumber NOT LIKE '%[a-zA-Z0-9]%' THEN NULL
					   ELSE OrderNumber
					   END 
					   ) AS [OrderNo]
, TRY_CONVERT(VARCHAR(25), CASE 
					   WHEN [DEA] NOT LIKE '%[a-zA-Z0-9]%' THEN NULL
					   ELSE [DEA]
					   END 
					   ) AS [DEA]
, TRY_CONVERT(INT, CASE 
					WHEN [InvoiceLineNumber] NOT LIKE '%[a-zA-Z0-9]%' THEN NULL
					ELSE [InvoiceLineNumber]
					END 
					) AS [InvoiceLineNmbr]
FROM [Staging].[CHAAPImport]




GO
