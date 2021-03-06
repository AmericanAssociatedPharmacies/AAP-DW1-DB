USE [ODSIntake]
GO
/****** Object:  StoredProcedure [dbo].[uspSQLJobETL_WeeklyCount]    Script Date: 12/22/2020 7:30:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[uspSQLJobETL_WeeklyCount]

AS

SET NOCOUNT ON;

BEGIN

		DECLARE @RowCount INT
	, @StartDate DATETIME
	, @EndDate DATETIME
		
	--Unless date parameters are passed in, this sproc will execute for the current date and set the datetime values from Sunday to Saturday.
	SET @StartDate = ISNULL(@StartDate, DATEADD(wk, DATEDIFF(wk, 7, CURRENT_TIMESTAMP), 7))
	SET @EndDate = ISNULL(@EndDate, DATEADD(wk, DATEDIFF(wk, 6, CURRENT_TIMESTAMP), 6 + 7))

	--Get rowcount
	SELECT @RowCount =  COUNT(*)
	FROM [dbo].[SQLJobHistory]
	WHERE RunDateTime >= @StartDate
	AND RunDateTime < @EndDate
	AND [IsError] = 1

	SELECT @RowCount

END
GO
