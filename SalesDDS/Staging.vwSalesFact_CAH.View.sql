USE [SalesDDS]
GO
/****** Object:  View [Staging].[vwSalesFact_CAH]    Script Date: 12/22/2020 7:55:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






CREATE VIEW [Staging].[vwSalesFact_CAH]

AS


SELECT dt.PharmacyKey
, dt.DateKey
, dt.DrugKey
, dt.CAHEventKey
, dt.CAHEventDateKey
, dt.CAHInvoiceQuantity
, dt.[CAHUnitAmount]
, dt.[CAHExtendedSales]
, dt.[CAH_AWP]
, dt.[CAH_WAC]	
, dt.TransactionCount
, dt.GPIKey
FROM(SELECT s.DateKey
		, ISNULL(dd.DrugKey,0) AS DrugKey		
		, ISNULL(p.PharmacyKey,0) AS PharmacyKey
		, ed.EventKey AS CAHEventKey	
		, ed.DateKey AS CAHEventDateKey
		, CONVERT(INT, s.[SHIP_QTY])  AS CAHInvoiceQuantity
		, CONVERT(MONEY, s.[UNIT_COST]) AS [CAHUnitAmount]
		, CONVERT(MONEY, s.[EXT_COST]) AS [CAHExtendedSales]
		, CONVERT(MONEY, s.[CORP_AWP]) AS [CAH_AWP]
		, CONVERT(MONEY, s.[WAC]) AS [CAH_WAC]	
		, CONVERT(INT, CONVERT(VARCHAR(20), DATEADD(DAY, 1, CONVERT(datetime, convert(varchar(10), s.DateKey))),112)) AS EndDatekey
		, s.PMID
		, s.NDC
		, CONVERT(TINYINT, 1) AS TransactionCount
		, dd.GPIKey
		FROM [Staging].[CAH] AS s
		INNER JOIN dbo.EventDimCAH as ed ON s.RowversionID_DB1 = ed.RowversionID_DB1
											AND ed.DateKey = s.DateKey
		LEFT OUTER JOIN dbo.DrugDim AS dd ON s.NDC = dd.NDC
												AND s.DateKey BETWEEN dd.StartDateKey AND dd.EndDateKey				
		LEFT OUTER JOIN dbo.PharmacyDim AS p ON s.PMID = p.PMID
		) AS dt







GO
