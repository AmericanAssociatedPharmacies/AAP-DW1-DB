USE [ClaimsDDS]
GO
/****** Object:  StoredProcedure [dbo].[usp_FDS_DeletePre201701]    Script Date: 12/22/2020 6:54:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_FDS_DeletePre201701]

	@Datekey INT


AS

SET NOCOUNT ON;

BEGIN
BEGIN TRY

	TRUNCATE TABLE dbo.EventDelete20191029

	BEGIN TRAN

	DELETE x
	OUTPUT DELETED.EventKey
	INTO dbo.EventDelete20191029(EventKey)
	FROM [dbo].[ClaimFactFDS] AS x
	WHERE x.DateofServiceKey = @DateKey

	DELETE x
	FROM [dbo].[EventDimFDS] AS x
	INNER JOIN dbo.EventDelete20191029 AS t ON x.EventKey = t.EventKey

	UPDATE x
	SET [CompletedDate] = GETDATE()
	FROM dbo.FDS_Pre20170101Loop AS x
	WHERE DateKey = @DateKey

	COMMIT TRAN

	CHECKPOINT

	DBCC SHRINKFILE(2,10) WITH NO_INFOMSGS


END TRY
BEGIN CATCH

	ROLLBACK TRAN
	

END CATCH

END
GO
