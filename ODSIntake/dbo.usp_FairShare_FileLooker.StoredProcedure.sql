USE [ODSIntake]
GO
/****** Object:  StoredProcedure [dbo].[usp_FairShare_FileLooker]    Script Date: 12/22/2020 7:30:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[usp_FairShare_FileLooker]

	@FileDir VARCHAR(500)

AS

SET NOCOUNT ON

BEGIN

	DECLARE @RowCount INT
	, @varFileName VARCHAR(250)
	, @Date DATETIME

	SET @Date = GETDATE()

	--Get row count for all files to be processed
	SELECT @RowCount = COUNT(*)
	FROM [dbo].[mtvf_GetFileInfo](@FileDir)
	WHERE FileName LIKE '%.csv'
	
	----Get concantenated list of all files to be processed
	--SELECT @varFileName = ISNULL(@varFileName + ',', '') + FileName
	--FROM [dbo].[mtvf_GetFileInfo](@FileDir)
	--WHERE FileName LIKE '%.csv'
	
	--If @RowCount >= 1, log file and process. If not, log file not found only.
	IF @RowCount >= 1 
	BEGIN

		--Send email notification
		EXEC msdb.dbo.sp_send_dbmail  
		@recipients = 'leeann.carrell@rxaap.com; scott.edwards@rxaap.com; syreeta.sarpong@rxaap.com; dorek.biglari@rxaap.com'
		, @body = 'Fair Share file is being loaded.'
		, @subject = 'Fair Share File' 	
			
	END

	ELSE IF @RowCount = 0
	BEGIN	

		--Log no files found
		EXEC [dbo].[usp_FileLog]	
		@FileName = 'No file found'
		, @Process = 'FairShare'
		, @FileDownloadDateTime = '19000101'
		, @IsRawFileLoaded = 0

		--Stop this SQL Job
		EXEC msdb.dbo.sp_stop_job N'Fair Share ETL'

	END
		

END



GO
