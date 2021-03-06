USE [ReportsTest]
GO
/****** Object:  StoredProcedure [test].[usp_sisense_Price_CAH]    Script Date: 12/22/2020 7:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [test].[usp_sisense_Price_CAH]
AS
     SELECT t1.ITEM_NO
          , T1.NDC
          , SUM(t1.EXT_COST) AS TotalSales
          , SUM(t1.SHIP_QTY) AS TotalUnits
          , MONTH(t1.INV_DATE) AS Mnth
          , YEAR(t1.INV_DATE) AS Yr
     FROM Purchases.dbo.CHPH_AAP AS t1
     WHERE t1.INV_DATE >= '20170101'
	AND t1.BRAND = 'N'
	AND t1.ITEM_TYPE = 'RX'
     GROUP BY t1.ITEM_NO
            , T1.NDC
            , MONTH(t1.INV_DATE)
            , YEAR(t1.INV_DATE);
GO
