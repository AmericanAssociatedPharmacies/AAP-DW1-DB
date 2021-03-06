USE [Reports]
GO
/****** Object:  UserDefinedFunction [dbo].[tvfComplianceDetail]    Script Date: 12/22/2020 7:39:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[tvfComplianceDetail] (@PMID INT, @StartDateKey INT, @EndDateKey INT, @IsGeneric BIT = NULL, @IsBrand BIT = NULL)

RETURNS TABLE

AS

RETURN

WITH C AS
(SELECT PMID 
	, GPIKey
	, SUM(TotalQuantityDispensed) AS TotalQuantityDispensed
	, SUM(TotalPurchaseQty) AS TotalPurchaseQty
	, SUM(TotalPurchaseIP) AS TotalPurchaseIP
	, SUM(TotalLeakageQty) AS TotalLeakageQty
	, SUM(TotalDispensedIP) AS TotalDispensedIP
	, SUM(TotalLeakageIP) AS TotalLeakageIP
	FROM dbo.ComplianceAllStores
	WHERE DateKey BETWEEN @StartDateKey AND @EndDateKey
	AND PMID = @PMID	
	AND @IsGeneric IS NULL
	AND @IsBrand IS NULL
	GROUP BY PMID
	, GPIKey
)
, G AS 
(SELECT PMID 
	, c.GPIKey
	, CONVERT(BIT,1) AS IsGeneric
	, SUM(GenericQuantityDispensed) AS GenericQuantityDispensed
	, SUM(GenericPurchaseQty) AS GenericPurchaseQty
	, SUM(GenericPurchaseIP) AS GenericPurchaseIP
	, SUM(GenericLeakageQty) AS GenericLeakageQty
	, SUM(GenericDispensedIP) AS GenericDispensedIP
	, SUM(GenericLeakageIP) AS GenericLeakageIP
	FROM dbo.ComplianceAllStores AS c
	INNER JOIN(SELECT DISTINCT GPIKey
				FROM DrugMaster.dbo.DrugDim
				WHERE IsGeneric = 1
				) AS dd ON c.GPIKey = dd.GPIKey
	WHERE DateKey BETWEEN @StartDateKey AND @EndDateKey
	AND PMID = @PMID	
	AND @IsGeneric = 1
	GROUP BY PMID
	, c.GPIKey
)
, B AS 
(SELECT PMID 
	, c.GPIKey
	, CONVERT(BIT,1) AS IsBrand
	, SUM(BrandQuantityDispensed) AS BrandQuantityDispensed
	, SUM(BrandPurchaseQty) AS BrandPurchaseQty
	, SUM(BrandPurchaseIP) AS BrandPurchaseIP
	, SUM(BrandLeakageQty) AS BrandLeakageQty
	, SUM(BrandLeakageIP) AS BrandLeakageIP
	, SUM(BrandDispensedIP) AS BrandDispensedIP
	FROM [dbo].[ComplianceAllStores] AS c
	INNER JOIN(SELECT DISTINCT GPIKey
				FROM DrugMaster.dbo.DrugDim
				WHERE IsGeneric = 0
				) AS dd ON c.GPIKey = dd.GPIKey
	WHERE DateKey BETWEEN @StartDateKey AND @EndDateKey
	AND PMID = @PMID
	AND @IsBrand = 1
	GROUP BY PMID
	, c.GPIKey
)

SELECT ISNULL(ISNULL(g.PMID,b.PMID),c.PMID) AS PMID
, ISNULL(ISNULL(g.GPIKey,b.GPIKey),c.GPIKey) AS GPIKey
, ISNULL(ISNULL(g.GenericQuantityDispensed,b.BrandQuantityDispensed), c.TotalQuantityDispensed) AS QtyDispensed
, ISNULL(ISNULL(g.GenericPurchaseQty,b.BrandPurchaseQty),c.TotalPurchaseQty) AS PurchaseQty
, ISNULL(ISNULL(g.GenericPurchaseIP,b.BrandPurchaseIP), c.TotalPurchaseIP) AS PurchaseIP
, ISNULL(ISNULL(g.GenericDispensedIP,b.BrandDispensedIP), c.TotalDispensedIP) AS DispensedIP
, ISNULL(ISNULL(g.GenericLeakageQty,b.BrandLeakageQty),c.TotalLeakageQty) AS LeakageQty
, ISNULL(ISNULL(g.GenericLeakageIP,b.BrandLeakageIP), c.TotalLeakageIP) AS LeakeageIP
FROM(SELECT DISTINCT PMID, GPIKey 
		FROM [dbo].[ComplianceAllStores]
		WHERE PMID = @PMID
		AND DateKey BETWEEN @StartDateKey AND @EndDateKey
		) AS a
LEFT OUTER JOIN G as g ON a.PMID = g.PMID
							AND a.GPIKey = g.GPIKey																			
LEFT OUTER JOIN B AS b ON a.PMID = b.PMID
							AND a.GPIKey = b.GPIKey
LEFT OUTER JOIN C AS c ON a.PMID = c.PMID
							AND a.GPIKey = c.GPIKey
WHERE (g.PMID IS NOT NULL
		OR b.PMID IS NOT NULL
		OR c.PMID IS NOT NULL
		)
AND (g.GPIKey IS NOT NULL
		OR b.GPIKey IS NOT NULL
		OR c.GPIKey IS NOT NULL
		)
AND (g.GenericQuantityDispensed IS NOT NULL
	 OR b.BrandQuantityDispensed IS NOT NULL
	 OR c.TotalQuantityDispensed IS NOT NULL
	 )
AND (g.GenericPurchaseQty IS NOT NULL
	 OR b.BrandPurchaseQty IS NOT NULL
	 OR c.TotalPurchaseQty IS NOT NULL
	 )
AND (g.GenericPurchaseIP IS NOT NULL
	 OR b.BrandPurchaseIP IS NOT NULL
	 OR c.TotalPurchaseIP IS NOT NULL
	 )
AND (g.GenericDispensedIP IS NOT NULL
		OR b.BrandDispensedIP IS NOT NULL
		OR c.TotalDispensedIP IS NOT NULL
	)
AND (g.GenericLeakageQty IS NOT NULL
		OR b.BrandLeakageQty IS NOT NULL
		OR c.TotalLeakageQty IS NOT NULL
	)
AND (g.GenericLeakageIP IS NOT NULL
		OR b.BrandLeakageIP IS NOT NULL
		OR c.TotalLeakageIP IS NOT NULL
	)
							
GO
