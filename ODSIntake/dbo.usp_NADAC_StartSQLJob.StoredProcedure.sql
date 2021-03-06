USE [ODSIntake]
GO
/****** Object:  StoredProcedure [dbo].[usp_NADAC_StartSQLJob]    Script Date: 12/22/2020 7:30:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







CREATE PROCEDURE [dbo].[usp_NADAC_StartSQLJob]

AS

SET NOCOUNT ON;

BEGIN

	DECLARE @DW INT
	, @RowCount INT

	-- If day of week is Monday, run SQL Job from Step 1
	SELECT @DW = dt.DW
	FROM(SELECT CONVERT(INT, DATEPART(dw, GETDATE())) AS DW
		) AS dt

	IF @DW = 4
		BEGIN

		EXEC msdb.dbo.sp_start_job
			@job_name = 'NADAC ETL'

		END

	--If day of week is any other day than Monday, start SQL Job at specific step
	ELSE IF @DW <> 4

		BEGIN

			EXEC msdb.dbo.sp_start_job
				@job_name = 'NADAC ETL'
				, @step_name = 'Load NADAC into PriceFact table'

		END

END





GO
