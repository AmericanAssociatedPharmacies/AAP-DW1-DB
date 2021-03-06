USE [Pricing]
GO
/****** Object:  View [dbo].[vw_DateDimensionWeekdayOnly]    Script Date: 12/22/2020 7:32:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vw_DateDimensionWeekdayOnly]

AS


SELECT DateKey, TheDate, DayOfMonth, DayOfYear, DayOfWeek, DayName, WeekOfYear, WeekName, MonthOfYear, MonthName, Quarter, QuarterName, Year, IsWeekday, DayOfQuarter
FROM dbo.DateDim
WHERE IsWeekday = 1
GO
