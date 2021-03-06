USE [ODSIntake]
GO
/****** Object:  StoredProcedure [dbo].[usp_Rebates_UnauditedData_Load]    Script Date: 12/22/2020 7:30:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_Rebates_UnauditedData_Load]

AS

SET NOCOUNT ON;

BEGIN

	INSERT INTO ODSIntake.dbo.RebatesUnAudited(PMID, RebateDate, [APIBrandRx], [APIGenericRx], [APIOTC])
	SELECT dt.PMID, dt.RebateDate, ISNULL(dt.APIBrandRx, 0.00) AS APIBrandRx, ISNULL(dt.APIGenericRx, 0.00) AS APIGenericRx, ISNULL(dt.APIOTC, 0.00) AS APIOTC
	FROM(SELECT pm.PMID, ISNULL(ISNULL(o1.RebateDate, o2.RebateDate) , o3.RebateDate) AS RebateDate, o1.APIBrandRx, o2.APIGenericRx, o3.APIOTC, (ISNULL(o1.APIBrandRx, 0.00) + ISNULL(o2.APIGenericRx, 0.00) + ISNULL(o3.APIOTC, 0.00)) AS C1
			FROM [PharmacyMaster].[dbo].[PM_Pharmacy] AS pm
			LEFT OUTER JOIN (SELECT p.PMID
									   , DATEADD(month, DATEDIFF(month, 0, InvDate), 0) as RebateDate
									   , SUM(ExtSales) AS APIBrandRx
									   FROM API.dbo.APISalesDetail AS a
									   INNER JOIN [PharmacyMaster].[dbo].[PM_Pharmacy] AS p ON a.WHAccountID = LEFT(p.APIAccountNo, 8)
									   WHERE a.Type = 'Brand'
									   GROUP BY p.PMID, DATEADD(month, DATEDIFF(month, 0, InvDate), 0)
									   ) AS o1 ON pm.PMID = o1.PMID
			LEFT OUTER JOIN(SELECT p.PMID
									   , DATEADD(month, DATEDIFF(month, 0, InvDate), 0) as RebateDate
									   , SUM(ExtSales) AS APIGenericRx
									   FROM API.dbo.APISalesDetail AS a
									   INNER JOIN [PharmacyMaster].[dbo].[PM_Pharmacy] AS p ON a.WHAccountID = LEFT(p.APIAccountNo, 8)
									   WHERE a.Type = 'Generic'
									   GROUP BY p.PMID, DATEADD(month, DATEDIFF(month, 0, InvDate), 0)
									   ) AS o2 ON o2.PMID = pm.PMID AND o2.RebateDate = o1.RebateDate
			LEFT OUTER JOIN(SELECT p.PMID
									   , DATEADD(month, DATEDIFF(month, 0, InvDate), 0) as RebateDate
									   , SUM(ExtSales) AS APIOTC
									   FROM API.dbo.APISalesDetail AS a
									   INNER JOIN [PharmacyMaster].[dbo].[PM_Pharmacy] AS p ON a.WHAccountID = LEFT(p.APIAccountNo, 8)
									   WHERE a.Type = 'OTC'
									   GROUP BY p.PMID, DATEADD(month, DATEDIFF(month, 0, InvDate), 0)
									   ) AS o3 ON o3.PMID = pm.PMID AND o3.RebateDate = o1.RebateDate AND o3.RebateDate = o2.RebateDate
			) AS dt
	WHERE NOT EXISTS(SELECT 1
						FROM ODSIntake.dbo.RebatesUnAudited AS r
						WHERE dt.PMID = r.PMID
						AND dt.RebateDate = r.RebateDate
						)
	AND dt.C1 > 0.00;

	UPDATE STATISTICS ODSIntake.dbo.RebatesUnAudited;

END
GO
