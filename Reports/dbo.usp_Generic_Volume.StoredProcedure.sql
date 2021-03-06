USE [Reports]
GO
/****** Object:  StoredProcedure [dbo].[usp_Generic_Volume]    Script Date: 12/22/2020 7:39:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_Generic_Volume] @StartDate DATETIME
AS
     SET NOCOUNT ON;
         BEGIN
             DECLARE @d1 DATETIME, @d2 DATETIME, @1stDayOf1stYear DATETIME, @BizDay INT; 
 
 
--Offset the date by 1 day if current date is chosen
             SET @d1 = CASE
                           WHEN @StartDate = DATEADD(DAY, 0, DATEDIFF(DAY, 0, GETDATE()))
                           THEN DATEDIFF(DD, -1, @StartDate)
                           ELSE @StartDate
                       END;
 
--1st day of the current year
             SET @d2 = DATEADD(yy, DATEDIFF(yy, 0, @d1), 0);
 
--Get Jan 1st of 2 yrs back based on @StartDate value
             SET @1stDayOf1stYear = DATEADD(yy, DATEDIFF(yy, 0, @StartDate) - 2, 0);
             SELECT @Bizday = SalesDDS.dbo.fn_APIBusinessDays(@d2, @d1);
--Result Set
             SELECT dt.Mnth
                  , dt.Yr
                  , dt.InvDate
                  , dt.DailyTotal
                  , dt.RunnningTotal
                  , dt.BizDay
                  , dt.DailySales
                  , dt.RunnningTotalSales
             FROM
(
    SELECT dt.Mnth
         , dt.Yr
         , dt.InvDate
         , dt.DailyTotal
         , dt.RunnningTotal
         , dt.DailySales
         , dt.RunnningTotalSales
         , SalesDDS.dbo.fn_APIBusinessDays(DATEADD(yy, DATEDIFF(yy, 0, dt.InvDate), 0), dt.InvDate) AS BizDay
    FROM
(
    SELECT MONTH(sd.InvDate) AS Mnth
         , YEAR(sd.InvDate) AS Yr
         , sd.InvDate
         , SUM(sd.ExtSales) AS DailySales
         , SUM(SUM(sd.ExtSales)) OVER(PARTITION BY YEAR(sd.InvDate) ORDER BY sd.InvDate) AS RunnningTotalSales
         , SUM(sd.Qty) AS DailyTotal
         , SUM(SUM(sd.Qty)) OVER(PARTITION BY YEAR(sd.InvDate) ORDER BY sd.InvDate) AS RunnningTotal
    FROM API.dbo.APISalesDetail AS sd
    WHERE sd.Type = 'Generic'
          AND sd.ExtSales > 0
    GROUP BY MONTH(sd.InvDate)
           , YEAR(sd.InvDate)
           , sd.InvDate
) AS dt
    GROUP BY dt.Mnth
           , dt.Yr
           , dt.InvDate
           , dt.DailyTotal
           , dt.RunnningTotal
           , dt.DailySales
           , dt.RunnningTotalSales
) AS dt
             WHERE dt.BizDay = @BizDay
                   AND dt.InvDate >= @1stDayOf1stYear;
         END;
GO
