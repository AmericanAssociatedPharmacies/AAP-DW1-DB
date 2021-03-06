USE [SalesDDS]
GO
/****** Object:  StoredProcedure [dbo].[usp_API_PMID_Cursor]    Script Date: 12/22/2020 7:55:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[usp_API_PMID_Cursor]

AS

SET NOCOUNT ON;

BEGIN


DECLARE @DateKeyCursor INT


	DECLARE C1 CURSOR FOR
	SELECT DISTINCT DateKey
	FROM dbo.SalesFact_API
	--WHERE DateKey BETWEEN 20190101 AND 20191121
	ORDER BY DateKey DESC

	OPEN C1

	FETCH NEXT
	FROM C1
	INTO @DateKeyCursor

	WHILE @@FETCH_STATUS = 0
	BEGIN


		UPDATE x
		SET StartDate = GETDATE()
		FROM dbo.APIPMID_Loop AS x
		WHERE DateKey = @DateKeyCursor

		EXEC dbo.usp_API_MapPMID
			@Datekey = @DateKeyCursor

		UPDATE x
		SET EndDate = GETDATE()
		FROM dbo.APIPMID_Loop AS x
		WHERE DateKey = @DateKeyCursor

		--UPDATE STATISTICS [dbo].[SalesFact_API]

		--CHECKPOINT

		--DBCC SHRINKFILE(2,10)

		--UPDATE s
		--SET PharmacyKey = ISNULL(pd.PharmacyKey,0)
		--FROM [dbo].[SalesFact_API] AS s
		--INNER JOIN dbo.EventDimAPI AS a	ON s.[APIEventKey] = a.EventKey
		--LEFT OUTER JOIN dbo.PharmacyDim AS pd ON a.[AccountNumber] = APINumber
		--												AND s.DateKey BETWEEN pd.APIEffectiveDateKey AND pd.APIQuitDateKey
		--WHERE s.Datekey = @DateKey


		--UPDATE a
		--SET PMID = pd.PMID
		--FROM dbo.EventDimAPI AS a	
		--INNER JOIN[dbo].[SalesFact_API] AS s ON s.[APIEventKey] = a.EventKey
		--INNER JOIN dbo.PharmacyDim AS pd ON pd.PharmacyKey = s.PharmacyKey												
		--WHERE s.Datekey = @DateKey


		--UPDATE r
		--SET PharmacyKey = s.PharmacyKey
		--FROM [dbo].[RebateFact_API] AS r
		--INNER JOIN dbo.SalesFact_API AS s ON s.[APIEventKey] = r.[APIEventKey]
		--WHERE s.Datekey = @DateKey

		FETCH NEXT
		FROM C1
		INTO @DateKeyCursor

	END

	CLOSE C1
	DEALLOCATE C1

END
GO
