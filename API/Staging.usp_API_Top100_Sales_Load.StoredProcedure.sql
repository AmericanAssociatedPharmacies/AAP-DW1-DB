USE [API]
GO
/****** Object:  StoredProcedure [Staging].[usp_API_Top100_Sales_Load]    Script Date: 12/22/2020 6:09:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [Staging].[usp_API_Top100_Sales_Load]

AS

SET NOCOUNT ON;
SET ANSI_WARNINGS OFF;

BEGIN

DECLARE @1stStartDate DATETIME
, @1stEndDate DATETIME
, @2ndStartDate DATETIME
, @2ndEndDate DATETIME
, @3rdStartDate DATETIME
, @3rdEndDate DATETIME
 
--Last and First day of current month
SET @1stStartDate = DATEADD(mm, DATEDIFF(mm, 0, GETDATE()), 0) 
--DATEADD(mm, DATEDIFF(mm, 0, GETDATE()) -1, 0)
SET @1stEndDate = DATEADD(DAY, 0, DATEDIFF(DAY, 0, GETDATE()))
 
DECLARE @T1 TABLE(RankBySalesMonth INT
                           , NDC VARCHAR(13)
                           , APIItemNbr VARCHAR(25)
                           , MonthName VARCHAR(15)
                           , Qty INT
                           , Sales MONEY
                           , APICustomerInvoiceAmount VARCHAR(250)         
                           )
 
 
INSERT INTO @T1(RankBySalesMonth, NDC, APIItemNbr, MonthName, Qty, Sales, APICustomerInvoiceAmount)
SELECT TOP 100 RANK() OVER(ORDER BY Sales DESC) AS RankBySales
, dt.NDC
, dt.APIItemNbr
, dt.MonthName
, dt.Qty
, dt.Sales
, ca.APICustomerInvoicePrice
FROM(SELECT DISTINCT a.NDC
       , [APIItemNbr]
       , di.MonthName
       , SUM(IIF(ExtSales < 0, -1*Qty, Qty)) AS Qty
       , SUM([ExtSales]) AS Sales
       FROM [dbo].[APISalesDetail] AS a
       INNER JOIN SalesDDS.dbo.DateDim AS di ON a.InvDate = di.TheDate    
       WHERE InvDate >= @1stStartDate
       AND InvDate < @1stEndDate
       AND a.Type = 'Generic'
	   GROUP BY a.NDC
       , [APIItemNbr]
       , MonthName
       ) AS dt
CROSS APPLY(SELECT DISTINCT CASE
					 WHEN NULLIF(MIN(pf.APICustomerInvoicePrice), MAX(pf.APICustomerInvoicePrice)) IS NULL THEN CONVERT(VARCHAR(25), MAX(pf.APICustomerInvoicePrice))
						ELSE CONVERT(VARCHAR(25), MIN(pf.APICustomerInvoicePrice)) + ' - ' + CONVERT(VARCHAR(25), MAX(pf.APICustomerInvoicePrice)) 
						END AS APICustomerInvoicePrice
			FROM Pricing.dbo.PriceFact AS pf
			INNER JOIN Pricing.dbo.DrugDim AS dd ON dt.NDC = dd.NDC
													AND pf.DrugKey = dd.DrugKey
            WHERE pf.DateKey >= cast(CONVERT(varchar(20),@1stStartDate,112) as INT)
            AND pf.DateKey < cast(CONVERT(varchar(20),@1stEndDate,112) as INT) 
			) AS ca
ORDER BY Sales DESC

 
DECLARE @T2 TABLE(RankBySalesMonth INT
                         , NDC VARCHAR(13)
                         , APIItemNbr VARCHAR(25)
                         , MonthName VARCHAR(15)
                         , Qty INT
                         , Sales MONEY
                         , APICustomerInvoiceAmount VARCHAR(250)        
                         )

--Last and First day of previous month
SET @2ndStartDate = DATEADD(mm, DATEDIFF(mm, 0, GETDATE()) -1, 0)
SET @2ndEndDate = DATEADD(mm, DATEDIFF(mm, 0, GETDATE()), 0)
 
INSERT INTO @T2(RankBySalesMonth, NDC, APIItemNbr, MonthName, Qty, Sales, APICustomerInvoiceAmount)
SELECT TOP 100 RANK() OVER(ORDER BY Sales DESC) AS RankBySales
, dt.NDC
, dt.APIItemNbr
, dt.MonthName
, dt.Qty
, dt.Sales
, ca.APICustomerInvoicePrice
FROM(SELECT DISTINCT a.NDC
       , [APIItemNbr]
       , di.MonthName
        , SUM(IIF(ExtSales < 0, -1*Qty, Qty)) AS Qty
       , SUM([ExtSales]) AS Sales
       FROM [dbo].[APISalesDetail] AS a
       INNER JOIN SalesDDS.dbo.DateDim AS di ON a.InvDate = di.TheDate    
       WHERE InvDate >= @2ndStartDate
       AND InvDate < @2ndEndDate
       AND a.Type = 'Generic'
	   GROUP BY a.NDC
       , [APIItemNbr]
       , MonthName
       ) AS dt
CROSS APPLY(SELECT DISTINCT CASE
					 WHEN NULLIF(MIN(pf.APICustomerInvoicePrice), MAX(pf.APICustomerInvoicePrice)) IS NULL THEN CONVERT(VARCHAR(25), MAX(pf.APICustomerInvoicePrice))
						ELSE CONVERT(VARCHAR(25), MIN(pf.APICustomerInvoicePrice)) + ' - ' + CONVERT(VARCHAR(25), MAX(pf.APICustomerInvoicePrice)) 
						END AS APICustomerInvoicePrice
			FROM Pricing.dbo.PriceFact AS pf
			INNER JOIN Pricing.dbo.DrugDim AS dd ON dt.NDC = dd.NDC
													AND pf.DrugKey = dd.DrugKey
            WHERE pf.DateKey >= cast(CONVERT(varchar(20),@2ndStartDate,112) as INT)
            AND pf.DateKey < cast(CONVERT(varchar(20),@2ndEndDate,112) as INT) 
			) AS ca
ORDER BY Sales DESC


 
DECLARE @T3 TABLE(RankBySalesMonth INT
                         , NDC VARCHAR(13)
                         , APIItemNbr VARCHAR(25)
                         , MonthName VARCHAR(15)
                         , Qty INT
                         , Sales MONEY
                         , APICustomerInvoiceAmount VARCHAR(250) 
                         )
 
 
--Last and First day of 3rd month
SET @3rdStartDate = DATEADD(mm, DATEDIFF(mm, 0, GETDATE()) -2, 0)
SET @3rdEndDate = DATEADD (dd, 0, DATEADD(mm, DATEDIFF(mm, 0, GETDATE()) - 1, 0))
 
INSERT INTO @T3(RankBySalesMonth, NDC, APIItemNbr, MonthName, Qty, Sales, APICustomerInvoiceAmount)
SELECT TOP 100 RANK() OVER(ORDER BY Sales DESC) AS RankBySales
, dt.NDC
, dt.APIItemNbr
, dt.MonthName
, dt.Qty
, dt.Sales
, ca.APICustomerInvoicePrice
FROM(SELECT DISTINCT a.NDC
       , [APIItemNbr]
       , di.MonthName
        , SUM(IIF(ExtSales < 0, -1*Qty, Qty)) AS Qty
       , SUM([ExtSales]) AS Sales
       FROM [dbo].[APISalesDetail] AS a
       INNER JOIN SalesDDS.dbo.DateDim AS di ON a.InvDate = di.TheDate    
       WHERE InvDate >= @3rdStartDate
       AND InvDate < @3rdEndDate
       AND a.Type = 'Generic'
	   GROUP BY a.NDC
       , [APIItemNbr]
       , MonthName
       ) AS dt
CROSS APPLY(SELECT DISTINCT CASE
					 WHEN NULLIF(MIN(pf.APICustomerInvoicePrice), MAX(pf.APICustomerInvoicePrice)) IS NULL THEN CONVERT(VARCHAR(25), MAX(pf.APICustomerInvoicePrice))
						ELSE CONVERT(VARCHAR(25), MIN(pf.APICustomerInvoicePrice)) + ' - ' + CONVERT(VARCHAR(25), MAX(pf.APICustomerInvoicePrice)) 
						END AS APICustomerInvoicePrice
			FROM Pricing.dbo.PriceFact AS pf
			INNER JOIN Pricing.dbo.DrugDim AS dd ON dt.NDC = dd.NDC
													AND pf.DrugKey = dd.DrugKey
            WHERE pf.DateKey >= cast(CONVERT(varchar(20),@3rdStartDate,112) as INT)
            AND pf.DateKey < cast(CONVERT(varchar(20),@3rdEndDate,112) as INT) 
			) AS ca
ORDER BY Sales DESC


 
INSERT INTO Staging.API_Top100_Sales(RankBySalesMonth_CurrentMonth, NDC_1, APIItemNbr_1, MonthName_1, Qty_1, Sales_1, APICustomerInvoiceAmount_1
								, RankBySalesMonth_2, NDC_2, APIItemNbr_2, MonthName_2, Qty_2, Sales_2, APICustomerInvoiceAmount_2
								, RankBySalesMonth_3, NDC_3, APIItemNbr_3, MonthName_3, Qty_3, Sales_3, APICustomerInvoiceAmount_3
								, [Description], Manufacturer, PackageSize
								) 
SELECT dt1.RankBySalesMonth_CurrentMonth, dt1.NDC_1, dt1.APIItemNbr_1, dt1.MonthName_1, dt1.Qty_1, dt1.Sales_1,APICustomerInvoiceAmount_1
,  dt2.RankBySalesMonth_2, dt2.NDC_2, dt2.APIItemNbr_2, dt2.MonthName_2, dt2.Qty_2, dt2.Sales_2,APICustomerInvoiceAmount_2
,  dt3.RankBySalesMonth_3, dt3.NDC_3, dt3.APIItemNbr_3, dt3.MonthName_3, dt3.Qty_3, dt3.Sales_3, APICustomerInvoiceAmount_3
, ISNULL(ISNULL(dd1.Description, dd2.Description), dd3.Description) AS Description
, ISNULL(ISNULL(dd1.Manufacturer, dd2.Manufacturer), dd3.Manufacturer) AS Manufacturer
, ISNULL(ISNULL(dd1.PackageSize, dd2.PackageSize), dd3.PackageSize) AS PackageSize
FROM(SELECT RankBySalesMonth AS RankBySalesMonth_CurrentMonth, NDC AS NDC_1, APIItemNbr AS APIItemNbr_1, MonthName AS MonthName_1, Qty AS Qty_1, Sales AS Sales_1, APICustomerInvoiceAmount AS APICustomerInvoiceAmount_1
     FROM @T1
     ) AS dt1
FULL OUTER JOIN(SELECT RankBySalesMonth AS RankBySalesMonth_2, NDC AS NDC_2, APIItemNbr AS APIItemNbr_2, MonthName AS MonthName_2, Qty AS Qty_2, Sales AS Sales_2, APICustomerInvoiceAmount AS APICustomerInvoiceAmount_2
                         FROM @T2
                         ) AS dt2 ON dt1.NDC_1 = dt2.NDC_2
FULL OUTER JOIN(SELECT RankBySalesMonth AS RankBySalesMonth_3, NDC AS NDC_3, APIItemNbr AS APIItemNbr_3, MonthName AS MonthName_3, Qty AS Qty_3, Sales AS Sales_3, APICustomerInvoiceAmount AS APICustomerInvoiceAmount_3
                         FROM @T3
                         ) AS dt3 ON dt2.NDC_2 = dt3.NDC_3
LEFT OUTER JOIN (SELECT DISTINCT NDC, Description, Manufacturer, PackageSize
                                FROM  DrugMaster.dbo.DrugDim
                         ) AS dd1 ON dt1.NDC_1 = dd1.NDC
LEFT OUTER JOIN (SELECT DISTINCT NDC, Description, Manufacturer, PackageSize
                                 FROM  DrugMaster.dbo.DrugDim
                         ) AS dd2 ON dt2.NDC_2 = dd2.NDC
LEFT OUTER JOIN (SELECT DISTINCT NDC, Description, Manufacturer, PackageSize
                                FROM  DrugMaster.dbo.DrugDim
                         ) AS dd3 ON dt3.NDC_3 = dd3.NDC

END

GO
