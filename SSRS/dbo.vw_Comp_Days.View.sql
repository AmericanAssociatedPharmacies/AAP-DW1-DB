USE [SSRS]
GO
/****** Object:  View [dbo].[vw_Comp_Days]    Script Date: 12/22/2020 8:05:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[vw_Comp_Days]
AS
     SELECT z.PMID
     FROM
     (
         SELECT t5.PMID
              , DATEDIFF(y, MIN(t2.Date), MAX(t2.Date)) AS Days
         FROM ClaimsDDS.dbo.ClaimFactFDS AS t1
              INNER JOIN
         (
             SELECT t2.DateKey
                  , t2.TheDate AS Date
             FROM SalesDDS.dbo.DateDim AS T2
             WHERE t2.TheDate >= DATEADD(day, -91, DATEADD(d, 0, DATEDIFF(d, 0, GETDATE())))
                   AND t2.TheDate <= GETDATE()
         ) AS t2 ON t1.DateofServiceKey = t2.DateKey
              INNER JOIN ClaimsDDS.dbo.DrugDim AS t3 ON t1.DrugKey = t3.DrugKey
              INNER JOIN ClaimsDDS.dbo.EventDimFDS AS t4 ON t1.EventKey = t4.EventKey
              INNER JOIN ClaimsDDS.dbo.PharmacyDim AS t5 ON t1.PharmacyKey = t5.PharmacyKey
         GROUP BY t5.PMID
     ) AS z
-- Where does this need to be ?
WHERE z.Days >= 50
GO
