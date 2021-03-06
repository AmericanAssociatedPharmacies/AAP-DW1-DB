USE [SalesDDS]
GO
/****** Object:  StoredProcedure [dbo].[usp_SalesETL_CAH_CheckForRows]    Script Date: 12/22/2020 7:55:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[usp_SalesETL_CAH_CheckForRows]

AS

SET NOCOUNT ON

BEGIN

	DECLARE @ID1 INT
	, @RowCount INT
	, @ID2 INT


	SELECT @ID1 = MAX(CHPH_AAP_ID)
	FROM SalesDDS.[dbo].[EventDimCAH]

	SELECT @ID2 = MAX(ID)
	FROM Purchases.dbo.CHPH_AAP

	SELECT @RowCount = CASE 
					   WHEN @ID2 > @ID1 THEN 1
					   ELSE 0
					   END

	SELECT @RowCount 

	IF @RowCount = 0
		BEGIN

			--Send email notification
			EXEC msdb.dbo.sp_send_dbmail  
			 @recipients = 'scott.edwards@rxaap.com; syreeta.sarpong@rxaap.com; dave.bohler@rxaap.com'
			 , @body = 'No rows are ready to load. Stopping the DW CAH Sales ETL SQL Job.'
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
