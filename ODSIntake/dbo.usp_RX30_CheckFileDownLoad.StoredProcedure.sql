USE [ODSIntake]
GO
/****** Object:  StoredProcedure [dbo].[usp_RX30_CheckFileDownLoad]    Script Date: 12/22/2020 7:30:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO









CREATE PROCEDURE [dbo].[usp_RX30_CheckFileDownLoad]

AS

SET NOCOUNT ON;

BEGIN

	DECLARE @FileDir VARCHAR(500)
	, @RowCount INT

	SET @FileDir = '\\fs1.aap.local\Server\IT Department\RX30\Staging'

		--Get rowcount for files
	SELECT @RowCount = COUNT(*)
	FROM [dbo].[mtvf_GetFileInfo](@FileDir)
	WHERE FileName LIKE '%.gz'

	IF @RowCount = 0
	BEGIN

		--Stop SQL Job is no files were downloaded
		EXEC msdb.dbo.sp_stop_job
			@job_name = 'ClaimsDDS RX30 Data Load'

		--Send email to advise files were not available for download
		EXEC msdb.dbo.sp_send_dbmail  
			@recipients = 'dave.bohler@rxaap.com; scott.edwards@rxaap.com; yodi.haile@rxaap.com'
			, @body = 'No RX30 Files exist'
			, @subject = 'No RX30 Files exist' 		
			, @importance = 'High';

	END

	ELSE

		RETURN


END


GO
