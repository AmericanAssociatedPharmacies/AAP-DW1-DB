USE [Reports]
GO
/****** Object:  View [dbo].[vw_DispReport_01]    Script Date: 12/22/2020 7:39:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [dbo].[vw_DispReport_01]
AS
     SELECT pm.PMID
          , ed.NDC
          , CASE
			 WHEN MONTH(ed.DateOfService) = 1 THEN CAST('2018-01-01' AS date)    
			 WHEN MONTH(ed.DateOfService) = 2 THEN CAST('2018-02-01' AS date)
			 WHEN MONTH(ed.DateOfService) = 3 THEN CAST('2018-03-01' AS date)
			 WHEN MONTH(ed.DateOfService) = 4 THEN CAST('2018-04-01' AS date)
			 WHEN MONTH(ed.DateOfService) = 5 THEN CAST('2018-05-01' AS date)
			 WHEN MONTH(ed.DateOfService) = 6 THEN CAST('2018-06-01' AS date)
			 WHEN MONTH(ed.DateOfService) = 7 THEN CAST('2018-07-01' AS date)
			 WHEN MONTH(ed.DateOfService) = 8 THEN CAST('2018-08-01' AS date)
			 WHEN MONTH(ed.DateOfService) = 9 THEN CAST('2018-09-01' AS date)
			 WHEN MONTH(ed.DateOfService) = 10 THEN CAST('2018-10-01' AS date)
			 WHEN MONTH(ed.DateOfService) = 11 THEN CAST('2018-11-01' AS date)
			 WHEN MONTH(ed.DateOfService) = 12 THEN CAST('2018-12-01' AS date)
			 END
			 AS Month
          , SUM(cf.QuantityDispensed) AS ToalDisp
     FROM ClaimsDDS.dbo.EventDimRX30 AS ed
		JOIN ClaimsDDS.dbo.ClaimFactRX30 AS cf ON ed.EventKey = cf.EventKey 
          JOIN PharmacyMaster.dbo.PM_Pharmacy AS pm ON ed.ServiceProviderID = pm.NCPDP
     WHERE ed.DateOfService >= '20180101'
	AND ed.FileProcessed IS NOT NULL
     GROUP BY pm.PMID
            , ed.NDC
            , MONTH(ed.DateOfService);
 





GO
