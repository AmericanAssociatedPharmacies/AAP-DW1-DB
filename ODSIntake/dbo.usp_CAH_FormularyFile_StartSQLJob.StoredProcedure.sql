USE [ODSIntake]
GO
/****** Object:  StoredProcedure [dbo].[usp_CAH_FormularyFile_StartSQLJob]    Script Date: 12/22/2020 7:30:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO








CREATE PROCEDURE [dbo].[usp_CAH_FormularyFile_StartSQLJob]

	@FileDir VARCHAR(1000) = '\\fs1.aap.local\Server\IT Department\Cardinal\FormularyFiles'

AS

SET NOCOUNT ON;

BEGIN

	DECLARE @DW INT
	, @RowCount INT
	, @Today DATETIME

	SET @Today = DATEADD(DAY, 0, DATEDIFF(DAY, 0, GETDATE()))

	--Get rowcount for files
	SELECT @RowCount = COUNT(*)
	FROM [dbo].[mtvf_GetFileInfo](@FileDir)
	WHERE FileCreateTime >= @Today

	-- Get day of week
	SELECT @DW = dt.DW
	FROM(SELECT CONVERT(INT, DATEPART(dw, GETDATE())) AS DW
		) AS dt

	--If DW is Monday and files do not exists, send email for notification and exit sproc
	IF (@RowCount = 0
		AND @DW = 2
		)
		BEGIN

			--Send email to advise Formulary Files have not been downloaded
			EXEC msdb.dbo.sp_send_dbmail  
			 @recipients = 'dave.bohler@rxaap.com; scott.edwards@rxaap.com; syreeta.sarpong@rxaap.com; yodi.haile@rxaap.com; lovie.moultrie@rxaap.com'
			 , @body = 'No CAH Forumlary Files exist'
			 , @subject = 'No CAH Forumlary Files exist' 		
			 , @importance = 'High'	
			
			--Exit sproc
			RETURN

		END


	IF @DW = 2
		AND @RowCount > 0
		BEGIN

		EXEC msdb.dbo.sp_start_job
			@job_name = 'CAH Formulary File Data Load'

		END

	--If day of week is any other day than Monday, start SQL Job at specific step
	IF @DW > 2
		
		BEGIN

			EXEC msdb.dbo.sp_start_job
				@job_name = 'CAH Formulary File Data Load'
				, @step_name = 'Load Staging Top Generics on Pricing db'
				

		END

END





GO
