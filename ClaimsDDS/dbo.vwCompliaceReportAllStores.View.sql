USE [ClaimsDDS]
GO
/****** Object:  View [dbo].[vwCompliaceReportAllStores]    Script Date: 12/22/2020 6:54:01 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[vwCompliaceReportAllStores]

AS


SELECT d.FirstDayOfMonth
, pd.PMID
, dd.GPI
, dd.IsGeneric
, SUM(f.QuantityDispensed) AS QuantityDispensed
FROM [dbo].[ClaimFactFDS] AS f 
INNER JOIN dbo.DateDim AS d ON f.DateOfServiceKey = d.DateKey
INNER JOIN dbo.PharmacyDim AS pd ON f.PharmacyKey = pd.PharmacyKey
INNER JOIN dbo.DrugDim AS dd ON f.DrugKey = dd.DrugKey
WHERE IsPaidClaim = 1
GROUP BY d.FirstDayOfMonth
, pd.PMID
, dd.GPI
, dd.IsGeneric

GO
