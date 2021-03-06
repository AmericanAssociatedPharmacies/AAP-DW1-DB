USE [ReportsTest]
GO
/****** Object:  View [test].[vw_CAH_ProductsDash]    Script Date: 12/22/2020 7:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [test].[vw_CAH_ProductsDash] AS 
SELECT t2.GPI
     , t2.PackageSize
     , SUM(t1.EXT_COST) AS CAHSales
     , SUM(t1.SHIP_QTY) AS CAHUnits
FROM Purchases.dbo.CHPH_AAP AS t1
     JOIN DrugMaster.dbo.DrugDim AS t2 ON t1.NDC = t2.NDC
     JOIN Reports.dbo.vw_Products AS t3 ON t2.GPI = t3.GPI
WHERE t1.ITEM_TYPE = 'RX'
      AND t1.BRAND = 'N'
      AND t1.INV_DATE >= '20180101'
      AND t1.EXT_COST > 0
GROUP BY t2.GPI
       , t2.PackageSize;
GO
