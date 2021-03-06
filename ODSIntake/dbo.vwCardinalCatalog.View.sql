USE [ODSIntake]
GO
/****** Object:  View [dbo].[vwCardinalCatalog]    Script Date: 12/22/2020 7:30:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [dbo].[vwCardinalCatalog]


AS


SELECT dt.NDC
, dt.CardinalInvoicePrice
, CASE 
	WHEN dt.Size = 0.00 THEN NULL
	ELSE dt.Size
	END AS Size
, dt.DateKey
, dt.ContractType
FROM(SELECT CONVERT(VARCHAR(11), NDC) AS NDC
	, CONVERT(MONEY, Cost) AS CardinalInvoicePrice
	, CONVERT(DECIMAL(8,2), Size) AS Size
	, DateKey
	, Col9 AS ContractType
	FROM [Staging].[CardinalCatalog]
	) AS dt


GO
