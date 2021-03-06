USE [ClaimsDDS]
GO
/****** Object:  View [dbo].[vwFDSComplianceReport_2]    Script Date: 12/22/2020 6:54:01 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE VIEW [dbo].[vwFDSComplianceReport_2]

AS


SELECT dt.DateKey
		, dt.PMID
		, GPI
		, Description
		, SUM(QuantityDispensed) AS QuantityDispensed
		FROM(SELECT d.DateKey
			, t4.PMID
			, t2.GPI
			, t2.Description		
			, t1.QuantityDispensed 			
			FROM ClaimsDDS.dbo.ClaimFactFDS AS t1
			INNER JOIN ClaimsDDS.dbo.DrugDim AS t2 ON t1.DrugKey = t2.DrugKey
			INNER JOIN ClaimsDDS.dbo.PharmacyDim AS t4 ON t1.PharmacyKey = t4.PharmacyKey
			INNER JOIN ClaimsDDS.dbo.DateDim AS d ON t1.DateofServiceKey = d.DateKey						
			WHERE t1.DateofServiceKey = (t1.DateofServiceKey + 0) -- Added for performance. Do not remove!			
			AND t2.DrugKey = (t2.DrugKey + 0)	
			AND EXISTS(SELECT 1
						FROM ClaimsDDS.dbo.ComplianceReportXref AS x
						WHERE x.EventKey = t1.EventKey
						)

			) AS dt
GROUP BY dt.DateKey
		, dt.PMID
		, dt.GPI
		, dt.Description
	




GO
