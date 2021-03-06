USE [ClaimsDDS]
GO
/****** Object:  View [dbo].[vwFDSComplianceReportAllStore_2]    Script Date: 12/22/2020 6:54:01 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [dbo].[vwFDSComplianceReportAllStore_2]


AS


SELECT d.DateKey
, t4.PMID
, t2.GPI				
, t2.IsGeneric
, SUM(ISNULL(t1.QuantityDispensed,0.00)) AS QuantityDispensed
, COUNT_BIG(*) AS COUNT
FROM dbo.ClaimFactFDS AS t1
INNER JOIN dbo.DrugDim AS t2 ON t1.DrugKey = t2.DrugKey
INNER JOIN dbo.PharmacyDim AS t4 ON t1.PharmacyKey = t4.PharmacyKey
INNER JOIN dbo.DateDim AS d ON t1.DateofServiceKey = d.DateKey		
INNER JOIN dbo.ComplianceReportXref AS x ON x.EventKey = t1.EventKey		
WHERE t1.QuantityDispensed > 0
AND t4.PharmacyKey > 0
AND t2.DrugKey > 0
GROUP BY d.DateKey
, t4.PMID
, t2.GPI				
, t2.IsGeneric	
GO
