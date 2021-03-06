USE [SalesDDS]
GO
/****** Object:  StoredProcedure [dbo].[usp_CAH_DeleteDups]    Script Date: 12/22/2020 7:55:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_CAH_DeleteDups]

AS

SET NOCOUNT ON;

BEGIN

	DECLARE @p1 INT

	DECLARE C1 CURSOR FOR
	SELECT [CHPH_AAP_ID]
	FROM(SELECT [CHPH_AAP_ID]
		, COUNT(*) AS Cnt
		FROM [dbo].[EventDimCAH]
		WHERE DateKey >= 20190101
		GROUP BY [CHPH_AAP_ID]
		) AS dt
	WHERE dt.Cnt > 1
	--4448

	OPEN C1

	FETCH NEXT 
	FROM C1
	INTO @p1

	WHILE @@FETCH_STATUS = 0
	BEGIN

		DELETE x
		FROM [dbo].[SalesFact_CAH] AS x
		INNER JOIN(SELECT c.EventKey
					FROM(SELECT MAX(EventKey) MAXEventKey
						FROM [dbo].[EventDimCAH]
						WHERE [CHPH_AAP_ID] = @p1
						) AS dt
					CROSS APPLY dbo.EventDimCAH AS c 
					WHERE c.CHPH_AAP_ID = @p1
					AND c.EventKey < dt.MAXEventKey
					) AS dt ON x.CAHEventKey = dt.EventKey


		DELETE x
		FROM [dbo].[EventDimCAH] AS x
		INNER JOIN(SELECT c.EventKey
					FROM(SELECT MAX(EventKey) MAXEventKey
						FROM [dbo].[EventDimCAH]
						WHERE [CHPH_AAP_ID] = @p1
						) AS dt
					CROSS APPLY dbo.EventDimCAH AS c 
					WHERE c.CHPH_AAP_ID = @p1
					AND c.EventKey < dt.MAXEventKey
					) AS dt ON x.EventKey = dt.EventKey



	FETCH NEXT 
	FROM C1
	INTO @p1

	END

	CLOSE C1
	DEALLOCATE C1

END
GO
