USE [ODSIntake]
GO
/****** Object:  StoredProcedure [dbo].[usp_APICatalog_CheckForFiles]    Script Date: 12/22/2020 7:30:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




----S:\IT Department\API\Test

--SET @FileDir = '\\fs1\Server\IT Department\API\Test'


CREATE PROCEDURE [dbo].[usp_APICatalog_CheckForFiles]

	@FileDir VARCHAR(1000)

AS

SET NOCOUNT ON

BEGIN

	DECLARE @FileCount INT

	SELECT @FileCount = COUNT(*)
	FROM [dbo].[mtvf_GetFileInfo](@FileDir)

	SELECT @FileCount

	IF @FileCount = 0
		BEGIN

			--Send email notification
			EXEC msdb.dbo.sp_send_dbmail  
			 @recipients = 'scott.edwards@rxaap.com; yodi.haile@rxaap.com'
			 , @body = 'No API Catalog files were downloaded. Please contact the Help Desk. Stopping the API Catalog ETL SQL Job.'
			 , @subject = 'No API Catalog Files exist' 		
			 , @importance = 'High'

			 --Stop this SQL Job
			EXEC msdb.dbo.sp_stop_job N'API Catalog ETL'


		END

	ELSE IF @FileCount > 0
	BEGIN

		RETURN

	END
		

END
GO
