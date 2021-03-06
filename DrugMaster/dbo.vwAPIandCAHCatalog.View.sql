USE [DrugMaster]
GO
/****** Object:  View [dbo].[vwAPIandCAHCatalog]    Script Date: 12/22/2020 6:57:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vwAPIandCAHCatalog]

AS


SELECT ISNULL(dt1.NDC, dt2.NDC) AS NDC
, ISNULL(dt1.GPI,dt2.GPI) AS GPI
, dt1.IsAPIActive
, dt2.IsCAHActive
FROM DrugMaster.dbo.DrugDim AS d
LEFT OUTER JOIN(SELECT a.NDC, d.GPI, CONVERT(BIT, CASE
											WHEN a.ProductHandlingStatusCode = 'Active' THEN 1
											ELSE 0
											END
											) AS IsAPIActive
				FROM DrugMaster.dbo.DrugDim AS d
				INNER JOIN DrugMaster.dbo.APICatalog AS a ON a.NDC = d.NDC				
				) AS dt1 ON d.NDC = dt1.NDC
LEFT OUTER JOIN(SELECT c.NDC, d.GPI, CONVERT(BIT, 1) AS IsCAHActive
				FROM DrugMaster.dbo.DrugDim AS d
				INNER JOIN  CAHODS.dbo.CardinalComplete AS c ON d.NDC = c.NDC 
				) AS dt2 ON d.NDC = dt2.NDC
WHERE (dt1.NDC IS NOT NULL
		OR dt2.NDC IS NOT NULL
		)
AND (dt1.GPI IS NOT NULL
		OR dt2.GPI IS NOT NULL
		)


GO
