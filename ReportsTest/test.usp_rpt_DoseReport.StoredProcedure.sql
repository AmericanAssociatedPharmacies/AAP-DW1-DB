USE [ReportsTest]
GO
/****** Object:  StoredProcedure [test].[usp_rpt_DoseReport]    Script Date: 12/22/2020 7:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [test].[usp_rpt_DoseReport] 
AS 
SELECT dd.MonthOfYear
     , dd.Year AS Yr
     , t2.UnitofMeasure
     , t2.PackageSize
     , SUM(t1.APIInvoiceQuantity) AS Qty
     , CASE
           WHEN t2.UnitofMeasure = 'ML'
           THEN((SUM(t1.APIInvoiceQuantity) * t2.PackageSize) / 5)
           ELSE(SUM(t1.APIInvoiceQuantity) * t2.PackageSize)
       END AS TotalDose
FROM SalesDDS.dbo.SalesFact_API AS t1
INNER JOIN SalesDDS.dbo.DateDim AS dd ON t1.DateKey = dd.DateKey
INNER JOIN SalesDDS.dbo.DrugDim AS t2 ON t1.DrugKey = t2.DrugKey
INNER JOIN SalesDDS.dbo.EventDimAPI AS t3 ON t1.APIEventKey = t3.EventKey
                                                              AND t1.APIEventDateKey = t3.DateKey
WHERE dd.Year >= (YEAR(GETDATE())-2)
      AND t3.Type = 'Generic'
AND t3.IsCredit = 0
AND t3.IsOrderFee = 0
AND t3.IsSourceDelete = 0
AND t1.APIExtendedAmount > 0
AND t2.NDC <> 'UNKNOWN'
GROUP BY dd.MonthOfYear
       , dd.Year
       , t2.UnitofMeasure
       , t2.PackageSize
ORDER BY dd.Year ASC
              , dd.MonthOfYear ASC
       , t2.UnitofMeasure ASC
       , t2.PackageSize ASC
GO
