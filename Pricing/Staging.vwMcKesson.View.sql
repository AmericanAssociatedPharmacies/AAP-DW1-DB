USE [Pricing]
GO
/****** Object:  View [Staging].[vwMcKesson]    Script Date: 12/22/2020 7:32:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE VIEW [Staging].[vwMcKesson]


AS


--SELECT dt.DateKey
--, dt.McKessonItemNumber
--, dt.NDC
--, dt.Price
--FROM(SELECT 
--		CASE
--		WHEN DATEPART(dw, GETDATE()) = 2 THEN DateKey
--		ELSE CAST(CONVERT(varchar(20), GETDATE(), 112) as INT)
--		END AS DateKey	 
--	, CONVERT(VARCHAR(50), ItemNumber) AS McKessonItemNumber
--	, CONVERT(VARCHAR(11), REPLACE(NDC, '-', '')) AS NDC
--	, CONVERT(MONEY, [ProperContractPrice]) AS Price
--	FROM [ODSIntake].[dbo].[McKesson_clean_20180613]
--	) AS dt

SELECT dt.DateKey
, dt.McKessonItemNumber
, dt.NDC
, dt.Price
FROM(SELECT 
		--CASE
		--WHEN DATEPART(dw, GETDATE()) = 2 THEN DateKey
		--ELSE CAST(CONVERT(varchar(20), GETDATE(), 112) as INT)
		--END AS DateKey	
	CONVERT(INT, 20180611) AS DateKey 
	, ItemNumber AS McKessonItemNumber
	, REPLACE(NDC, '-', '') AS NDC
	, ProperContractPrice AS Price
  FROM [ODSIntake].[dbo].[McKesson_20180529_Clean] AS a
  WHERE NDC is NOT NULL
  AND NOT EXISTS(SELECT 1
					FROM [ODSIntake].[dbo].[McKesson_clean_20180613] AS b
					WHERE A.ndc = b.ndc  
  				)
	) AS dt


GO
