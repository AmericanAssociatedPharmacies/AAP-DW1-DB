USE [ReportsTest]
GO
/****** Object:  View [test].[vw_Products]    Script Date: 12/22/2020 7:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [test].[vw_Products]
AS
     SELECT d1.APIItemNbr
          , ISNULL(d1.GPI, d2.GPI) AS GPI
          , d1.NDC
          , d1.DrugName
		, d1.DrugType
          , ISNULL(d1.PackageSize, d2.PackageSize) AS PackSize
          , ISNULL(d1.InvDate, d2.INV_DATE) AS InvDate
          , SUM(d1.APITotalQty) AS APITotalQty
          , SUM(d2.CAHTotalQty) AS CAHTotalQty
     FROM
(
    SELECT t1.APIItemNbr
         , t1.NDC
         , t2.GPI
         , t2.DrugName
         , t2.PackageSize
         , SUM(t1.Qty) AS APITotalQty
         , t1.InvDate
	    , t2.DrugType
    FROM API.dbo.APISalesDetail AS t1
         JOIN Rx30.dbo.DrugDim AS t2 ON t1.NDC = t2.NDC
    WHERE InvDate >= '20180101'
          AND t1.ExtSales > 0 
		AND t2.IsRX = 1
    GROUP BY t1.APIItemNbr
           , t1.NDC
           , t2.PackageSize
           , t2.GPI
           , t2.DrugName
           , t1.InvDate
		 ,t2.DrugType
) AS d1
FULL OUTER JOIN
(
SELECT t3.GPI
     , t3.PackageSize
     , SUM(t2.SHIP_QTY) AS CAHTotalQty
     , t2.INV_DATE
FROM Purchases.dbo.CHPH_AAP AS t2
     JOIN Rx30.dbo.DrugDim AS t3 ON t3.NDC = t2.NDC
WHERE t2.INV_DATE >= '20180101'
      AND t2.EXT_COST > 0
      AND t3.IsRX = 1
	 --AND t3.GPI = '90550085103720'
GROUP BY t3.GPI
       , t3.PackageSize
       , t2.INV_DATE
       , t3.PackageSize
) AS d2 ON d1.GPI = d2.GPI
           AND d1.PackageSize = d2.PackageSize
           AND d1.InvDate = d2.INV_DATE
--WHERE d1.GPI = '90550085103720'
     GROUP BY d1.APIItemNbr
            , d1.NDC
            , d1.GPI
            , d1.DrugName
            , d1.PackageSize
            , d1.InvDate
            , d2.GPI
            , d2.PackageSize
            , d2.INV_DATE
		  , d1.DrugType

GO
