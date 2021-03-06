USE [SSRS]
GO
/****** Object:  View [dbo].[vw_Comp_API]    Script Date: 12/22/2020 8:05:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE VIEW [dbo].[vw_Comp_API]
AS 
SELECT t9.PMID
     , SUM(t9.[Purchase Qty]) AS [Purchase Qty]
     , SUM(t9.[Purchases @ AWP]) AS [Purchases @ AWP]
FROM
(
    SELECT x.PMID
         , x.GPI
         , x.Description
         , SUM(x.[Purchase Qty]) AS [Purchase Qty]
         , SUM(x.[Purchases @ AWP]) AS [Purchases @ AWP]
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
                 , d.pmid
                 , b.GPI
                 , b.Description
                 , a.InvDate
                 , a.InvNbr
                 , CASE
                       WHEN a.ExtSales < 0
                       THEN(a.Qty * -1)
                       ELSE a.Qty
                   END AS Qty
                 , b.PackageSize
                 , b.PackageQuantity
                 , CASE
                       WHEN a.ExtSales < 0
                       THEN(a.Qty * -1) * b.PackageSize * b.PackageQuantity
                       ELSE a.Qty * b.PackageSize * b.PackageQuantity
                   END AS Doses
                 , b.AWPPerDose
            FROM API.dbo.APISalesDetail AS a
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
                SELECT t2.TheDate
                FROM SalesDDS.dbo.DateDim AS T2
                WHERE t2.TheDate >= DATEADD(day, -91, DATEADD(d, 0, DATEDIFF(d, 0, GETDATE())))
            ) AS c ON  a.InvDate = c.TheDate
                 INNER JOIN
            (
                SELECT DISTINCT 
                       t3.PMID
                     , t3.APINumber
                FROM RXMaster.dbo.PharmacyDim AS t3
            ) AS d ON a.WHAccountID = d.APINumber
            WHERE a.Type IN('Generic', 'Brand')
        ) AS d
        GROUP BY d.GPI
               , d.PMID
               , d.Description
               , d.AWPPerDose
    ) AS x
    GROUP BY x.GPI
           , x.PMID
           , x.Description
) AS t9
GROUP BY t9.PMID;

GO
