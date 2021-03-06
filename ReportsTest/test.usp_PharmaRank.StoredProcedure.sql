USE [ReportsTest]
GO
/****** Object:  StoredProcedure [test].[usp_PharmaRank]    Script Date: 12/22/2020 7:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--/*
--Author: David Bohler 
--Create Date: 12/17/2018
--Description: Customer Sales Trends
--*/

CREATE PROCEDURE [test].[usp_PharmaRank]
----------------
----Parameters--
----------------
@PMID         INT
, @StartDateKey INT
, @EndDateKey   INT
, @Type         VARCHAR(50)
----------------

AS
     BEGIN
         SET NOCOUNT ON;

-------------
---TEST CASE--- 

--DECLARE @PMID INT;
--DECLARE @StartDateKey INT;
--DECLARE @EndDateKey INT;
--DECLARE @Rate FLOAT;
--DECLARE @Type VARCHAR(50);
--SET @PMID = 100442;
--SET @StartDateKey = 20180101;
--SET @EndDateKey = 20181130;
--SET @Type = 'Y';

--------------
--PharmaRank--
--------------
         SELECT t2.PMID
              , CAST(CAST(SUM(t2.InvoiceCount) AS FLOAT) / t2.BizDay AS DECIMAL(18, 2)) * 100 AS CustomerScore
              , CASE
                    WHEN CAST(CAST(SUM(t2.InvoiceCount) AS FLOAT) / t2.BizDay AS DECIMAL(18, 2)) * 100 <= 25
                    THEN 'D'
                    WHEN CAST(CAST(SUM(t2.InvoiceCount) AS FLOAT) / t2.BizDay AS DECIMAL(18, 2)) * 100 <= 50
                    THEN 'C'
                    WHEN CAST(CAST(SUM(t2.InvoiceCount) AS FLOAT) / t2.BizDay AS DECIMAL(18, 2)) * 100 <= 75
                    THEN 'B'
                    WHEN CAST(CAST(SUM(t2.InvoiceCount) AS FLOAT) / t2.BizDay AS DECIMAL(18, 2)) * 100 <= 95
                    THEN 'A'
                    ELSE 'S'
                END AS PharmRank
              , t2.FirstSalesDate
              , SUM(t2.SalesYear) AS SalesTotal
              , CAST(SUM(t2.InvoiceCount) AS INT) AS OrderFreq2018
              , DATEDIFF(day, t2.FirstSalesDate, '20181231') AS Age
              , SUM(t2.SalesYear) / CAST(SUM(t2.InvoiceCount) AS INT) AS SalesPerOrderDay
         FROM
(
    SELECT t1.PMID
         , CASE
               WHEN COUNT(t1.InvoiceNumber) > 0
               THEN 1
               ELSE 0
           END AS InvoiceCount
         , SUM(t1.TotalSales) AS SalesYear
         , t1.DateKey
         , t1.FirstSalesDate
         , t1.BizDay
    FROM
(
    SELECT d.PMID
         , e.InvoiceNumber
	    -- the below sum needs to have CAH sales added so that TotalSales = API generic sales + CAH generic Sales 
         , SUM(a.APIExtendedAmount) AS TotalSales
         , SUM(a.APIInvoiceQuantity) AS TotalUnits
         , a.DateKey
         , c.DayName
         , c.MonthOfYear
         , c.Year
         , c.IsWeekDay
         , d.FirstSalesDate
         , CASE
               WHEN d.FirstSalesDate < '20180101'
               THEN
(
    SELECT ReportsTest.dbo.fn_BusinessDays('20180101', '20181231')
)
               ELSE
(
    SELECT ReportsTest.dbo.fn_BusinessDays(d.FirstSalesDate, '20181231')
)
           END AS BizDay
    FROM SalesDDS.dbo.SalesFact_API AS a
         INNER JOIN SalesDDS.dbo.DrugDim AS b ON a.DrugKey = b.DrugKey
         INNER JOIN SalesDDS.dbo.DateDim AS c ON a.DateKey = c.DateKey
         INNER JOIN SalesDDS.dbo.PharmacyDim AS d ON a.PharmacyKey = d.PharmacyKey
         INNER JOIN SalesDDS.dbo.EventDimAPI AS e ON a.APIEventKey = e.EventKey
                                                     AND a.APIEventDateKey = e.DateKey
--Need to add in CAH tables in the Sales Data Mart
 
    WHERE a.DateKey >= @StartDateKey
          AND a.DateKey <= @EndDateKey
          AND b.MultiSourceCode = @Type
          AND d.PMID = ISNULL(@PMID, d.PMID)
          AND d.PMID <> 0
          AND d.APIStatus = 100000000
    GROUP BY d.PMID
           , e.InvoiceNumber
           , a.DateKey
           , c.DayName
           , c.MonthOfYear
           , c.Year
           , c.IsWeekDay
           , d.FirstSalesDate
) AS t1
    GROUP BY t1.PMID
           , t1.DateKey
           , t1.FirstSalesDate
           , t1.BizDay
) AS t2
         GROUP BY t2.PMID
                , t2.FirstSalesDate
                , t2.BizDay;
     END;




GO
