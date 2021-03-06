USE [Pricing]
GO
/****** Object:  View [dbo].[vwABCLoad]    Script Date: 12/22/2020 7:32:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[vwABCLoad]

AS

SELECT ISNULL(oj1.DateKey, oj2.DateKey) AS DateKey
, ISNULL(oj1.DrugKey, oj2.DrugKey) AS DrugKey
, ISNULL(oj1.CompetitorDrugKey, oj2.CompetitorDrugKey) AS CompetitorDrugKey
, ISNULL(oj1.[AmerisourceBergen(ABC)_Price], oj2.[AmerisourceBergen(ABC)_Price]) AS [AmerisourceBergen(ABC)_Price]
FROM(SELECT 1 AS C1
		) AS dt
LEFT OUTER JOIN( SELECT 1 AS C1
				, a.DateKey
				, ISNULL(dm.DrugKey, 0) AS DrugKey
				, a.NDC
				, ABCItemNum
				, LPR_Price AS [AmerisourceBergen(ABC)_Price]
				, ISNULL(dd.CompetitorDrugKey, 0) AS CompetitorDrugKey
				FROM [Staging].[ABC] AS a
				LEFT OUTER JOIN  [dbo].[DrugDim] AS dm ON a.NDC = dm.NDC
				LEFT OUTER JOIN [dbo].[CompetitorDrugDim] AS dd ON a.NDC = dd.NDC
																AND a.DateKey = dd.DateKey
				) AS oj1 ON dt.C1 = oj1.C1
LEFT OUTER JOIN(SELECT 1 AS C1
				, DateKey
				, DrugKey
				, CompetitorDrugKey
				, [AmerisourceBergen(ABC)_Price]
				FROM dbo.vwABCMissingDays
				) AS oj2 ON dt.C1 =  oj2.C1
WHERE (oj1.DateKey IS NOT NULL
		OR oj2.DateKey IS NOT NULL
		)
AND (oj1.DrugKey IS NOT NULL
	OR oj2.DrugKey IS NOT NULL
	)
AND (oj1.[AmerisourceBergen(ABC)_Price] IS NOT NULL
		OR oj2.[AmerisourceBergen(ABC)_Price] IS NOT NULL
		)


GO
