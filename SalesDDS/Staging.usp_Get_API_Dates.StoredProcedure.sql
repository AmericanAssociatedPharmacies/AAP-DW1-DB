USE [SalesDDS]
GO
/****** Object:  StoredProcedure [Staging].[usp_Get_API_Dates]    Script Date: 12/22/2020 7:55:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE PROCEDURE [Staging].[usp_Get_API_Dates]

AS

SET NOCOUNT ON;

BEGIN

	DECLARE @T TABLE(DateKey INT)

	--Get dates not in SalesFact table
	INSERT INTO @T(DateKey)
	SELECT DISTINCT DateKey
	FROM Staging.API
	ORDER BY DateKey ASC
	--SELECT DISTINCT cast(CONVERT(varchar(20),B.InvDate,112) as INT) AS DateKey
	--FROM API.dbo.APISalesDetail AS B
	--CROSS APPLY(SELECT MAX(APISalesDetailID) AS MaxID
	--				FROM dbo.EventDimAPI	
	--			) AS ca
	--WHERE B.ID > ca.MaxID
	----WHERE B.InvDate >= '20130101' ---- To be used for reloading only
	--ORDER BY DateKey ASC

	
	-- Truncate table and reload to get dates to load
	TRUNCATE TABLE Staging.API_DatesToLoad

	INSERT INTO Staging.API_DatesToLoad(RN, DateKey)
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


	UPDATE STATISTICS Staging.API_DatesToLoad

	SELECT RN, DateKey
	FROM Staging.API_DatesToLoad

END


































GO
