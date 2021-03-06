USE [ReportsTest]
GO
/****** Object:  StoredProcedure [test].[usp_sisense_WC3_Sales]    Script Date: 12/22/2020 7:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [test].[usp_sisense_WC3_Sales]
AS
     DECLARE @QTYRate FLOAT;
     SET @QTYRate = -0.20;
     SELECT d7.APIAccountNum
          , d7.WoY
          , d7.Yr
          , d7.RunningTotal
          , d7.PreviousWeek
          , d7.Delta
          , d7.PreviousDelta
          , d7.PercentReturn
          , d7.ReturnFlag
          , SUM(d7.ReturnFlag) OVER(PARTITION BY d7.YR
                                               , d7.APIAccountNum ORDER BY d7.APIAccountNum
                                                                         , d7.Yr
                                                                         , d7.WoY) AS Score
     FROM
(
    SELECT d6.APIAccountNum
         , d6.WoY
         , d6.Yr
         , d6.RunningTotal
         , d6.PreviousWeek
         , d6.Delta
         , d6.PreviousDelta
         , CAST((d6.Delta - d6.PreviousDelta) / d6.PreviousDelta AS float) AS PercentReturn
         , CASE
               WHEN CAST((d6.Delta - d6.PreviousDelta) / ABS(d6.PreviousDelta) AS float) <= -1
               THEN-4
               WHEN CAST((d6.Delta - d6.PreviousDelta) / ABS(d6.PreviousDelta) AS float) <= -0.75
               THEN-3
               WHEN CAST((d6.Delta - d6.PreviousDelta) / ABS(d6.PreviousDelta) AS float) <= -0.50
               THEN-2
               WHEN CAST((d6.Delta - d6.PreviousDelta) / ABS(d6.PreviousDelta) AS float) <= -0.20
               THEN-1
               WHEN CAST((d6.Delta - d6.PreviousDelta) / ABS(d6.PreviousDelta) AS float) <= 0.00
               THEN 0
               WHEN CAST((d6.Delta - d6.PreviousDelta) / ABS(d6.PreviousDelta) AS float) <= 0.20
               THEN 0
               WHEN CAST((d6.Delta - d6.PreviousDelta) / ABS(d6.PreviousDelta) AS float) <= 0.50
               THEN 1
               WHEN CAST((d6.Delta - d6.PreviousDelta) / ABS(d6.PreviousDelta) AS float) <= 0.75
               THEN 2
               WHEN CAST((d6.Delta - d6.PreviousDelta) / ABS(d6.PreviousDelta) AS float) <= 1.00
               THEN 3
               WHEN CAST((d6.Delta - d6.PreviousDelta) / ABS(d6.PreviousDelta) AS float) > 1.00
               THEN 4
               ELSE 0
           END AS ReturnFlag
    FROM
(
    SELECT d5.APIAccountNum
         , d5.WoY
         , d5.Yr
         , d5.RunningTotal
         , d5.PreviousWeek
         , d5.Delta
         , LAG(d5.Delta, 1, 0) OVER(PARTITION BY d5.Yr
                                               , d5.APIAccountNum ORDER BY d5.APIAccountNum
                                                                         , d5.Yr
                                                                         , d5.WoY) AS PreviousDelta
    FROM
(
    SELECT d4.APIAccountNum
         , d4.WoY
         , d4.Yr
         , d4.RunningTotal
         , d4.PreviousWeek
         , (d4.RunningTotal - d4.PreviousWeek) AS Delta
    FROM
(
    SELECT d3.APIAccountNum
         , d3.WoY
         , d3.Yr
         , d3.RunningTotal
         , LAG(d3.RunningTotal, 1, 0) OVER(PARTITION BY d3.Yr
                                                      , d3.APIAccountNum ORDER BY d3.APIAccountNum
                                                                                , d3.Yr
                                                                                , d3.WoY) AS PreviousWeek
    FROM
(
    SELECT *
    FROM
(
    SELECT d1.WHAccountID AS APIAccountNum
         , d1.WeekOfYear AS WoY
         , d1.Year AS Yr
         , SUM(SUM(d1.ExtSales)) OVER(PARTITION BY d1.Year
                                                 , d1.WHAccountID ORDER BY d1.WeekOfYear) AS RunningTotal
         , CASE d1.WeekOfYear % 2
               WHEN 0
               THEN 'Even'
               ELSE 'Odd'
           END AS EoO
    FROM
(
    SELECT *
    FROM API.dbo.APISalesDetail AS sd
         JOIN Rx30.dbo.DateDim AS dd ON dd.TheDate = sd.InvDate
    WHERE sd.InvDate >= '20180101'
          AND sd.Type = 'Generic'
		AND sd.ExtSales > 0
		--AND sd.WHAccountID = '09137357'
) AS d1
    GROUP BY d1.WHAccountID
           , d1.WeekOfYear
           , d1.Year
) AS d2
    WHERE d2.EoO = 'Even'
) AS d3
) AS d4
) AS d5
) AS d6
) AS d7
     WHERE d7.PreviousDelta <> 0
     ORDER BY d7.APIAccountNum
            , d7.Yr
            , d7.WoY;
GO
