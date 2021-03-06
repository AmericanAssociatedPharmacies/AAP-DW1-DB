USE [Reports]
GO
/****** Object:  UserDefinedFunction [dbo].[WeekDayCount]    Script Date: 12/22/2020 7:39:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[WeekDayCount]
        (@pStartDate DATETIME, @pEndDate DATETIME)
RETURNS TABLE WITH SCHEMABINDING AS
 RETURN
 SELECT WeekDayCount =
        (DATEDIFF(dd,d.StartDate,d.EndDate)+1) --Start with total number of days including weekends
      - (DATEDIFF(wk,d.StartDate,d.EndDate)*2) --Subtact 2 days for each full weekend
      - (1-SIGN(DATEDIFF(dd,6,d.StartDate)%7)) --If StartDate is a Sunday, Subtract 1
      - (1-SIGN(DATEDIFF(dd,5,d.EndDate)  %7)) --If EndDate is a Saturday, Subtract 1
   FROM ( --=== Make sure the dates are in the correct order
         SELECT StartDate = CASE WHEN @pStartDate <= @pEndDate THEN @pStartDate ELSE @pEndDate   END
         ,      EndDate   = CASE WHEN @pStartDate <= @pEndDate THEN @pEndDate   ELSE @pStartDate END
        )d
;
GO
