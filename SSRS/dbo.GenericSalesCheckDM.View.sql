USE [SSRS]
GO
/****** Object:  View [dbo].[GenericSalesCheckDM]    Script Date: 12/22/2020 8:05:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--YTD Sales by PMID

CREATE VIEW [dbo].[GenericSalesCheckDM] AS 
SELECT d.PMID, 
       SUM(a.APIExtendedAmount) AS Sales
FROM SalesDDS.dbo.SalesFact_API AS a
     INNER JOIN SalesDDS.dbo.EventDimAPI AS b ON a.APIEventKey = b.EventKey
                                                 AND a.DateKey = b.DateKey
     INNER JOIN SalesDDS.dbo.DateDim AS c ON a.DateKey = c.DateKey
     INNER JOIN SalesDDS.dbo.PharmacyDim AS d ON a.PharmacyKey = d.PharmacyKey
     INNER JOIN SalesDDS.dbo.DrugDim AS e ON a.DrugKey = e.DrugKey
WHERE b.Type = 'Generic'
      AND YEAR(c.TheDate) = 2019
GROUP BY d.PMID
GO
