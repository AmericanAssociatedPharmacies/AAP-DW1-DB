USE [SalesDDS]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_APIBusinessDays]    Script Date: 12/22/2020 7:55:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[fn_APIBusinessDays](@StartDate DATETIME, @EndDate DATETIME)
RETURNS INT

AS


BEGIN

	DECLARE @APIBizDays INT

	DECLARE @T TABLE (C1 INT)

	--Get a sequential number by date span
	INSERT @T(C1)
	SELECT ROW_NUMBER() OVER(ORDER BY dt.TheDate ASC) AS RN
	FROM(SELECT TheDate
			FROM SalesDDS.dbo.DateDim
			WHERE TheDate BETWEEN @StartDate AND @EndDate
			AND IsAPIHoliday = 0
			AND IsWeekDay = 1
		) AS dt
	
	--Count all days, including the 1st and last day
	SELECT @APIBizDays = (dt.C2 - dt.C1) + 1
	FROM(SELECT MIN(C1) AS C1
			, MAX(C1) AS C2
			FROM @T
		) AS dt

	RETURN(@APIBizDays);


END
GO
