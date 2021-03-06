USE [ClaimsDDS]
GO
/****** Object:  UserDefinedFunction [dbo].[tvfClaimsQtyDispensed]    Script Date: 12/22/2020 6:54:01 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE FUNCTION [dbo].[tvfClaimsQtyDispensed] (@StartMonthYearKey INT, @EndMonthYearKey INT)

RETURNS TABLE

AS

RETURN


WITH ClaimAll AS 
(SELECT MonthYearKey
	, PharmacyKey
	, GPIKey
	, SUM([QuantityDispensed]) AS [QuantityDispensed]	
	FROM  ClaimsDDS.dbo.ClaimFactFDS 
	WHERE MonthYearKey BETWEEN @StartMonthYearKey AND @EndMonthYearKey
	AND PharmacyKey > 0
	AND DrugKey > 0
	AND [QuantityDispensed]  > 0
	AND MonthYearKey = (MonthYearKey + 0)
	AND PharmacyKey = (PharmacyKey + 0)
	AND GPIKey = (GPIKey + 0)
	AND IsPaidClaim = 1
	GROUP BY MonthYearKey
	, PharmacyKey
	, GPIKey
    
)
, ClaimGeneric AS
(SELECT MonthYearKey
				, PharmacyKey
				, dd.GPIKey
				, SUM([QuantityDispensed]) AS GenericQuantityDispensed
				FROM  ClaimsDDS.dbo.ClaimFactFDS AS f
				INNER JOIN ClaimsDDS.dbo.DrugDim AS dd ON dd.DrugKey = f.DrugKey		
			   WHERE f.MonthYearKey BETWEEN @StartMonthYearKey AND @EndMonthYearKey
			   AND dd.IsGeneric = 1
			   AND f.PharmacyKey > 0
			   AND f.DrugKey > 0
			   AND f.[QuantityDispensed]  > 0
			   AND f.MonthYearKey = (f.MonthYearKey + 0)
				AND f.PharmacyKey = (f.PharmacyKey + 0)
				AND f.GPIKey = (f.GPIKey + 0)
				AND f.IsPaidClaim = 1
				GROUP BY MonthYearKey
				, PharmacyKey
				, dd.GPIKey
)
, ClaimBrand AS
(SELECT MonthYearKey
				, PharmacyKey
				, dd.GPIKey
				, SUM([QuantityDispensed]) AS BrandQuantityDispensed
				FROM  ClaimsDDS.dbo.ClaimFactFDS AS f
				INNER JOIN ClaimsDDS.dbo.DrugDim AS dd ON dd.DrugKey = f.DrugKey		
			   WHERE f.MonthYearKey BETWEEN @StartMonthYearKey AND @EndMonthYearKey
			   AND dd.IsGeneric = 0
			   AND f.PharmacyKey > 0
			   AND f.DrugKey > 0
			   AND f.[QuantityDispensed]  > 0
			   AND f.MonthYearKey = (f.MonthYearKey + 0)
				AND f.PharmacyKey = (f.PharmacyKey + 0)
				AND f.GPIKey = (f.GPIKey + 0)
				AND f.IsPaidClaim = 1
				GROUP BY MonthYearKey
				, PharmacyKey
				, dd.GPIKey
)

SELECT c.MonthYearKey
, c.PharmacyKey
, c.GPIKey
, CONVERT(DECIMAL(18,2),c.QuantityDispensed) AS FDSQuantityDispensed
, CONVERT(DECIMAL(18,2),ISNULL(g.GenericQuantityDispensed,0.00)) AS FDSGenericQuantityDispensed
, CONVERT(DECIMAL(18,2),ISNULL(b.BrandQuantityDispensed,0.00)) AS FDSBrandQuantityDispensed
FROM ClaimAll AS c
LEFT OUTER JOIN ClaimGeneric AS g ON c.PharmacyKey = g.PharmacyKey
										AND c.GPIKey = g.GPIKey	
										AND c.MonthYearKey = g.MonthYearKey									
LEFT OUTER JOIN ClaimBrand AS b ON c.PharmacyKey = b.PharmacyKey
										AND c.GPIKey = b.GPIKey
										AND c.MonthYearKey = b.MonthYearKey
										


GO
