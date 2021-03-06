USE [API]
GO
/****** Object:  StoredProcedure [Staging].[usp_AreteRecordCountLog]    Script Date: 12/22/2020 6:09:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE PROCEDURE [Staging].[usp_AreteRecordCountLog]

AS

SET NOCOUNT ON;

BEGIN

	DECLARE @RowCount INT

	--Get rowcount from [Staging].[APIOrder]
	SELECT @RowCount = TotalCount
	FROM API.dbo.AreteRecordCountLog
	
	IF @RowCount = 0
	BEGIN
		--Send email to advise files were not available for download
		EXEC msdb.dbo.sp_send_dbmail  
			@recipients = 'scott.edwards@rxaap.com; yodi.haile@rxaap.com; lovie.moultrie@rxaap.com'
			, @body = 'No AreteInvoiceData daily record exists.'
			, @subject = 'No AreteInvoiceData daily record exists' 		
			, @importance = 'High'

		--Stop SQL Job is no files were downloaded
		EXEC msdb.dbo.sp_stop_job
			@job_name = 'Arete InvoiceData ETL'

	END

	ELSE

		RETURN


END



GO
