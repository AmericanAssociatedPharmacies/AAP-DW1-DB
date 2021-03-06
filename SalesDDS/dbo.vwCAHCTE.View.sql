USE [SalesDDS]
GO
/****** Object:  View [dbo].[vwCAHCTE]    Script Date: 12/22/2020 7:55:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vwCAHCTE]

AS

WITH ClaimFact AS
(SELECT ROW_NUMBER() OVER(ORDER BY f.PharmacyKey ASC, f.DrugKey ASC ) AS RN
	, f.PharmacyKey
	, f.DrugKey
	, MonthYearKey
	, SUM(Doses) * AVG(InvoicePerDose) AS CAHInvoicePerDose
	, SUM(GenericDoses) * AVG([GenericInvoicePerDose]) AS CAHGenericInvoicePerDose
	, SUM(BrandDoses) * AVG([BrandInvoicePerDose]) AS CAHBrandInvoicePerDose
	, SUM([GenericPurchaseAtIP]) AS CAHGenericPurchaseAtIP
	, SUM([BrandPurchaseAtIP]) AS CAHBrandPurchaseAtIP
	, SUM([PurchaseAtIP]) AS CAHPurchaseAtIP
	FROM SalesDDS.dbo.SalesFact_CAH AS f
	WHERE  f.[CAHInvoiceQuantity] > 0
	AND f.[CAHExtendedSales] > 0
	--AND dd.DrugKey > 0
	AND f.PharmacyKey > 0
	AND f.DrugKey > 0
	--AND pd.PharmacyKey > 0
	AND f.DrugKey = (f.DrugKey + 0)
	AND f.PharmacyKey = (f.PharmacyKey + 0)
	AND f.DateKey = (f.DateKey + 0)
	GROUP BY f.PharmacyKey
	, f.DrugKey
	, MonthYearKey
	
	
	
)
, DrugDim AS
(SELECT DrugKey, GPI
	FROM dbo.DrugDim
	WHERE DrugKey > 0
)
, PharmacyDim AS
(SELECT PharmacyKey, PMID
	FROM dbo.PharmacyDim
	WHERE PharmacyKey > 0
	)

SELECT pd.PMID
, dd.GPI
, cf.MonthYearKey
, SUM(CAHInvoicePerDose) AS CAHInvoicePerDose
, SUM(CAHGenericInvoicePerDose) AS CAHGenericInvoicePerDose
, SUM(CAHBrandInvoicePerDose) AS CAHBrandInvoicePerDose
, SUM(CAHGenericPurchaseAtIP) AS CAHGenericPurchaseAtIP
, SUM(CAHBrandPurchaseAtIP) AS CAHBrandPurchaseAtIP
, SUM(CAHPurchaseAtIP) AS CAHPurchaseAtIP
FROM PharmacyDim AS pd
INNER JOIN ClaimFact AS cf ON pd.PharmacyKey = cf.PharmacyKey
INNER JOIN DrugDim AS dd ON cf.DrugKey = dd.DrugKey
GROUP BY pd.PMID, dd.GPI, cf.MonthYearKey
GO
