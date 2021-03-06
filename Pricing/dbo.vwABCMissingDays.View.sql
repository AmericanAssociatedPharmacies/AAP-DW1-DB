USE [Pricing]
GO
/****** Object:  View [dbo].[vwABCMissingDays]    Script Date: 12/22/2020 7:32:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vwABCMissingDays]

AS


SELECT dd.DateKey
, dt.DrugKey
, dt.CompetitorDrugKey
, dt.[AmerisourceBergen(ABC)_Price]
FROM(SELECT ca.DateKey
	, ca.DrugKey
	, ca.[AmerisourceBergen(ABC)_Price]
	, ca.CurrentDateKey
	, ca.NewDateKey
	, ca.CompetitorDrugKey
	FROM(SELECT MAX([DateKey]) AS MaxDateKey
			FROM [dbo].[PriceFact]  
		) AS dt
	CROSS APPLY(SELECT p2.[AmerisourceBergen(ABC)_Price]
				, p2.DrugKey
				, p2.DateKey
				, p2.CompetitorDrugKey
				, p2.DateKey + 1 AS NewDateKey
				, CAST(CONVERT(VARCHAR(8), CURRENT_TIMESTAMP, 112) AS INT) AS CurrentDateKey
				FROM dbo.PriceFact AS p2
				WHERE p2.DateKey = dt.MaxDateKey		
							) AS ca
	WHERE ca.DateKey = dt.MaxDateKey
	) AS dt
CROSS JOIN dbo.DateDim AS dd
WHERE dd.DayOfWeek NOT IN(6,7)
AND dd.DateKey >= dt.NewDateKey
AND dd.DateKey <  dt.CurrentDateKey



GO
