USE [SalesDDS]
GO
/****** Object:  View [dbo].[vwCR20200803]    Script Date: 12/22/2020 7:55:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vwCR20200803]

AS

SELECT f.PharmacyKey
	--, f.Drugkey
	--pd.PMID
	--, dd.GPI
	, f.[MonthYearKey]
	, SUM(Doses) * MIN(InvoicePerDose) AS CAHInvoicePerDose
	, SUM(GenericDoses) * MIN([GenericInvoicePerDose]) AS CAHGenericInvoicePerDose
	, SUM(BrandDoses) * MIN([BrandInvoicePerDose]) AS CAHBrandInvoicePerDose
	, SUM([GenericPurchaseAtIP]) AS CAHGenericPurchaseAtIP
	, SUM([BrandPurchaseAtIP]) AS CAHBrandPurchaseAtIP
	, SUM([PurchaseAtIP]) AS CAHPurchaseAtIP
	FROM SalesDDS.dbo.SalesFact_CAH AS f
	--SalesDDS.dbo.PharmacyDim AS pd
	--INNER JOIN SalesDDS.dbo.SalesFact_CAH AS f ON pd.PharmacyKey = f.PharmacyKey
	--INNER JOIN SalesDDS.dbo.DrugDim AS dd ON dd.DrugKey = f.DrugKey
	WHERE  f.[CAHInvoiceQuantity] > 0
	AND f.[CAHExtendedSales] > 0
	AND f.PharmacyKey > 0
	AND f.DrugKey > 0
	AND [MonthYearKey] = ([MonthYearKey] + 0)
	AND PharmacyKey = (PharmacyKey + 0)
	AND DrugKey =  (DrugKey + 0)
	--AND f.[MonthYearKey] = (f.[MonthYearKey] + 0)
	GROUP BY f.PharmacyKey
	--, f.Drugkey
	, f.[MonthYearKey]
GO
