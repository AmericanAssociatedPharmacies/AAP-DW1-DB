USE [ReportsTest]
GO
/****** Object:  View [test].[vw_rpt_ForecastTool]    Script Date: 12/22/2020 7:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [test].[vw_rpt_ForecastTool]
AS
     SELECT t3.PMID	
          , t3.APIAccountNum
          , t3.CustomerName
          , SUM(t3.Sales) AS TotalSales
          , SUM(t3.Units) AS TotalUnits
          , t3.DateOpened
          , COUNT(t3.InvDate) AS PurDays
     FROM
(
    SELECT t1.WHAccountID AS APIAccountNum
         , t2.PMID
         , t1.CustomerName
         , SUM(t1.ExtSales) AS Sales
         , SUM(t1.Qty) AS Units
         , t1.InvDate
         , t2.DateOpened
    FROM [API].dbo.APISalesDetail AS t1
         JOIN [PharmacyMaster].dbo.v_PM_AllWithAffiliates AS t2 ON t1.WHAccountID = t2.APIAccountNo
    WHERE t1.InvDate >= '20180101'
          AND t1.Type = 'Generic'
    GROUP BY t1.WHAccountID
           , t2.PMID
           , t1.CustomerName
           , t1.InvDate
           , t2.DateOpened
) AS t3
     GROUP BY t3.PMID
            , t3.APIAccountNum
            , t3.CustomerName
            , t3.DateOpened;
GO
