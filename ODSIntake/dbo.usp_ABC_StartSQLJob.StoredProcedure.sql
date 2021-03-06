USE [ODSIntake]
GO
/****** Object:  StoredProcedure [dbo].[usp_ABC_StartSQLJob]    Script Date: 12/22/2020 7:30:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[usp_ABC_StartSQLJob]

AS

SET NOCOUNT ON;

BEGIN

	DECLARE @DW INT
	, @RowCount INT

	-- If day of week is Monday, run SQL Job from Step 1
	SELECT @DW = dt.DW
	FROM(SELECT CONVERT(INT, DATEPART(dw, GETDATE())) AS DW
		) AS dt

	IF @DW = 2
		BEGIN

		EXEC msdb.dbo.sp_start_job
			@job_name = 'ABC Data Load for Pricing'

		END

	--If day of week is any other day than Monday, start SQL Job at specific step
	ELSE

		BEGIN

			EXEC msdb.dbo.sp_start_job
				@job_name = 'ABC Data Load for Pricing'
				, @step_name = 'Truncate table StagingABC in Pricing db'

		END

END



GO
