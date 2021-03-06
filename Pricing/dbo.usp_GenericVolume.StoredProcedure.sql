USE [Pricing]
GO
/****** Object:  StoredProcedure [dbo].[usp_GenericVolume]    Script Date: 12/22/2020 7:32:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[usp_GenericVolume]

AS

SET NOCOUNT ON;
         
BEGIN
             
	SELECT dt.InvDate
	, dt.IsWeekday
	, dt.Year
	, dt.MonthName
	, dt.DayOfMonth
	, SUM(dt.Qty) AS TotalUnits
	FROM(SELECT sd.NDC
		, sd.Qty
		, sd.InvDate
		, dd.DrugType
		, da.IsWeekday
		, da.Year
		, da.MonthName
		, da.DayOfMonth
		FROM [API].[dbo].[APISalesDetail] AS sd
		JOIN dbo.DrugDim AS dd ON dd.NDC = sd.NDC
		JOIN dbo.DateDim AS da ON sd.InvDate = da.TheDate
		WHERE sd.InvDate >= '20160101'
		  AND sd.Type = 'Generic'
	) AS dt
	GROUP BY dt.InvDate
			, dt.IsWeekday
			, dt.Year
			, dt.MonthName
			, dt.DayOfMonth
			;
END;



GO
