USE [SSRS]
GO
/****** Object:  View [dbo].[vw_GXUnits_CAH]    Script Date: 12/22/2020 8:05:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vw_GXUnits_CAH]
AS
     SELECT d.PMID, 
            e.MonthOfYear AS Month, 
            e.[Year] AS Year, 
            SUM(a.CAHInvoiceQuantity) AS Units
     FROM SalesDDS.dbo.SalesFact_CAH  AS a
          INNER JOIN SalesDDS.dbo.EventDimAPI AS b ON a.CAHEventKey = b.EventKey
                                                      AND a.DateKey = b.DateKey
          INNER JOIN SalesDDS.dbo.DrugDim AS c ON a.DrugKey = c.DrugKey
          INNER JOIN SalesDDS.dbo.PharmacyDim AS d ON a.PharmacyKey = d.PharmacyKey
          INNER JOIN
     (
         SELECT *
         FROM SalesDDS.dbo.DateDim AS t1
         WHERE t1.YEAR = (YEAR(GETDATE()) - 2)
     ) AS e ON a.DateKey = e.DateKey
     WHERE d.PMID <> 0
           AND c.IsGenericNonOTC = 1
     GROUP BY d.PMID, 
              e.MonthOfYear, 
              e.[Year];
GO
