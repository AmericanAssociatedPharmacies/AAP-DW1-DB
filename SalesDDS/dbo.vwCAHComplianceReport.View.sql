USE [SalesDDS]
GO
/****** Object:  View [dbo].[vwCAHComplianceReport]    Script Date: 12/22/2020 7:55:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO









CREATE VIEW [dbo].[vwCAHComplianceReport]

AS


SELECT dt.PMID
		, dt.DateKey
		, dt.GPI
		, dt.Description	
		, dt.Doses
		, dt.NDC
		, dt.InvoiceDate
		, dt.CAHUnitAmount
		--, CONVERT(MONEY,(dt.[CAHExtendedSales]/dt.Doses)) AS InvoicePerDose
		, dt.InvoicePerDose
		, dt.PerUnitPrice
		, dt.IsGeneric
		, dt.IsBrand		
		FROM(SELECT DISTINCT pd.PMID
			, c.DateKey
			, d.GPI
			, d.Description
			--, c.[CAHInvoiceQuantity] * d.PackageSize * d.PackageQuantity AS Doses
			, c.Doses
			, d.NDC
			--, CONVERT(DATE, e.InvoiceDate) AS InvoiceDate
			, CONVERT(DATETIME, CONVERT(VARCHAR(10), c.DateKey)) AS InvoiceDate
			, c.[CAHUnitAmount]
			--, c.[CAHExtendedSales]
			--, CONVERT(DECIMAL(18,2),(c.[CAHExtendedSales]/c.[CAHInvoiceQuantity])/(d.PackageSize * d.PackageQuantity)) AS PerUnitPrice
			, c.[PricePerUnit] AS PerUnitPrice
			, ISNULL(g.IsGeneric,0) AS IsGeneric
			, ISNULL(b.IsBrand,0) AS IsBrand
			, c.InvoicePerDose
			FROM SalesDDS.dbo.SalesFact_CAH AS c
			INNER JOIN SalesDDS.dbo.DrugDim AS d ON c.DrugKey = d.DrugKey
			--INNER JOIN SalesDDS.dbo.EventDimCAH AS e ON c.[CAHEventKey] = e.EventKey
			--										AND c.CAHEventDateKey = e.DateKey
			INNER JOIN SalesDDS.dbo.PharmacyDim AS pd ON c.PharmacyKey = pd.PharmacyKey
			LEFT OUTER JOIN(SELECT DrugKey, CONVERT(BIT,1) AS IsGeneric
								FROM SalesDDS.dbo.DrugDim
								WHERE MultiSourceCode IN('Y') 
								) AS g ON d.DrugKey = g.DrugKey
			LEFT OUTER JOIN(SELECT DrugKey, CONVERT(BIT,1) AS IsBrand
								FROM SalesDDS.dbo.DrugDim
								WHERE MultiSourceCode IN('N','O', 'M')
								) AS b ON d.DrugKey = b.DrugKey	
			WHERE c.[CAHInvoiceQuantity] > 0
			AND pd.PMID > 0
			AND c.PharmacyKey > 0
			--AND e.ItemType = 'RX'
			--AND e.DateKey = (e.DateKey + 0) --Added for performance. Do not remove!
			AND c.DateKey = (c.DateKey + 0)	--Added for performance. Do not remove!	
			AND EXISTS(SELECT 1
						FROM SalesDDS.dbo.EventDimCAH AS e 
						WHERE  c.[CAHEventKey] = e.EventKey
						AND c.CAHEventDateKey = e.DateKey
						AND e.ItemType = 'RX'
						AND e.DateKey = (e.DateKey + 0) --Added for performance. Do not remove!
					)
			) AS dt
WHERE dt.Doses IS NOT NULL







GO
