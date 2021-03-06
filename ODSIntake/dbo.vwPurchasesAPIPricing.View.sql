USE [ODSIntake]
GO
/****** Object:  View [dbo].[vwPurchasesAPIPricing]    Script Date: 12/22/2020 7:30:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vwPurchasesAPIPricing]

AS

SELECT CONVERT(NVARCHAR(50), ac.[API ITEM #]) AS APIItemNbr
, CONVERT(NVARCHAR(20), [NDC #]) AS NDC
, CONVERT(NVARCHAR(200), [ITEM DESCRIPTION]) AS [DESCRIPTION]
, CONVERT(NVARCHAR(50), [UNIT]) AS Unit
, CONVERT(NVARCHAR(50), [SIZE]) AS Size
, CONVERT(NVARCHAR(50), [CONTRACT]) AS [Contract]
, CONVERT(NVARCHAR(50), ap.APICustomerInvoicePrice) AS APIPrice
, CONVERT(NVARCHAR(50), [GPI]) AS GPI
, CONVERT(NUMERIC(18,4), ap.APIRebate) AS AdjRebate
, GETDATE() AS DateLoaded
FROM(SELECT MAX(DateKey) AS MaxDateKey
		FROM [Archive].[ContractUp]
	 ) AS dt
INNER JOIN [Archive].[ContractUp] AS ac ON dt.MaxDateKey = ac.DateKey
INNER JOIN [dbo].[vwAPIPricing] as ap ON ac.[API ITEM #] = ap.API_ItemNumber
GO
