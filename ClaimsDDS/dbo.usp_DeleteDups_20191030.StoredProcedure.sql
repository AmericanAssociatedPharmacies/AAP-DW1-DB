USE [ClaimsDDS]
GO
/****** Object:  StoredProcedure [dbo].[usp_DeleteDups_20191030]    Script Date: 12/22/2020 6:54:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_DeleteDups_20191030]

AS

SET NOCOUNT ON;

BEGIN
BEGIN TRY

DECLARE @RN INT

SET @RN = 0

WHILE EXISTS(SELECT 1
				FROM [dbo].[FDSDups_20191023]
				WHERE IsDeleted = 0
				--AND RN <= 100000
				)
	BEGIN

			IF OBJECT_ID('tempdb..#foo') IS NOT NULL
			DROP TABLE #foo
	
			CREATE TABLE #foo(RowID INT NOT NULL
							, EventKey INT NOT NULL
							, PRIMARY KEY CLUSTERED(RowID,EventKey)
							)
	
			INSERT INTO #foo(RowID, EventKey)
			SELECT TOP 500000 RowID, EventKey
			FROM [dbo].[FDSDups_20191023]
			WHERE IsDeleted = 0
			--AND RN > @RN	
			ORDER BY RowID ASC


			DELETE x
			FROM [dbo].[ClaimFactFDS] AS x
			INNER JOIN #foo AS f ON x.EventKey = f.EventKey
	

			DELETE x
			FROM [dbo].[EventDimFDS] AS x
			INNER JOIN #foo AS f ON x.EventKey = f.EventKey

	
			UPDATE x
			SET IsDeleted = 1
			FROM [dbo].[FDSDups_20191023] AS x
			INNER JOIN #foo AS f ON x.RowID = f.RowID

			--SET @RN = @RN + 1

			DBCC SHRINKFILE(2,10) WITH NO_INFOMSGS
	END

END TRY
BEGIN CATCH

	SELECT 'There is an Error'


END CATCH


END
GO
