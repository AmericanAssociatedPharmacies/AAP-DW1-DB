USE [ODSIntake]
GO
/****** Object:  StoredProcedure [dbo].[usp_SalesETL_API_CheckForRows]    Script Date: 12/22/2020 7:30:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO








CREATE PROCEDURE [dbo].[usp_SalesETL_API_CheckForRows]

AS

SET NOCOUNT ON

BEGIN

	DECLARE @RowCount INT
	, @Date VARCHAR(10)
	, @p1 VARCHAR(1000)

	SELECT @RowCount = COUNT(*)
	FROM SalesDDS.Staging.API

	SELECT @Date = CONVERT(VARCHAR(10), FORMAT(MAX(InvoiceDate), 'MM/dd/yyyy', 'en-US'))
	FROM SalesDDS.dbo.EventDimAPI
	
	SET @p1 = 'No rows are ready to load. Please contact the Data Team. Stopping the DW API Sales ETL SQL Job.' + '' + @Date + '  is the max invoice date currently loaded.'

	IF @RowCount = 0
	BEGIN

		--Send email notification
		EXEC msdb.dbo.sp_send_dbmail  
			@recipients = 'dataservices@rxaap.com'
			, @body = @p1
			, @subject = 'DW API Sales ETL' 		
			, @importance = 'High'

			--Stop this SQL Job
		EXEC msdb.dbo.sp_stop_job N'DW API Sales ETL'


	END

	ELSE IF @RowCount > 0
	BEGIN

		RETURN

	END
		

END






GO
