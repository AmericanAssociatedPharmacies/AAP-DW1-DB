USE [SSRS]
GO
/****** Object:  StoredProcedure [dbo].[usp_Compliance_DM]    Script Date: 12/22/2020 8:05:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
Author: David Bohler 
Create Date: 08/27/2019 
Description: Compliance Report V5
*/

CREATE PROCEDURE [dbo].[usp_Compliance_DM] @PMID INT
AS
     DECLARE @TempAPI TABLE
     (GPI               VARCHAR(20)
    , Description       VARCHAR(250)
    , [Purchase Qty]    DECIMAL(18, 2)
    , [Purchases @ AWP] DECIMAL(18, 2)
     );
     DECLARE @TempCAH TABLE
     (GPI               VARCHAR(20)
    , Description       VARCHAR(250)
    , [Purchase Qty]    DECIMAL(18, 2)
    , [Purchases @ AWP] DECIMAL(18, 2)
     );
     DECLARE @TempFDS TABLE
     (GPI              VARCHAR(20)
    , Description      VARCHAR(250)
    , [Dispense Qty]   DECIMAL(18, 2)
    , [Dispense @ AWP] DECIMAL(18, 2)
     );
     INSERT INTO @TempAPI
            SELECT x.GPI
                 , x.Description
                 , SUM(x.[Purchase Qty]) AS [Purchase Qty]
                 , SUM(x.[Purchases @ AWP]) AS [Purchases @ AWP]
            FROM
            (
                SELECT d.GPI
                     , d.Description
                     , SUM(d.Doses) AS [Purchase Qty]
                     , SUM(d.Doses) * d.AWPPerDose AS [Purchases @ AWP]
                FROM
                (
                    SELECT b.NDC
                         , b.GPI
                         , b.Description
                         , m.InvoiceDate
                         , m.InvoiceNumber
                         , a.APIInvoiceQuantity AS Qty
                         , b.PackageSize
                         , b.PackageQuantity
                         , a.APIInvoiceQuantity * b.PackageSize * b.PackageQuantity AS Doses
                         , b.AWPPerDose
                    FROM SalesDDS.dbo.SalesFact_API AS a
                         INNER JOIN SalesDDS.dbo.EventDimAPI AS m ON a.APIEventKey = m.EventKey
                                                                     AND a.APIEventDateKey = m.DateKey
                         INNER JOIN
                    (
                        SELECT t1.NDC
                             , t1.GPI
                             , t1.DrugKey
                             , t1.Description
                             , t1.PackageSize
                             , t1.PackageQuantity
                             , t1.AWPPerDose
                        FROM SalesDDS.dbo.DrugDim AS t1
                        WHERE t1.IsRX = 1
                    ) AS b ON a.DrugKey = b.DrugKey
                         INNER JOIN
                    (
                        SELECT t2.TheDate
                             , t2.DateKey
                        FROM SalesDDS.dbo.DateDim AS T2
                        WHERE t2.TheDate >= DATEADD(day, -91, GETDATE())
                    ) AS c ON a.DateKey = c.DateKey
                         INNER JOIN
                    (
                        SELECT DISTINCT 
                               t3.PMID
                             , t3.APINumber
                             , t3.PharmacyKey
                        FROM RXMaster.dbo.PharmacyDim AS t3
                        WHERE t3.PMID = @PMID
                    ) AS d ON a.PharmacyKey = d.PharmacyKey
                ) AS d
                GROUP BY d.GPI
                       , d.Description
                       , d.AWPPerDose
            ) AS x
            GROUP BY x.GPI
                   , x.Description;

     --CAH--
     INSERT INTO @TempCAH
            SELECT y.GPI
                 , y.Description
                 , SUM(y.[Purchase Qty]) AS [Purchase Qty]
                 , SUM(y.[Purchases @ AWP]) AS [Purchases @ AWP]
            FROM
            (
                SELECT d.GPI
                     , d.Description
                     , SUM(d.Doses) AS [Purchase Qty]
                     , SUM(d.Doses) * d.AWPPerDose AS [Purchases @ AWP]
                FROM
                (
                    SELECT b.NDC
                         , b.GPI
                         , b.Description
                         , v.InvoiceDate
                         , v.InvoiceNumber
                         , a.CAHInvoiceQuantity AS Qty
                         , b.PackageSize
                         , b.PackageQuantity
                         , a.CAHInvoiceQuantity * b.PackageSize * b.PackageQuantity AS Doses
                         , b.AWPPerDose
                    FROM SalesDDS.dbo.SalesFact_CAH AS a
                         INNER JOIN SalesDDS.dbo.EventDimCAH AS v ON a.CAHEventKey = v.EventKey
                                                                     AND a.CAHEventDateKey = v.DateKey
                         INNER JOIN
                    (
                        SELECT t1.NDC
                             , t1.GPI
                             , t1.DrugKey
                             , t1.Description
                             , t1.PackageSize
                             , t1.PackageQuantity
                             , t1.AWPPerDose
                        FROM SalesDDS.dbo.DrugDim AS t1
                        WHERE t1.IsRX = 1
                    ) AS b ON a.DrugKey = b.DrugKey
                         INNER JOIN
                    (
                        SELECT t2.TheDate
                             , t2.DateKey
                        FROM SalesDDS.dbo.DateDim AS T2
                        WHERE t2.TheDate >= DATEADD(day, -91, GETDATE())
                    ) AS c ON a.DateKey = c.DateKey
                         INNER JOIN
                    (
                        SELECT DISTINCT 
                               t3.PMID
                             , t3.APINumber
                             , t3.PharmacyKey
                        FROM RXMaster.dbo.PharmacyDim AS t3
                        WHERE t3.PMID = @PMID
                    ) AS o ON a.PharmacyKey = o.PharmacyKey
                ) AS d
                GROUP BY d.GPI
                       , d.Description
                       , d.AWPPerDose
            ) AS y
            GROUP BY y.GPI
                   , y.Description;

     -- FDS -- 
     INSERT INTO @TempFDS
            SELECT z.GPI
                 , z.Description
                 , SUM(z.[Dispense Qty]) AS [Dispense Qty]
                 , SUM(z.[Dispense @ AWP]) AS [Dispense @ AWP]
            FROM
            (
                SELECT t2.GPI
                     , t2.Description
                     , SUM(t1.QuantityDispensed) AS [Dispense Qty]
                     , CAST(SUM(t1.QuantityDispensed) * (t2.AWPPerDose) AS DECIMAL(18, 2)) AS [Dispense @ AWP]
                FROM ClaimsDDS.dbo.ClaimFactFDS AS t1
                     INNER JOIN
                (
                    SELECT DateKey
                    FROM ClaimsDDS.dbo.DateDim
                    WHERE TheDate >= DATEADD(day, -91, GETDATE())
                ) AS dd ON t1.DateofServiceKey = dd.DateKey
                     INNER JOIN ClaimsDDS.dbo.DrugDim AS t2 ON t1.DrugKey = t2.DrugKey
                     INNER JOIN ClaimsDDS.dbo.EventDimFDS AS t3 ON t1.EventKey = t3.EventKey
                     INNER JOIN ClaimsDDS.dbo.PharmacyDim AS t4 ON t1.PharmacyKey = t4.PharmacyKey
                WHERE t2.NDC <> 'UNKNOWN'
                      AND t4.PMID = @PMID
                      AND t2.IsRX = 1
                      AND t2.IsOTC = 0
                      AND t3.PayerSequence = 1
                      AND t3.ClaimStatusCode IN('C', 'P')
                --AND t2.Description NOT LIKE  '%*%'
                GROUP BY t2.GPI
                       , t2.Description
                       , t2.AWPPerDose
            ) AS z
            GROUP BY z.GPI
                   , z.Description;

     --Combined --
     SELECT a.GPI
          , a.Description
          , ISNULL(b.[Purchase Qty], 0) + ISNULL(c.[Purchase Qty], 0) AS [Purchase Qty]
          , ISNULL(b.[Purchases @ AWP], 0) + ISNULL(c.[Purchases @ AWP], 0) AS [Purchases @ AWP]
          , a.[Dispense Qty]
          , a.[Dispense @ AWP]
          , a.[Dispense Qty] - (ISNULL(b.[Purchase Qty], 0) + ISNULL(c.[Purchase Qty], 0)) AS [Leakage Quantity]
          , a.[Dispense @ AWP] - (ISNULL(b.[Purchases @ AWP], 0) + ISNULL(c.[Purchases @ AWP], 0)) AS [Leakage @ AWP]
     FROM @TempFDS AS a
          LEFT JOIN @TempAPI AS b ON a.GPI = b.GPI
          LEFT JOIN @TempCAH AS c ON a.GPI = c.GPI
     WHERE a.GPI IS NOT NULL
     ORDER BY a.GPI;
GO
