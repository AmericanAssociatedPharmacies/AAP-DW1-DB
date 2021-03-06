USE [ReportsTest]
GO
/****** Object:  StoredProcedure [test].[usp_CustomerTrends_API]    Script Date: 12/22/2020 7:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
Author: David Bohler 
Create Date: 12/17/2018
Description: Customer Sales Trends
*/

CREATE PROCEDURE [test].[usp_CustomerTrends_API]
----------------
----Parameters--
----------------
@PMID         INT
, @StartDateKey INT
, @EndDateKey   INT
, @Rate         FLOAT
, @Type         VARCHAR(50)
----------------

AS
     BEGIN
         SET NOCOUNT ON;

---------------
---TEST CASE--- 

--DECLARE @PMID INT;
--DECLARE @StartDateKey INT;
--DECLARE @EndDateKey INT;
--DECLARE @Rate FLOAT;
--DECLARE @Type VARCHAR(50);
--SET @PMID = 113065;
--SET @StartDateKey = 20180101;
--SET @EndDateKey = 20181130;
--SET @Rate = .05;
--SET @Type = 'Y';

------------------
--Sales Analysis--
------------------
         SELECT t5.PMID
              , t5.WoY
              , t5.Yr
              , t5.RunningTotal
              , t5.PreviousWeek
              , t5.Change
              , t5.PreviousChange
              , t5.PercentReturn
              , t5.ReturnFlag
              , SUM(t5.ReturnFlag) OVER(PARTITION BY t5.PMID
                                                   , t5.Yr ORDER BY t5.PMID
                                                                  , t5.Yr
                                                                  , t5.Woy) AS Score
         FROM
(
    SELECT t4.PMID
         , t4.WoY
         , t4.Yr
         , t4.RunningTotal
         , t4.PreviousWeek
         , t4.Change
         , t4.PreviousChange
         , CAST((t4.Change - t4.PreviousChange) / t4.PreviousChange AS FLOAT) AS PercentReturn
         , CASE
               WHEN CAST((t4.Change - t4.PreviousChange) / ABS(t4.PreviousChange) AS FLOAT) <= -(@Rate + .30)
               THEN-4
               WHEN CAST((t4.Change - t4.PreviousChange) / ABS(t4.PreviousChange) AS FLOAT) <= -(@Rate + .20)
               THEN-3
               WHEN CAST((t4.Change - t4.PreviousChange) / ABS(t4.PreviousChange) AS FLOAT) <= -(@Rate + .10)
               THEN-2
               WHEN CAST((t4.Change - t4.PreviousChange) / ABS(t4.PreviousChange) AS FLOAT) <= -(@Rate)
               THEN-1
               WHEN CAST((t4.Change - t4.PreviousChange) / ABS(t4.PreviousChange) AS FLOAT) <= 0
               THEN 0
               WHEN CAST((t4.Change - t4.PreviousChange) / ABS(t4.PreviousChange) AS FLOAT) <= @Rate
               THEN 0
               WHEN CAST((t4.Change - t4.PreviousChange) / ABS(t4.PreviousChange) AS FLOAT) <= (@Rate + .10)
               THEN 1
               WHEN CAST((t4.Change - t4.PreviousChange) / ABS(t4.PreviousChange) AS FLOAT) <= (@Rate + .20)
               THEN 2
               WHEN CAST((t4.Change - t4.PreviousChange) / ABS(t4.PreviousChange) AS FLOAT) <= (@Rate + .30)
               THEN 3
               WHEN CAST((t4.Change - t4.PreviousChange) / ABS(t4.PreviousChange) AS FLOAT) > (@Rate + .30)
               THEN 4
               ELSE 0
           END AS ReturnFlag
    FROM
(
    SELECT t3.PMID
         , t3.Woy
         , t3.Yr
         , t3.RunningTotal
         , t3.PreviousWeek
         , t3.Change
         , LAG(t3.Change, 1, 0) OVER(PARTITION BY t3.Yr
                                                , t3.PMID ORDER BY t3.PMID
                                                                 , t3.Yr
                                                                 , t3.Woy) AS PreviousChange
    FROM
(
    SELECT t2.PMID
         , t2.WoY
         , t2.Yr
         , t2.RunningTotal
         , t2.PreviousWeek
         , (t2.RunningTotal - t2.PreviousWeek) AS Change
    FROM
(
    SELECT t1.PMID
         , t1.WoY
         , t1.Yr
         , t1.RunningTotal
         , LAG(t1.RunningTotal, 1, 0) OVER(PARTITION BY t1.Yr
                                                      , t1.PMID ORDER BY t1.PMID
                                                                       , t1.Yr
                                                                       , t1.WoY) AS PreviousWeek
    FROM
(
    SELECT d.PMID
         , c.WeekOfYear AS WoY
         , c.Year AS Yr
         , SUM(SUM(a.APIExtendedAmount)) OVER(PARTITION BY c.Year
                                                         , d.PMID ORDER BY c.WeekOfYear) AS RunningTotal
    FROM SalesDDS.dbo.SalesFact_API AS a
         INNER JOIN SalesDDS.dbo.DrugDim AS b ON a.DrugKey = b.DrugKey
         INNER JOIN SalesDDS.dbo.DateDim AS c ON a.DateKey = c.DateKey
         INNER JOIN SalesDDS.dbo.PharmacyDim AS d ON a.PharmacyKey = d.PharmacyKey
         INNER JOIN SalesDDS.dbo.EventDimAPI AS e ON a.APIEventKey = e.EventKey
                                                     AND a.APIEventDateKey = e.DateKey
    WHERE a.DateKey >= @StartDateKey
          AND a.DateKey <= @EndDateKey
          AND b.MultiSourceCode = @Type
          AND d.PMID = ISNULL(@PMID,d.PMID)
		AND d.PMID <> 0 
          AND c.WeekOfYear % 2 = 0
    GROUP BY d.PMID
           , c.WeekOfYear
           , c.Year
) AS t1
) AS t2
) AS t3
) AS t4
    WHERE t4.PreviousChange <> 0
) AS t5;
     END;
GO
