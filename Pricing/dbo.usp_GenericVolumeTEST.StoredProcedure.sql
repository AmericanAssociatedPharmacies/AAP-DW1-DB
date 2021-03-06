USE [Pricing]
GO
/****** Object:  StoredProcedure [dbo].[usp_GenericVolumeTEST]    Script Date: 12/22/2020 7:32:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_GenericVolumeTEST]
AS
     SET NOCOUNT ON;
         BEGIN
             SELECT dt.Mnth
                  , dt.Yr
                  , dt.InvDate
                  , dt.DailyTotal
                  , dt.RunnningTotal
                  , COUNT(SUM(dt.DailyTotal)) OVER(PARTITION BY dt.Mnth
                                                              , dt.Yr ORDER BY dt.InvDate) AS BizDay
             FROM
(
    SELECT MONTH(sd.InvDate) AS Mnth
         , YEAR(sd.InvDate) AS Yr
         , sd.InvDate
         , SUM(sd.Qty) AS DailyTotal
         , SUM(SUM(sd.Qty)) OVER(PARTITION BY MONTH(sd.InvDate)
                                            , YEAR(sd.InvDate) ORDER BY sd.InvDate) AS RunnningTotal
    FROM API.dbo.APISalesDetail AS sd
    GROUP BY MONTH(sd.InvDate)
           , YEAR(sd.Invdate)
           , sd.InvDate
) AS dt
             GROUP BY dt.Mnth
                    , dt.Yr
                    , dt.InvDate
                    , dt.DailyTotal
                    , dt.RunnningTotal
             ORDER BY dt.InvDate;
         END;
GO
