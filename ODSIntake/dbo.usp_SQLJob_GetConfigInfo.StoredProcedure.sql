USE [ODSIntake]
GO
/****** Object:  StoredProcedure [dbo].[usp_SQLJob_GetConfigInfo]    Script Date: 12/22/2020 7:30:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_SQLJob_GetConfigInfo]


AS

SET NOCOUNT ON;

BEGIN

	SELECT dt.ServerName
	, dt.BatchDate
	FROM(SELECT ServerName
			, ISNULL(CONVERT(VARCHAR(25), MAX(RunDateTime), 121), '19000101') AS BatchDate
			FROM dbo.SQLJobHistory		
			GROUP BY ServerName	
		) AS dt
	--CROSS JOIN(SELECT 'DB1' AS ServerName
	--			UNION ALL
	--			SELECT 'AAPDW1'	
	--			) AS cj


END
GO
