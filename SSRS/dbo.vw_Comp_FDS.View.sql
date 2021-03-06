USE [SSRS]
GO
/****** Object:  View [dbo].[vw_Comp_FDS]    Script Date: 12/22/2020 8:05:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE VIEW [dbo].[vw_Comp_FDS]
AS
     SELECT t9.PMID
          , SUM(t9.[Dispense Qty]) AS [Dispense Qty]
          , SUM(t9.[Dispense @ AWP]) AS [Dispense @ AWP]
     FROM
     (
         SELECT z.PMID
              , z.GPI
              , z.Description
              , SUM(z.[Dispense Qty]) AS [Dispense Qty]
              , SUM(z.[Dispense @ AWP]) AS [Dispense @ AWP]
         FROM
         (
             SELECT t2.GPI
                  , t4.PMID
                  , t2.Description
                  , SUM(t1.QuantityDispensed) AS [Dispense Qty]
                  , CAST(SUM(t1.QuantityDispensed) * (t2.AWPPerDose) AS DECIMAL(18, 2)) AS [Dispense @ AWP]
             FROM ClaimsDDS.dbo.ClaimFactFDS AS t1
                  INNER JOIN
             (
                 SELECT DateKey
                 FROM ClaimsDDS.dbo.DateDim
                 WHERE TheDate >= DATEADD(day, -91, DATEADD(d, 0, DATEDIFF(d, 0, GETDATE())))
				 AND TheDate <= GETDATE()
             ) AS dd ON t1.DateofServiceKey = dd.DateKey
                  INNER JOIN ClaimsDDS.dbo.DrugDim AS t2 ON t1.DrugKey = t2.DrugKey
                  INNER JOIN ClaimsDDS.dbo.EventDimFDS AS t3 ON t1.EventKey = t3.EventKey
                  INNER JOIN ClaimsDDS.dbo.PharmacyDim AS t4 ON t1.PharmacyKey = t4.PharmacyKey
             WHERE t2.NDC <> 'UNKNOWN'
                   AND t2.IsRX = 1
                   AND t2.IsOTC = 0
				   AND t2.Strength IS NOT NULL
                   AND t3.PayerSequence = 1
                   AND t3.ClaimStatusCode IN('C', 'P')
             GROUP BY t2.GPI
                    , t4.PMID
                    , t2.Description
                    , t2.AWPPerDose
         ) AS z
         GROUP BY z.GPI
                , z.PMID
                , z.Description
     ) AS t9
     GROUP BY t9.PMID;
GO
