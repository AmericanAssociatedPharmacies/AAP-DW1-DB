USE [ReportsTest]
GO
/****** Object:  StoredProcedure [test].[usp_sisense_Price_API]    Script Date: 12/22/2020 7:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [test].[usp_sisense_Price_API]
AS
     SELECT t1.APIItemNbr
          , T1.NDC
          , SUM(t1.ExtSales) AS TotalSales
          , SUM(t1.Qty) AS TotalUnits
          , MONTH(t1.InvDate) AS Mnth
          , YEAR(t1.InvDate) AS Yr
     FROM API.dbo.APISalesDetail AS t1
     WHERE t1.InvDate >= '20170101'
	AND t1.Type = 'GENERIC'
     GROUP BY t1.APIItemNbr
            , T1.NDC
            , MONTH(t1.InvDate)
            , YEAR(t1.InvDate);
GO
