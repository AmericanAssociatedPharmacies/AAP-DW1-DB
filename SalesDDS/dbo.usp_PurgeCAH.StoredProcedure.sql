USE [SalesDDS]
GO
/****** Object:  StoredProcedure [dbo].[usp_PurgeCAH]    Script Date: 12/22/2020 7:55:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_PurgeCAH]

AS

SET NOCOUNT ON;

BEGIN


DECLARE @p1 INT

DECLARE C1 CURSOR FOR
SELECT DISTINCT DateKey
FROM [dbo].[SalesFact_CAH]
WHERE DateKey < 20170101
ORDER BY DateKey DESC

OPEN C1

FETCH NEXT
FROM C1
INTO @p1

WHILE @@FETCH_STATUS = 0
BEGIN

	DELETE x
	FROM [dbo].[SalesFact_CAH] AS x
	WHERE DateKey = @p1

	DELETE x
	FROM [dbo].[EventDimCAH] AS x
	WHERE DateKey = @p1

	FETCH NEXT
	FROM C1
	INTO @p1

END

CLOSE C1
DEALLOCATE C1

END
GO
