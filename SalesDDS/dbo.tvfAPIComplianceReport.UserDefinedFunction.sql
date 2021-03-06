USE [SalesDDS]
GO
/****** Object:  UserDefinedFunction [dbo].[tvfAPIComplianceReport]    Script Date: 12/22/2020 7:55:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE FUNCTION [dbo].[tvfAPIComplianceReport] (@StartDateKey INT, @EndDateKey INT)

RETURNS TABLE

AS

RETURN

WITH API AS
(SELECT dt.[FirstDayOfMonth]
, dt.PharmacyKey
, dt.GPIKey
, SUM(dt.APIurchaseQty) AS APIPurchaseQty
, SUM(dt.APIPurchasedAtIP) AS APIPurchasedAtIP
, AVG(dt.APIInvoicePerDose) AS APIInvoicePerDose
FROM(SELECT d.[FirstDayOfMonth]
		, pd.PharmacyKey
		, dd.GPIKey
		, SUM(f.Doses) AS APIurchaseQty
		, SUM(f.Doses) * AVG(InvoicePerDose) AS APIPurchasedAtIP		
		, AVG(f.InvoicePerDose) AS APIInvoicePerDose		
		FROM dbo.PharmacyDim AS pd
		INNER JOIN dbo.SalesFact_API AS f ON f.PharmacyKey = pd.PharmacyKey
		INNER JOIN dbo.DrugDim AS dd ON f.DrugKey = dd.DrugKey
		INNER JOIN dbo.DateDim AS d ON d.DateKey = f.DateKey
		WHERE f.DateKey BETWEEN @StartDateKey AND @EndDateKey
		AND f.PharmacyKey > 0
		AND f.DrugKey > 0
		AND [APIInvoiceQuantity] > 0
		AND f.[APIExtendedAmount]  > 0
		AND f.IsCredit = 0
		GROUP BY d.[FirstDayOfMonth]
			, pd.PharmacyKey
			, dd.GPIKey
		) AS dt
GROUP BY dt.[FirstDayOfMonth]
		,dt.PharmacyKey
		, dt.GPIKey
)
, APIGeneric AS
( SELECT dt.FirstDayOfMonth
	 ,dt.PharmacyKey
	, dt.GPIKey
	, SUM(dt.APIGenericPurchaseQty) AS APIGenericPurchaseQty
	, SUM(dt.APIGenericPurchasedAtIP) AS APIGenericPurchasedAtIP
	, AVG(dt.APIGenericInvoicePerDose) AS APIGenericInvoicePerDose
	FROM(SELECT d.[FirstDayOfMonth]
			, pd.PharmacyKey
			, dd.GPIKey
			, SUM(f.[GenericDoses]) AS APIGenericPurchaseQty
			, SUM(f.[GenericDoses]) * AVG([GenericInvoicePerDose]) AS APIGenericPurchasedAtIP
			, AVG(f.[GenericInvoicePerDose]) AS APIGenericInvoicePerDose	
			FROM dbo.PharmacyDim AS pd
			INNER JOIN dbo.SalesFact_API AS f ON f.PharmacyKey = pd.PharmacyKey
			INNER JOIN dbo.DrugDim AS dd ON f.DrugKey = dd.DrugKey
			INNER JOIN dbo.DateDim AS d ON d.DateKey = f.DateKey
			WHERE f.DateKey BETWEEN @StartDateKey AND @EndDateKey
			AND f.PharmacyKey > 0
			AND f.DrugKey > 0
			AND f.[APIInvoiceQuantity] > 0
			AND f.[APIExtendedAmount]  > 0
			AND f.IsCredit = 0
			AND dd.IsGeneric = 1
			GROUP BY d.[FirstDayOfMonth]
			, pd.PharmacyKey
			, dd.GPIKey
			) AS dt
	GROUP BY dt.FirstDayOfMonth
			, dt.PharmacyKey
		, dt.GPIKey
)
, APIBrand AS
( SELECT dt.[FirstDayOfMonth]
	, dt.PharmacyKey
	, dt.GPIKey
	, SUM(dt.APIBrandPurchaseQty) AS APIBrandPurchaseQty
	, SUM(dt.APIBrandPurchasedAtIP) AS APIBrandPurchasedAtIP
	, AVG(dt.APIBrandInvoicePerDose) AS APIBrandInvoicePerDose
	FROM(SELECT d.[FirstDayOfMonth]
			, pd.PharmacyKey
			, dd.GPIKey
			, SUM(f.[BrandDoses]) AS APIBrandPurchaseQty
			, SUM(f.[BrandDoses]) * AVG([BrandInvoicePerDose]) AS APIBrandPurchasedAtIP
			, AVG(f.[BrandInvoicePerDose]) AS APIBrandInvoicePerDose	
			FROM dbo.PharmacyDim AS pd
			INNER JOIN dbo.SalesFact_API AS f ON f.PharmacyKey = pd.PharmacyKey
			INNER JOIN dbo.DrugDim AS dd ON f.DrugKey = dd.DrugKey
			INNER JOIN dbo.DateDim AS d ON d.DateKey = f.DateKey
			WHERE f.DateKey BETWEEN @StartDateKey AND @EndDateKey
			AND f.PharmacyKey > 0
			AND f.DrugKey > 0
			AND f.[APIInvoiceQuantity] > 0
			AND f.[APIExtendedAmount]  > 0
			AND f.IsCredit = 0
			AND dd.IsGeneric = 0
			GROUP BY d.[FirstDayOfMonth]
			, pd.PharmacyKey
			, dd.GPIKey
			) AS dt
	GROUP BY dt.[FirstDayOfMonth]
			, dt.PharmacyKey
			, dt.GPIKey
)

SELECT c.[FirstDayOfMonth]
, c.PharmacyKey
, c.GPIKey
, c.APIPurchaseQty
, c.APIPurchasedAtIP
, c.APIInvoicePerDose
, ISNULL(g.APIGenericPurchaseQty,0.00) AS APIGenericPurchaseQty
, ISNULL(g.APIGenericPurchasedAtIP,0.00) AS APIGenericPurchasedAtIP
, ISNULL(g.APIGenericInvoicePerDose,0.00) AS APIGenericInvoicePerDose
, ISNULL(b.APIBrandPurchaseQty,0.00) AS APIBrandPurchaseQty
, ISNULL(b.APIBrandPurchasedAtIP,0.00) AS APIBrandPurchasedAtIP
, ISNULL(b.APIBrandInvoicePerDose,0.00) AS APIBrandInvoicePerDose
FROM API AS c
LEFT OUTER JOIN APIGeneric AS g ON c.PharmacyKey = g.PharmacyKey
									AND c.GPIKey = g.GPIKey
									AND c.[FirstDayOfMonth] = g.[FirstDayOfMonth]
LEFT OUTER JOIN APIBrand AS b ON c.PharmacyKey = b.PharmacyKey
									AND c.GPIKey = b.GPIKey
									AND c.[FirstDayOfMonth] = b.[FirstDayOfMonth]




GO
