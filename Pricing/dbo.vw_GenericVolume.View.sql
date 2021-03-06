USE [Pricing]
GO
/****** Object:  View [dbo].[vw_GenericVolume]    Script Date: 12/22/2020 7:32:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vw_GenericVolume]
AS
     SELECT dt.InvDate,
            dt.IsWeekday,
            dt.Year,
            dt.MonthName,
            dt.DayOfMonth,
            SUM(dt.Qty) AS TotalUnits
     FROM
(
    SELECT sd.NDC,
           sd.Qty,
           sd.InvDate,
           dd.DrugType,
           da.IsWeekday,
           da.Year,
           da.MonthName,
           da.DayOfMonth
    FROM [API].[dbo].[APISalesDetail] AS sd
         JOIN dbo.DrugDim AS dd ON dd.NDC = sd.NDC
         JOIN dbo.DateDim AS da ON sd.InvDate = da.TheDate
    WHERE sd.InvDate >= '2016-01-01'
          AND dd.DrugType = 'MULTI-SOURCE GENERIC'
) AS dt
     GROUP BY dt.InvDate,
              dt.IsWeekday,
              dt.Year,
              dt.MonthName,
              dt.DayOfMonth;
        


GO
