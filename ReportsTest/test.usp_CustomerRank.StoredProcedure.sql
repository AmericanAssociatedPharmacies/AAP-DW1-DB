USE [ReportsTest]
GO
/****** Object:  StoredProcedure [test].[usp_CustomerRank]    Script Date: 12/22/2020 7:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--/*
--Author: David Bohler 
--Create Date: 01/18/2019
--Description: CustomerRanks
--*/

CREATE PROCEDURE [test].[usp_CustomerRank]

----------------
----Parameters--
----------------

@PMID         INT
, @StartDateKey INT
, @EndDateKey   INT
, @Type         VARCHAR(50)

----------------
---TEST CASE---
---------------
--DECLARE @PMID INT;
--DECLARE @StartDateKey INT;
--DECLARE @EndDateKey INT;
--DECLARE @Rate FLOAT;
--DECLARE @Type VARCHAR(50);
--SET @PMID = 100442;
--SET @StartDateKey = 20180101;
--SET @EndDateKey = 20181130;
--SET @Type = 'Y'

AS
     SET NOCOUNT ON;
     BEGIN

---------------
--TEMP TABLES--
---------------

         DECLARE @TempAPIOrFq TABLE
(PMID            INT
, APIOrFq         INT
, APIGenericSales FLOAT
);
         DECLARE @TempCAHOrFq TABLE
(PMID            INT
, CAHOrFq         INT
, CAHGenericSales FLOAT
);


-------
--API--
-------

         INSERT INTO @TempAPIOrFq
                SELECT t2.PMID
                     , SUM(t2.InvoiceCount) AS APIOrFq
                     , SUM(t2.DailySales) AS APIGenericSales
                FROM
(
    SELECT t1.PMID
         , CASE
               WHEN COUNT(t1.InvoiceNumber) > 0
               THEN 1
               ELSE 0
           END AS InvoiceCount
         , SUM(t1.Sales) AS DailySales
         , t1.DateKey
    FROM
(
    SELECT d.PMID
         , e.InvoiceNumber
         , SUM(a.APIExtendedAmount) AS Sales
         , a.DateKey
    FROM SalesDDS.dbo.SalesFact_API AS a
         INNER JOIN SalesDDS.dbo.DrugDim AS b ON a.DrugKey = b.DrugKey
         INNER JOIN SalesDDS.dbo.DateDim AS c ON a.DateKey = c.DateKey
         INNER JOIN SalesDDS.dbo.PharmacyDim AS d ON a.PharmacyKey = d.PharmacyKey
         INNER JOIN SalesDDS.dbo.EventDimAPI AS e ON a.APIEventKey = e.EventKey
                                                     AND a.APIEventDateKey = e.DateKey
    WHERE a.DateKey >= @StartDateKey
          AND a.DateKey <= @EndDateKey
          AND b.MultiSourceCode = @Type
          AND d.PMID = @PMID
		AND c.IsWeekDay = 1
    GROUP BY d.PMID
           , e.InvoiceNumber
           , a.DateKey
) AS t1
    GROUP BY t1.PMID
           , t1.DateKey
) AS t2
                GROUP BY t2.PMID;

--Temp Table Check
--SELECT *
--FROM @TempAPIOrFq

-------
--CAH--
-------

         INSERT INTO @TempCAHOrFq
                SELECT t2.PMID
                     , SUM(t2.InvoiceCount) AS CAHOrFq
                     , SUM(t2.DailySales) AS CAHGenericSales
                FROM
(
    SELECT t1.PMID
         , CASE
               WHEN COUNT(t1.InvoiceNumber) > 0
               THEN 1
               ELSE 0
           END AS InvoiceCount
         , SUM(t1.Sales) AS DailySales
         , t1.DateKey
    FROM
(
    SELECT d.PMID
         , e.InvoiceNumber
         , SUM(a.CAHExtendedSales) AS Sales
         , a.DateKey
    FROM SalesDDS.dbo.SalesFact_CAH a
         INNER JOIN SalesDDS.dbo.DrugDim AS b ON a.DrugKey = b.DrugKey
         INNER JOIN SalesDDS.dbo.DateDim AS c ON a.DateKey = c.DateKey
         INNER JOIN SalesDDS.dbo.PharmacyDim AS d ON a.PharmacyKey = d.PharmacyKey
         INNER JOIN SalesDDS.dbo.EventDimCAH AS e ON a.CAHEventKey = e.EventKey
                                                     AND a.CAHEventDateKey = e.DateKey
    WHERE a.DateKey >= @StartDateKey
          AND a.DateKey <= @EndDateKey
          AND b.MultiSourceCode = @Type
          AND d.PMID = @PMID
		AND c.IsWeekDay = 1
    GROUP BY d.PMID
           , e.InvoiceNumber
           , a.DateKey
) AS t1
    GROUP BY t1.PMID
           , t1.DateKey
) AS t2
                GROUP BY t2.PMID;

--Temp Table Check
--SELECT *
--FROM @TempCAHOrFq

------------
--COMBINED--
------------


         SELECT a.PMID
              , CAST((CAST(a.ComOrFq AS FLOAT) / CAST(a.BizDay * 2 AS FLOAT)) AS DECIMAL(4, 2)) AS CustomerRank
              , a.FirstSalesDate
              , DATEDIFF(day, a.FirstSalesDate, '20181231') AS Age
              , a.APIOrFq
              , a.CAHOrFq
              , a.ComOrFq
              , a.BizDay
              , a.Sales AS GenSales
              , CAST((a.Sales / a.BizDay) AS DECIMAL(18, 2)) AS GenSalesPerBizDay
         FROM
(
    SELECT DISTINCT
           t1.PMID
         , t3.FirstSalesDate
         , CASE
               WHEN t3.FirstSalesDate < '20180101'
               THEN
(
    SELECT ReportsTest.dbo.fn_BusinessDays('20180101', '20181231')
)
               ELSE
(
    SELECT ReportsTest.dbo.fn_BusinessDays(t3.FirstSalesDate, '20181231')
)
           END AS BizDay
         , DATEDIFF(day, t3.FirstSalesDate, '20181231') AS Age
         , t1.APIOrFq
         , t2.CAHOrFq
         , (t1.APIOrFq + t2.CAHOrFq) AS ComOrFq
         , (t1.APIGenericSales + t2.CAHGenericSales) AS Sales
    FROM @TempAPIOrFq AS t1
         JOIN @TempCAHOrFq AS t2 ON t1.PMID = t2.PMID
         JOIN SalesDDS.dbo.PharmacyDim AS t3 ON t1.PMID = t3.PMID
) AS a;
     END;
GO
