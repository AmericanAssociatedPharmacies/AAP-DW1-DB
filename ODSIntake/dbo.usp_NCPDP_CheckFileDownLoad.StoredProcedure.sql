USE [ODSIntake]
GO
/****** Object:  StoredProcedure [dbo].[usp_NCPDP_CheckFileDownLoad]    Script Date: 12/22/2020 7:30:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO











CREATE PROCEDURE [dbo].[usp_NCPDP_CheckFileDownLoad]

AS

SET NOCOUNT ON;

BEGIN

	DECLARE @FileDir VARCHAR(500)
	, @RowCount INT

	SET @FileDir = '\\fs1.aap.local\server\IT Department\NCPDP\Staging'

		--Get rowcount for files
	SELECT @RowCount = COUNT(*)
	FROM [dbo].[mtvf_GetFileInfo](@FileDir)
	WHERE FileName LIKE '%.zip'

	IF @RowCount = 0
	BEGIN

		--Stop SQL Job is no files were downloaded
		EXEC msdb.dbo.sp_stop_job
			@job_name = 'NCPDPODS ETL'

		--Send email to advise files were not available for download
		EXEC msdb.dbo.sp_send_dbmail  
			@recipients = 'dave.bohler@rxaap.com; scott.edwards@rxaap.com; tracie.heyrman@rxaap.com; yodi.haile@rxaap.com'
			, @body = 'No NCPDP Files exist'
			, @subject = 'No NCPDP Files exist' 		
			, @importance = 'High';

	END

	ELSE

		RETURN


END

GO
