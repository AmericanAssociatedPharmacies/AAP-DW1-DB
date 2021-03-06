USE [ClaimsDDS]
GO
/****** Object:  View [dbo].[vwFDSComplianceReportAllStore]    Script Date: 12/22/2020 6:54:01 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO









CREATE VIEW [dbo].[vwFDSComplianceReportAllStore]

AS


SELECT dt.DateKey
		, dt.PMID
		, GPI
		, QuantityDispensed
		, dt.IsGeneric
		FROM(SELECT d.DateKey
			, t4.PMID
			, t2.GPI				
			, t1.QuantityDispensed 	
			, t2.IsGeneric
			FROM ClaimsDDS.dbo.ClaimFactFDS AS t1
			INNER JOIN ClaimsDDS.dbo.DrugDim AS t2 ON t1.DrugKey = t2.DrugKey
			INNER JOIN ClaimsDDS.dbo.PharmacyDim AS t4 ON t1.PharmacyKey = t4.PharmacyKey
			INNER JOIN ClaimsDDS.dbo.DateDim AS d ON t1.DateofServiceKey = d.DateKey		
			INNER JOIN ClaimsDDS.dbo.ComplianceReportXref AS x ON x.EventKey = t1.EventKey						
			WHERE t1.DateofServiceKey = (t1.DateofServiceKey + 0) -- Added for performance. Do not remove!
			AND t2.DrugKey = (t2.DrugKey + 0)
			--AND x.EventKey = (x.EventKey + 0)
			------AND t3.EventKey = (t3.EventKey + 0)	-- Added for performance. Do not remove
			----AND t2.DrugKey = (t2.DrugKey + 0)		
			) AS dt
		







GO
