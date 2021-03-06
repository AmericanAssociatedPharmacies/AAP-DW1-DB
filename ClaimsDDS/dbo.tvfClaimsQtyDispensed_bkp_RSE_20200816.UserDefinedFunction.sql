USE [ClaimsDDS]
GO
/****** Object:  UserDefinedFunction [dbo].[tvfClaimsQtyDispensed_bkp_RSE_20200816]    Script Date: 12/22/2020 6:54:01 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE FUNCTION [dbo].[tvfClaimsQtyDispensed_bkp_RSE_20200816] (@StartMonthYearKey INT, @EndMonthYearKey INT)

RETURNS TABLE

AS

RETURN


WITH ClaimAll AS 
(
SELECT dt.PharmacyKey
, dt.GPIKey
, dt.[QuantityDispensed]	
FROM(SELECT pd.PharmacyKey
       , ca.GPIKey
     , SUM(f.[QuantityDispensed]) AS [QuantityDispensed]	
       FROM dbo.PharmacyDim AS pd
       INNER JOIN ClaimsDDS.dbo.ClaimFactFDS AS f ON f.PharmacyKey = pd.PharmacyKey
	   INNER JOIN dbo.DateDim AS d ON f.MonthYearKey = d.CCYYMM
       CROSS APPLY(SELECT DISTINCT GPIKey
                           FROM dbo.DrugDim
                           WHERE GPIKey > 0
                           ) AS ca       
       WHERE ca.GPIKey = f.GPIKey
       AND f.MonthYearKey BETWEEN @StartMonthYearKey AND @EndMonthYearKey
       AND f.PharmacyKey > 0
       AND f.DrugKey > 0
       AND f.[QuantityDispensed]  > 0
	   AND f.IsPaidClaim = 1
       GROUP BY d.FirstDayOfMonth
	   , pd.PharmacyKey
       , ca.GPIKey
       ) AS dt
)
, ClaimGeneric AS
(SELECT pd.PharmacyKey
       , ca.GPIKey
     , SUM(f.[QuantityDispensed]) AS [GenericQuantityDispensed]	
       FROM dbo.PharmacyDim AS pd
       INNER JOIN ClaimsDDS.dbo.ClaimFactFDS AS f ON f.PharmacyKey = pd.PharmacyKey
	   INNER JOIN dbo.DateDim AS d ON f.MonthYearKey = d.CCYYMM
       CROSS APPLY(SELECT DISTINCT GPIKey
                           FROM dbo.DrugDim
                           WHERE GPIKey > 0
						   AND IsGeneric = 1
                           ) AS ca       
       WHERE ca.GPIKey = f.GPIKey
       AND f.MonthYearKey BETWEEN @StartMonthYearKey AND @EndMonthYearKey
       AND f.PharmacyKey > 0
       AND f.DrugKey > 0
       AND f.[QuantityDispensed]  > 0
	   AND f.IsPaidClaim = 1
	   GROUP BY d.FirstDayOfMonth
	   , pd.PharmacyKey
       , ca.GPIKey
)
, ClaimBrand AS
(SELECT pd.PharmacyKey
       , ca.GPIKey
     , SUM(f.[QuantityDispensed]) AS [BrandQuantityDispensed]	
       FROM dbo.PharmacyDim AS pd
       INNER JOIN ClaimsDDS.dbo.ClaimFactFDS AS f ON f.PharmacyKey = pd.PharmacyKey
	   INNER JOIN dbo.DateDim AS d ON f.MonthYearKey = d.CCYYMM
       CROSS APPLY(SELECT DISTINCT GPIKey
                           FROM dbo.DrugDim
                           WHERE GPIKey > 0
						   AND IsGeneric = 0
                           ) AS ca       
       WHERE ca.GPIKey = f.GPIKey
       AND f.MonthYearKey BETWEEN @StartMonthYearKey AND @EndMonthYearKey
       AND f.PharmacyKey > 0
       AND f.DrugKey > 0
       AND f.[QuantityDispensed]  > 0
	   AND f.IsPaidClaim = 1
	   GROUP BY d.FirstDayOfMonth
	   , pd.PharmacyKey
       , ca.GPIKey
)

SELECT c.PharmacyKey
, c.GPIKey
, CONVERT(DECIMAL(18,2),c.QuantityDispensed) AS FDSQuantityDispensed
, CONVERT(DECIMAL(18,2),ISNULL(g.GenericQuantityDispensed,0.00)) AS FDSGenericQuantityDispensed
, CONVERT(DECIMAL(18,2),ISNULL(b.BrandQuantityDispensed,0.00)) AS FDSBrandQuantityDispensed
FROM ClaimAll AS c
LEFT OUTER JOIN ClaimGeneric AS g ON c.PharmacyKey = g.PharmacyKey
										AND c.GPIKey = g.GPIKey										
LEFT OUTER JOIN ClaimBrand AS b ON c.PharmacyKey = b.PharmacyKey
										AND c.GPIKey = b.GPIKey
										


GO
