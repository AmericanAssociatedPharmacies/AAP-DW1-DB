USE [SalesDDS]
GO
/****** Object:  UserDefinedFunction [dbo].[tvfCAHComplianceReport]    Script Date: 12/22/2020 7:55:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE FUNCTION [dbo].[tvfCAHComplianceReport] (@StartMonthYearKey INT, @EndMonthYearKey INT)

RETURNS TABLE

AS

RETURN

WITH CAH AS
(SELECT dt.MonthYearKey 
, dt.PharmacyKey
, dt.GPIKey
, SUM(dt.CAHPurchaseQty) AS CAHPurchaseQty
, SUM(dt.CAHPurchasedAtIP) AS CAHPurchasedAtIP
, AVG(dt.CAHInvoicePerDose) AS CAHInvoicePerDose
FROM(SELECT f.MonthYearKey
		, pd.PharmacyKey
		, dd.GPIKey
		, SUM(f.Doses) AS CAHPurchaseQty
		, SUM(f.Doses) * AVG(InvoicePerDose) AS CAHPurchasedAtIP		
		, AVG(f.InvoicePerDose) AS CAHInvoicePerDose		
		FROM dbo.PharmacyDim AS pd
		INNER JOIN dbo.SalesFact_CAH AS f ON f.PharmacyKey = pd.PharmacyKey
		INNER JOIN dbo.DrugDim AS dd ON f.DrugKey = dd.DrugKey
		WHERE MonthYearKey BETWEEN @StartMonthYearKey AND @EndMonthYearKey
		AND f.PharmacyKey > 0
		AND f.DrugKey > 0
		AND f.PurchaseQty > 0
		AND f.CAHExtendedSales  > 0
		GROUP BY f.MonthYearKey
		, pd.PharmacyKey
		, dd.GPIKey
		) AS dt
GROUP BY dt.MonthYearKey
		, dt.PharmacyKey
		, dt.GPIKey
)
, CAHGeneric AS
( SELECT dt.MonthYearKey
, dt.PharmacyKey
, dt.GPIKey
, SUM(dt.CAHGenericPurchaseQty) AS CAHGenericPurchaseQty
, SUM(dt.CAHGenericPurchasedAtIP) AS CAHGenericPurchasedAtIP
, AVG(dt.CAHGenericInvoicePerDose) AS CAHGenericInvoicePerDose
FROM(SELECT f.MonthYearKey
		, pd.PharmacyKey
		, dd.GPIKey
		, SUM(f.[GenericDoses]) AS CAHGenericPurchaseQty
		, SUM(f.[GenericDoses]) * AVG([GenericInvoicePerDose]) AS CAHGenericPurchasedAtIP
		, AVG(f.[GenericInvoicePerDose]) AS CAHGenericInvoicePerDose	
		FROM dbo.PharmacyDim AS pd
		INNER JOIN dbo.SalesFact_CAH AS f ON f.PharmacyKey = pd.PharmacyKey
		INNER JOIN dbo.DrugDim AS dd ON f.DrugKey = dd.DrugKey
		WHERE MonthYearKey BETWEEN @StartMonthYearKey AND @EndMonthYearKey
		AND f.PharmacyKey > 0
		AND f.DrugKey > 0
		AND f.PurchaseQty > 0
		AND f.CAHExtendedSales  > 0
		AND dd.IsGeneric = 1
		GROUP BY f.MonthYearKey
		, pd.PharmacyKey
		, dd.GPIKey
		) AS dt
GROUP BY dt.MonthYearKey
		, dt.PharmacyKey
		, dt.GPIKey
)
, CAHBrand AS
( SELECT dt.MonthYearKey 
, dt.PharmacyKey
, dt.GPIKey
, SUM(dt.CAHBrandPurchaseQty) AS CAHBrandPurchaseQty
, SUM(dt.CAHBrandPurchasedAtIP) AS CAHBrandPurchasedAtIP
, AVG(dt.CAHBrandInvoicePerDose) AS CAHBrandInvoicePerDose
FROM(SELECT f.MonthYearKey 
		, pd.PharmacyKey
		, dd.GPIKey
		, SUM(f.[BrandDoses]) AS CAHBrandPurchaseQty
		, SUM(f.[BrandDoses]) * AVG([BrandInvoicePerDose]) AS CAHBrandPurchasedAtIP
		, AVG(f.[BrandInvoicePerDose]) AS CAHBrandInvoicePerDose	
		FROM dbo.PharmacyDim AS pd
		INNER JOIN dbo.SalesFact_CAH AS f ON f.PharmacyKey = pd.PharmacyKey
		INNER JOIN dbo.DrugDim AS dd ON f.DrugKey = dd.DrugKey
		WHERE MonthYearKey BETWEEN @StartMonthYearKey AND @EndMonthYearKey
		AND f.PharmacyKey > 0
		AND f.DrugKey > 0
		AND f.PurchaseQty > 0
		AND f.CAHExtendedSales  > 0
		AND dd.IsGeneric = 0
		GROUP BY f.MonthYearKey 
		, pd.PharmacyKey
		, dd.GPIKey
		) AS dt
GROUP BY dt.MonthYearKey
		, dt.PharmacyKey
		, dt.GPIKey
)

SELECT c.MonthYearKey, c.PharmacyKey, c.GPIKey, c.CAHPurchaseQty, c.CAHPurchasedAtIP, c.CAHInvoicePerDose
, ISNULL(g.CAHGenericPurchaseQty,0.00) AS CAHGenericPurchaseQty, ISNULL(g.CAHGenericPurchasedAtIP,0.00) AS CAHGenericPurchasedAtIP, ISNULL(g.CAHGenericInvoicePerDose,0.00) AS CAHGenericInvoicePerDose
, ISNULL(b.CAHBrandPurchaseQty,0.00) AS CAHBrandPurchaseQty, ISNULL(b.CAHBrandPurchasedAtIP,0.00) AS CAHBrandPurchasedAtIP, ISNULL(b.CAHBrandInvoicePerDose,0.00) AS CAHBrandInvoicePerDose
FROM CAH AS c
LEFT OUTER JOIN CAHGeneric AS g ON c.PharmacyKey = g.PharmacyKey
									AND c.GPIKey = g.GPIKey
									AND c.MonthYearKey = g.MonthYearKey
LEFT OUTER JOIN CAHBrand AS b ON c.PharmacyKey = b.PharmacyKey
									AND c.GPIKey = b.GPIKey
									AND c.MonthYearKey = b.MonthYearKey

GO
