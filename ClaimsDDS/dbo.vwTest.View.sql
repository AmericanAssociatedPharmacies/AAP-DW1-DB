USE [ClaimsDDS]
GO
/****** Object:  View [dbo].[vwTest]    Script Date: 12/22/2020 6:54:01 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vwTest]

WITH SCHEMABINDING

AS

SELECT f.MonthYearKey
		, pd.PharmacyKey
       , f.GPIKey
     , SUM(f.[QuantityDispensed]) AS [QuantityDispensed]	
       FROM dbo.PharmacyDim AS pd
       INNER JOIN dbo.ClaimFactFDS AS f ON f.PharmacyKey = pd.PharmacyKey
	   --INNER JOIN dbo.DateDim AS d ON f.MonthYearKey = d.CCYYMM
       --CROSS APPLY(SELECT DISTINCT GPIKey
       --                    FROM dbo.DrugDim
       --                    WHERE GPIKey > 0
       --                    ) AS ca       
       --WHERE ca.GPIKey = f.GPIKey
     WHERE f.MonthYearKey BETWEEN 201901 AND 202008
       AND f.PharmacyKey > 0
       AND f.DrugKey > 0
       AND f.[QuantityDispensed]  > 0
	   AND f.GPIKey > 0
	  AND  [IsPaidClaim] = 1
	    --AND f.MonthYearKey = (f.MonthYearKey + 0)
		AND f.PharmacyKey = (f.PharmacyKey + 0)
		AND pd.PharmacyKey = (pd.PharmacyKey + 0)
		AND f.GPIKey = (f.GPIKey + 0)
		--AND ca.GPIKey = (ca.GPIKey +  0)
       GROUP BY f.MonthYearKey
	   , pd.PharmacyKey
       , f.GPIKey

--SELECT f.MonthYearKey
--, f.PharmacyKey
--, dd.GPIKey
--, SUM([QuantityDispensed]) AS QtyDispensed
--FROM dbo.DrugDim AS dd
--INNER JOIN dbo.ClaimFactFDS AS f ON dd.GPIKey = f.GPIKey
--WHERE [IsPaidClaim] = 1
-- AND f.PharmacyKey > 0
--AND f.DrugKey > 0
--AND f.[QuantityDispensed]  > 0
--AND f.GPIKey > 0
--AND f.PharmacyKey = (f.PharmacyKey + 0)
--AND f.GPIKey = (f.GPIKey + 0)
--AND dd.GPIKey = (dd.GPIKey + 0)
--AND dd.GPIKey > 0
--AND f.MonthYearKey BETWEEN 202001 AND 202008
--GROUP BY f.MonthYearKey
--, f.PharmacyKey
--, dd.GPIKey
GO
