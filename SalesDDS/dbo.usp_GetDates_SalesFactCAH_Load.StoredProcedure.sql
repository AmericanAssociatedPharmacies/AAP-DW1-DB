USE [SalesDDS]
GO
/****** Object:  StoredProcedure [dbo].[usp_GetDates_SalesFactCAH_Load]    Script Date: 12/22/2020 7:55:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO










CREATE PROCEDURE [dbo].[usp_GetDates_SalesFactCAH_Load]

AS

SET NOCOUNT ON;

BEGIN

	
	
	DECLARE @T TABLE(DateKey INT)

	INSERT INTO @T(DateKey)
	SELECT DISTINCT DateKey
	FROM [Staging].[SalesFact_CAH] AS c
	--WHERE c.DateKey >= 20170101
	--AND c.DateKey < 20170101
	ORDER BY DateKey ASC


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

	
	

END








GO
