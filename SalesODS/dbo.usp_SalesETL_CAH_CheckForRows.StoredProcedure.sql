USE [SalesODS]
GO
/****** Object:  StoredProcedure [dbo].[usp_SalesETL_CAH_CheckForRows]    Script Date: 12/22/2020 7:58:50 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[usp_SalesETL_CAH_CheckForRows]


AS

SET NOCOUNT ON

BEGIN

	DECLARE @RowCount INT
	
	SELECT @RowCount = COUNT(*)
	FROM [dbo].[CHPH_AAP_DateKey_RowversionID]

	IF @RowCount = 0
	BEGIN

			--Send email notification
			EXEC msdb.dbo.sp_send_dbmail  
			 @recipients = 'scott.edwards@rxaap.com; yodi.haile@rxaap.com;'
			 , @body = 'No rows are ready to load. Please contact the Help Desk. Stopping the DW CAH Sales ETL SQL Job.'
			 , @subject = 'DW CAH Sales ETL' 		
			 , @importance = 'High'

			 --Stop this SQL Job
			EXEC msdb.dbo.sp_stop_job N'DW CAH Sales ETL'


		END

	ELSE IF @RowCount > 0
	BEGIN

		RETURN

	END
		

END




GO
