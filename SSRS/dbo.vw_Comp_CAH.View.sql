USE [SSRS]
GO
/****** Object:  View [dbo].[vw_Comp_CAH]    Script Date: 12/22/2020 8:05:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vw_Comp_CAH]
AS
     SELECT t9.PMID
          , SUM(t9.[Purchase Qty]) AS [Purchase Qty]
          , SUM(t9.[Purchases @ AWP]) AS [Purchases @ AWP]
     FROM
     (
         SELECT y.PMID
              , y.GPI
              , y.Description
              , SUM(y.[Purchase Qty]) AS [Purchase Qty]
              , SUM(y.[Purchases @ AWP]) AS [Purchases @ AWP]
         FROM
         (
             SELECT d.GPI
                  , d.PMID
                  , d.Description
                  , SUM(d.Doses) AS [Purchase Qty]
                  , SUM(d.Doses) * d.AWPPerDose AS [Purchases @ AWP]
             FROM
             (
                 SELECT a.NDC
                      , a.PMID
                      , b.GPI
                      , b.Description
                      , a.INV_DATE
                      , a.INVOICE_NO
                      , CASE
                            WHEN a.EXT_COST < 0
                            THEN(a.SHIP_QTY * -1)
                            ELSE a.SHIP_QTY
                        END AS Qty
                      , b.PackageSize
                      , b.PackageQuantity
                      , CASE
                            WHEN a.EXT_COST < 0
                            THEN(a.SHIP_QTY * -1) * b.PackageSize * b.PackageQuantity
                            ELSE a.SHIP_QTY * b.PackageSize * b.PackageQuantity
                        END AS Doses
                      , b.AWPPerDose
                      , a.DateKey
                 FROM Purchases.dbo.CHPH_AAP AS a
                      INNER JOIN
                 (
                     SELECT t1.NDC
                          , t1.GPI
                          , t1.Description
                          , t1.PackageSize
                          , t1.PackageQuantity
                          , t1.AWPPerDose
                     FROM SalesDDS.dbo.DrugDim AS t1
                     WHERE t1.Strength IS NOT NULL
                 ) AS b ON a.NDC = b.NDC
                      INNER JOIN
                 (
                     SELECT t2.DateKey
                     FROM SalesDDS.dbo.DateDim AS T2
                     WHERE t2.TheDate >= DATEADD(day, -91, DATEADD(d, 0, DATEDIFF(d, 0, GETDATE())))
                 ) AS c ON a.DateKey = c.DateKey
                 WHERE a.ITEM_TYPE = 'Rx'
             ) AS d
             GROUP BY d.GPI
                    , d.PMID
                    , d.Description
                    , d.AWPPerDose
         ) AS y
         GROUP BY y.GPI
                , Y.PMID
                , y.Description
     ) AS t9
     GROUP BY t9.PMID;
GO
