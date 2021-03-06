USE [ClaimsDDS]
GO
/****** Object:  StoredProcedure [dbo].[usp_FDS_GetDates]    Script Date: 12/22/2020 6:54:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[usp_FDS_GetDates]

AS

SET NOCOUNT ON;

BEGIN

	DECLARE @T TABLE(DateKey INT)

	--Get dates not in SalesFact table
	INSERT INTO @T(DateKey)
	SELECT DISTINCT DateKey
	FROM Staging.FDS
	ORDER BY DateKey ASC
	
	-- Truncate table and reload to get dates to load
	TRUNCATE TABLE [dbo].[FDS_DatesToLoad]

	INSERT INTO [dbo].[FDS_DatesToLoad](RN, DateKey)
	SELECT ca.RN
	, ca.DateKey
	FROM(SELECT ROW_NUMBER() OVER(ORDER BY DateKey ASC) AS RN
			, DateKey
			FROM @T
		) AS dt
	CROSS APPLY(SELECT CASE
				WHEN dt.RN % 3 = 1 THEN 1
				WHEN dt.RN % 3 = 2 THEN 2
				ELSE 3
				END AS RN
				, DateKey
				FROM @T
				) AS ca
	WHERE dt.DateKey = ca.DateKey


	UPDATE STATISTICS [dbo].[FDS_DatesToLoad]

	SELECT RN, DateKey
	FROM [dbo].[FDS_DatesToLoad]
	ORDER BY DateKey ASC, RN ASC

	--DECLARE @StartDateKey INT
	--, @EndDateKey INT

	--SET @StartDateKey = CAST(CONVERT(VARCHAR(20),DATEADD(yy, DATEDIFF(yy, 0, GETDATE()) - 2, 0),112) as INT) -- 3 yrs back from current date
	--SET @EndDateKey = CAST(CONVERT(VARCHAR(20),GETDATE(),112) as INT) -- current date

	
	--SELECT dt.DateKey
	--FROM(SELECT DISTINCT DateKey
	--	FROM [Staging].[FDS]
	--	WHERE DateKey >= @StartDateKey
	--	AND DateKey < @EndDateKey
	--	) AS dt
	--ORDER BY dt.DateKey ASC

END



GO
