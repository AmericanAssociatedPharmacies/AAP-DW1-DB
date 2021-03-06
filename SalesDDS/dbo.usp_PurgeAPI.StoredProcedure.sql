USE [SalesDDS]
GO
/****** Object:  StoredProcedure [dbo].[usp_PurgeAPI]    Script Date: 12/22/2020 7:55:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_PurgeAPI]

AS

SET NOCOUNT ON;

BEGIN


DECLARE @p1 INT

DECLARE C1 CURSOR FOR
SELECT DISTINCT DateKey
FROM [dbo].[SalesFact_API]
WHERE DateKey < 20170101
ORDER BY DateKey DESC

OPEN C1

FETCH NEXT
FROM C1
INTO @p1

WHILE @@FETCH_STATUS = 0
BEGIN

	DELETE x
	FROM [dbo].[SalesFact_API] AS x
	WHERE DateKey = @p1

	DELETE x
	FROM [dbo].[RebateFact_API] AS x
	WHERE DateKey = @p1


	DELETE x
	FROM [dbo].[EventDimAPI] AS x
	WHERE DateKey = @p1

	FETCH NEXT
	FROM C1
	INTO @p1

END

CLOSE C1
DEALLOCATE C1

END
GO
