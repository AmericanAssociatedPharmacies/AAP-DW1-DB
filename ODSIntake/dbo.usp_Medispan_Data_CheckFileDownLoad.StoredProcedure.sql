USE [ODSIntake]
GO
/****** Object:  StoredProcedure [dbo].[usp_Medispan_Data_CheckFileDownLoad]    Script Date: 12/22/2020 7:30:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO









CREATE PROCEDURE [dbo].[usp_Medispan_Data_CheckFileDownLoad]

AS

SET NOCOUNT ON;

BEGIN

	DECLARE @FileDir VARCHAR(500)
	, @RowCount INT

	SET @FileDir = '\\fs1\Server\IT Department\Medispan\FTPDownload\Data'


	--Get rowcount for files
	SELECT COUNT(*)
	FROM [dbo].[mtvf_GetFileInfo](@FileDir)
	WHERE FileName LIKE '%.zip'
	AND FileName LIKE 'med%'

	IF @RowCount = 0
	BEGIN

		--Stop SQL Job is no files were downloaded
		EXEC msdb.dbo.sp_stop_job
			@job_name = 'Medispan Data File ETL'

		--Send email to advise files were not available for download
		EXEC msdb.dbo.sp_send_dbmail  
			@recipients = 'DataServices@rxaap.com'
			, @body = 'No Medispan Data File exist'
			, @subject = 'No Medispan Data File exist' 		
			, @importance = 'High'

	END

	ELSE

		RETURN


END






GO
