USE [ClaimsDDS]
GO
/****** Object:  View [dbo].[vwClaimsGenerics]    Script Date: 12/22/2020 6:54:01 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vwClaimsGenerics]

AS


SELECT pd.PMID
--, dd.GPI
, d.[FirstDayOfMonth]
, SUM([TotalQuantity]) AS TotalQuantityDispensed
FROM ClaimsDDS.[dbo].[ClaimFactFDS] AS f 
INNER JOIN ClaimsDDS.dbo.DateDim AS d ON f.DateOfServiceKey = d.DateKey
INNER JOIN ClaimsDDS.dbo.PharmacyDim AS pd ON f.PharmacyKey = pd.PharmacyKey
INNER JOIN ClaimsDDS.dbo.DrugDim AS dd ON f.DrugKey = dd.DrugKey
WHERE pd.PharmacyKey > 0
AND dd.IsGeneric = 1
GROUP BY pd.PMID
--, dd.GPI
, d.[FirstDayOfMonth]
GO
