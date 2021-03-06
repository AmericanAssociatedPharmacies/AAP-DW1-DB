USE [SalesDDS]
GO
/****** Object:  StoredProcedure [dbo].[usp_UpdateEvenDimAPI_20200514]    Script Date: 12/22/2020 7:55:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_UpdateEvenDimAPI_20200514]

AS

SET NOCOUNT ON

BEGIN 

	ALTER INDEX [NCC_EventDimAPI]
	ON [dbo].[EventDimAPI]
	DISABLE;


	DECLARE @StartDateKey INT
	, @EndDateKey INT


	DECLARE C1 CURSOR FOR
	SELECT dt.StartDateKey, dt.EndDateKey
	FROM(SELECT DISTINCT CAST(CONVERT(VARCHAR(20), FirstDayOfMonth, 112) AS INT) AS StartDateKey
		, CAST(CONVERT(VARCHAR(20), LastDayOfMonth, 112) AS INT) AS EndDateKey 
		FROM dbo.DateDim
		WHERE DateKey BETWEEN 20180101 AND 20200513
		) AS dt


	OPEN C1

	FETCH NEXT
	FROM C1
	INTO @StartDateKey, @EndDateKey

	WHILE @@FETCH_STATUS = 0
	BEGIN

		UPDATE x
		SET [RowversionIDOnDB1] = a.RowversionID
		FROM dbo.EventDimAPI AS x
		INNER JOIN dbo.API_20200514 AS a ON x.DateKey = a.DateKey
										AND x.APISalesDetailID = a.APISalesDetailID
		WHERE x.DateKey BETWEEN @StartDateKey AND @EndDateKey

		FETCH NEXT
		FROM C1
		INTO @StartDateKey, @EndDateKey

	END

	CLOSE C1
	DEALLOCATE C1


	ALTER INDEX [NCC_EventDimAPI]
	ON [dbo].[EventDimAPI]
	REBUILD;

END

GO
