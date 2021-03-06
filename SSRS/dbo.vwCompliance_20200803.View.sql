USE [SSRS]
GO
/****** Object:  View [dbo].[vwCompliance_20200803]    Script Date: 12/22/2020 8:05:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vwCompliance_20200803]

AS


SELECT dt.[MonthYearKey]
, dt.PMID
, dt.GPI
, dt.[QuantityDispensed]
, ISNULL(g.GenericQuantityDispensed,0.00) AS GenericQuantityDispensed
, ISNULL(b.[BrandQuantityDispensed],0.00) AS BrandQuantityDispensed
FROM(SELECT f.[MonthYearKey]
	, pd.PMID
	, dd.GPI
	, SUM(f.[QuantityDispensed]) AS [QuantityDispensed]	
	FROM ClaimsDDS.dbo.ClaimFactFDS AS f
	INNER JOIN ClaimsDDS.dbo.PharmacyDim AS pd ON f.PharmacyKey = pd.PharmacyKey
	INNER JOIN ClaimsDDS.dbo.DrugDim AS dd ON f.DrugKey = dd.DrugKey
	WHERE pd.PharmacyKey > 0
	--AND f.[MonthYearKey] BETWEEN 202001 AND 202008
	AND dd.DrugKey > 0
	GROUP BY f.[MonthYearKey]
	, pd.PMID
	, dd.GPI
	) AS dt
LEFT OUTER JOIN(SELECT f.[MonthYearKey]
				, pd.PMID
				, dd.GPI
				, SUM([QuantityDispensed]) AS [GenericQuantityDispensed]
				FROM ClaimsDDS.dbo.ClaimFactFDS AS f
				INNER JOIN ClaimsDDS.dbo.PharmacyDim AS pd ON f.PharmacyKey = pd.PharmacyKey
				INNER JOIN ClaimsDDS.dbo.DrugDim AS dd ON f.DrugKey = dd.DrugKey
				WHERE pd.PharmacyKey > 0
				--AND f.[MonthYearKey] BETWEEN 202001 AND 202008
				AND dd.IsGeneric = 1
				AND dd.DrugKey > 0
				GROUP BY f.[MonthYearKey]
				, pd.PMID
				, dd.GPI
				) AS g ON g.PMID = dt.PMID
							AND g.GPI = dt.GPI
							AND dt.[MonthYearKey] = g.[MonthYearKey]
LEFT OUTER JOIN(SELECT f.[MonthYearKey]
				, pd.PMID
				, dd.GPI
				, SUM([QuantityDispensed]) AS [BrandQuantityDispensed]
				FROM ClaimsDDS.dbo.ClaimFactFDS AS f
				INNER JOIN ClaimsDDS.dbo.PharmacyDim AS pd ON f.PharmacyKey = pd.PharmacyKey
				INNER JOIN ClaimsDDS.dbo.DrugDim AS dd ON f.DrugKey = dd.DrugKey
				WHERE pd.PharmacyKey > 0
				--AND f.[MonthYearKey] BETWEEN 202001 AND 202008
				AND dd.IsGeneric = 0
				AND dd.DrugKey > 0
				GROUP BY f.[MonthYearKey]
				, pd.PMID
				, dd.GPI
				) AS b ON b.PMID = dt.PMID
							AND b.GPI = dt.GPI
							AND dt.[MonthYearKey] = b.[MonthYearKey]
GO
