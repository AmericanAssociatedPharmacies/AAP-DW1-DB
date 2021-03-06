USE [SalesDDS]
GO
/****** Object:  View [Staging].[vwSalesFact_CAH_old]    Script Date: 12/22/2020 7:55:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [Staging].[vwSalesFact_CAH_old]

AS


SELECT dt.PharmacyKey
, dt.DateKey
, dt.[CAHDrugKey]
, dt.SalesInfoKey
, dt.[CAHInvoiceNumber]
, ROW_NUMBER() OVER(PARTITION BY dt.PharmacyKey, dt.DateKey, dt.[CAHInvoiceNumber], dt.[CAHDrugKey] ORDER BY(SELECT NULL)) AS  CAHInvoiceLineItemNumber
, dt.CAHOrderQuantity
, dt.CAHShipQuantity
, dt.CAHUnitAmount
, dt.CAHExtendedSales
, dt.CAH_AWP
, dt.CAH_WAC
FROM(SELECT DISTINCT ISNULL(pd.PharmacyKey, 0) AS PharmacyKey
	, a.DateKey
	, d1.DrugKey AS [CAHDrugKey]
	, ISNULL(ISNULL(ISNULL(ISNULL(sd1.SalesInfoKey, sd2.SalesInfoKey), sd3.SalesInfoKey), sd4.SalesInfoKey), 0) AS SalesInfoKey
	--, ISNULL(ISNULL(ISNULL(ISNULL(NULLIF(sd1.SalesInfoKey, 0), NULLIF(sd2.SalesInfoKey, 0)), NULLIF(sd3.SalesInfoKey, 0)), NULLIF(sd4.SalesInfoKey, 0)), 0) AS SalesInfoKey
	, a.[INVOICE_NO] AS [CAHInvoiceNumber]
	, a.SHIP_QTY AS CAHOrderQuantity
	, a.[SHIP_QTY] AS CAHShipQuantity
	, CONVERT(MONEY, a.UNIT_COST) AS CAHUnitAmount
	, CONVERT(MONEY, a.[EXT_COST]) AS CAHExtendedSales
	, CONVERT(MONEY, a.[CORP_AWP]) AS CAH_AWP
	, CONVERT(MONEY, a.[WAC]) AS CAH_WAC
	FROM [Staging].[CAH] AS a
	INNER JOIN dbo.PharmacyDim AS pd ON a.PMID = pd.PMID
	INNER JOIN dbo.DrugDim AS d1 ON a.NDC = d1.NDC
	LEFT OUTER JOIN dbo.SalesInfoDim AS sd1 ON a.IsBackupSource = NULLIF(sd1.IsBackupSource, 0)
	LEFT OUTER JOIN dbo.SalesInfoDim AS sd2 ON a.IsTenSource = NULLIF(sd2.[IsTenSourceGeneric], 0)
	LEFT OUTER JOIN dbo.SalesInfoDim AS sd3 ON a.[IsSourceWeekly] = NULLIF(sd3.[IsSourceWeekly], 0)
	LEFT OUTER JOIN dbo.SalesInfoDim AS sd4 ON a.[IsTopGenerics] = NULLIF(sd4.[IsTopGenerics], 0)	
	) AS dt





GO
