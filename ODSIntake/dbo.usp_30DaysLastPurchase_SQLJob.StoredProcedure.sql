USE [ODSIntake]
GO
/****** Object:  StoredProcedure [dbo].[usp_30DaysLastPurchase_SQLJob]    Script Date: 12/22/2020 7:30:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[usp_30DaysLastPurchase_SQLJob]

AS

SET NOCOUNT ON;

BEGIN

/*
 
       Per email from Emily, email report on 2nd business day of the month. The SQL code below will determine if the current day is the 2nd business day of the month.
       If not, the SQL Job will stop executing.
 
*/
 
 
	DECLARE @BOM DATE
	, @EOM DATE
	, @2ndDay DATE
 
	SET @BOM = DATEADD(DAY,1,EOMONTH(GETDATE(),-1))
	SET @EOM = DATEADD(DAY, 1, EOMONTH (GETDATE()))
 
	SELECT @2ndDay = dt.TheDate
	FROM(SELECT ROW_NUMBER() OVER(ORDER BY TheDate ASC) AS RN
		   , TheDate
		   FROM SalesDDS.dbo.DateDim
		   WHERE TheDate >= @BOM
		   AND TheDate < @EOM
		   AND IsWeekDay = 1
		   AND IsAPIHoliday = 0
	) AS dt
	WHERE RN = 2
 
	IF CONVERT(DATE, GETDATE()) = @2ndDay
 
	BEGIN
 
		RETURN 
		    
	END 
 
	ELSE

		EXEC msdb.dbo.sp_stop_job '30 Days Since Last Purchase'
 
		   
END


GO
