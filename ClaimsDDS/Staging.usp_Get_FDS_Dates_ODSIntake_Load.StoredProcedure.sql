USE [ClaimsDDS]
GO
/****** Object:  StoredProcedure [Staging].[usp_Get_FDS_Dates_ODSIntake_Load]    Script Date: 12/22/2020 6:54:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [Staging].[usp_Get_FDS_Dates_ODSIntake_Load]

AS

SET NOCOUNT ON;

BEGIN

	DECLARE @T TABLE(DateKey INT)

	--Get dates not in SalesFact table
	INSERT INTO @T(DateKey)
	SELECT DISTINCT DateKey
	FROM ODSIntake.Staging.FDS
	ORDER BY DateKey DESC
	
	-- Truncate table and reload to get dates to load
	TRUNCATE TABLE [Staging].[ODSIntake_FDS_DatesToLoad]

	INSERT INTO [Staging].[ODSIntake_FDS_DatesToLoad](RN, DateKey)
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


	UPDATE STATISTICS [Staging].[ODSIntake_FDS_DatesToLoad]

	SELECT RN, DateKey
	FROM [Staging].[ODSIntake_FDS_DatesToLoad]
	ORDER BY DateKey DESC, RN ASC

END



































GO
