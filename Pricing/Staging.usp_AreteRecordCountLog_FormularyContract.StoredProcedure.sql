USE [Pricing]
GO
/****** Object:  StoredProcedure [Staging].[usp_AreteRecordCountLog_FormularyContract]    Script Date: 12/22/2020 7:32:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






CREATE PROCEDURE [Staging].[usp_AreteRecordCountLog_FormularyContract]

AS

SET NOCOUNT ON;

BEGIN

	DECLARE @RowCount INT

	--Get rowcount from [Staging].[APIOrder]
	SELECT @RowCount = TotalCount
	FROM Pricing.dbo.Arete_FormularyContractRecordCountLog
	
	IF @RowCount = 0
	BEGIN
		--Send email to advise files were not available for download
		EXEC msdb.dbo.sp_send_dbmail  
			@recipients = 'scott.edwards@rxaap.com; yodi.haile@rxaap.com; lovie.moultrie@rxaap.com'
			, @body = 'No Arete_FormularyContract weekly record exists.'
			, @subject = 'No Arete_FormularyContract weekly record exists' 		
			, @importance = 'High'

		--Stop SQL Job is no files were downloaded
		EXEC msdb.dbo.sp_stop_job
			@job_name = 'Arete Formulary Pricing and Formulary Contract Weekly Load'

	END

	ELSE

		RETURN


END



GO
