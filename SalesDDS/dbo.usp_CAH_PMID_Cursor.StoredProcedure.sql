USE [SalesDDS]
GO
/****** Object:  StoredProcedure [dbo].[usp_CAH_PMID_Cursor]    Script Date: 12/22/2020 7:55:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_CAH_PMID_Cursor]

AS

SET NOCOUNT ON;

BEGIN



DECLARE @p1 INT


DECLARE C1 CURSOR FOR
SELECT DISTINCT DateKey
FROM [dbo].[SalesFact_CAH]
WHERE DateKey < 20191113
ORDER BY DateKey DESC

OPEN C1

FETCH NEXT
FROM C1
INTO @p1

WHILE @@FETCH_STATUS = 0
BEGIN


	UPDATE x
	SET StartDate = GETDATE()
	FROM dbo.CAHPMID_Loop AS x
	WHERE DateKey = @p1


	EXEC dbo.usp_CAH_MapPMID
		@DateKey = @p1

	UPDATE x
	SET EndDate = GETDATE()
	FROM dbo.CAHPMID_Loop AS x
	WHERE DateKey = @p1

	
	FETCH NEXT
	FROM C1
	INTO @p1

END

CLOSE C1
DEALLOCATE C1


END
GO
