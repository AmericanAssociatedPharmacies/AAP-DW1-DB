USE [CAHODS]
GO
/****** Object:  View [dbo].[vwCurrentFormulary]    Script Date: 12/22/2020 6:50:01 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vwCurrentFormulary]

AS

SELECT [CorrectedNDCUPC] AS NDC
, AAPSell AS CustomerInvoicePrice
, PricePerUnit
FROM CAHODS.[dbo].[CAH_FormularyFile] AS c
CROSS APPLY(SELECT MAX(DateKey) AS MaxDateKey
			FROM CAHODS.[dbo].[CAH_FormularyFile] AS d
			) AS ca
WHERE c.DateKey = ca.MaxDateKey
GO
