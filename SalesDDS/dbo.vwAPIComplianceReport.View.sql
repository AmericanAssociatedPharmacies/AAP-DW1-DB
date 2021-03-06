USE [SalesDDS]
GO
/****** Object:  View [dbo].[vwAPIComplianceReport]    Script Date: 12/22/2020 7:55:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO









CREATE VIEW [dbo].[vwAPIComplianceReport]


AS




	SELECT dt.PMID
	,dt.DateKey
	, dt.GPI
	, dt.Description
	, dt.Doses
	, dt.NDC
	, dt.InvoiceDate
	--, (dt.APIExtendedAmount/dt.Doses) AS [InvoicePerDose]
	, dt.InvoicePerDose
	, dt.PerUnitPrice
	, dt.IsGeneric
	, dt.IsBrand
	FROM(SELECT DISTINCT pd.PMID
		, a.DateKey
		, dd.GPI
		, dd.Description
		--, a.[APIInvoiceQuantity] * dd.PackageSize * dd.PackageQuantity AS Doses
		, a.Doses
		, dd.NDC
		--, CONVERT(DATE,dd.TheDate) AS InvoiceDate
		, CONVERT(DATE, CONVERT(VARCHAR(10), a.DateKey)) AS InvoiceDate
		--, (a.[APIExtendedAmount]/a.APIInvoiceQuantity) AS APICustomerInvoicePrice
		--, a.[APIUnitAmount]
		--, a.APIExtendedAmount
		--, CONVERT(DECIMAL(18,2),(a.[APIExtendedAmount]/a.APIInvoiceQuantity)/(dd.PackageSize * dd.PackageQuantity)) AS PerUnitPrice
		, a.PricePerUnit AS PerUnitPrice
		, ISNULL(g.IsGeneric,0) AS IsGeneric
		, ISNULL(b.IsBrand,0) AS IsBrand
		, a.InvoicePerDose
		FROM SalesDDS.dbo.SalesFact_API AS a
		--INNER JOIN SalesDDS.dbo.EventDimAPI AS e ON a.[APIEventKey] = e.EventKey
		--										AND a.[APIEventDateKey] = e.DateKey
		INNER JOIN SalesDDS.dbo.PharmacyDim AS pd ON a.PharmacyKey = pd.PharmacyKey
		INNER JOIN SalesDDS.dbo.DrugDim AS dd ON a.DrugKey = dd.DrugKey	
		LEFT OUTER JOIN(SELECT DrugKey, CONVERT(BIT,1) AS IsGeneric
								FROM SalesDDS.dbo.DrugDim
								WHERE MultiSourceCode IN('Y') 
								) AS g ON dd.DrugKey = g.DrugKey
		LEFT OUTER JOIN(SELECT DrugKey, CONVERT(BIT,1) AS IsBrand
							FROM SalesDDS.dbo.DrugDim
							WHERE MultiSourceCode IN('N','O', 'M')
							) AS b ON dd.DrugKey = b.DrugKey			
		WHERE a.IsCredit = 0
		AND a.[APIInvoiceQuantity] > 0
		AND pd.PMID > 0
		AND dd.DrugKey = (dd.DrugKey + 0) --Added for performance. Do not remove!
		--AND e.DateKey = (e.DateKey + 0) --Added for performance. Do not remove!
		AND a.DateKey = (a.DateKey + 0)	--Added for performance. Do not remove!			
		) AS dt
	WHERE dt.Doses IS NOT NULL
	









GO
