USE [ReportsTest]
GO
/****** Object:  StoredProcedure [test].[usp_sisense_Price_Avg]    Script Date: 12/22/2020 7:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [test].[usp_sisense_Price_Avg]
AS
SELECT *
FROM
(
    SELECT cd.CAHItemNumber
         , cd.NDC
         , AVG(pf.NADACPrice) AS AVG_NADAC
         , AVG(pf.CardinalInvoicePrice) AS AVG_CAH
         , AVG(pf.APICustomerInvoicePrice) AS AVG_API
	    , (AVG(pf.CardinalInvoicePrice)-AVG(pf.NADACPrice))/ AVG(pf.NADACPrice) AS Delta
         , MONTH(pf.RowCreatedDate) AS Mnth
         , YEAR(pf.RowCreatedDate) AS Yr
         , CASE
               WHEN AVG(pf.CardinalInvoicePrice) > (AVG(pf.NADACPrice) * 1.05)
               THEN 1
               ELSE 0
           END AS Flag
    FROM Pricing.dbo.CompetitorDrugDim AS cd
         JOIN Pricing.dbo.PriceFact AS pf ON cd.CompetitorDrugKey = pf.CompetitorDrugKey
    WHERE cd.CAHItemNumber IS NOT NULL
          AND pf.NADACPrice IS NOT NULL
      --AND cd.RowCreatedDate >= @DK
	 --AND pf.CompetitorDrugKey = '8596873'
    GROUP BY cd.CAHItemNumber
           , cd.NDC
           , MONTH(pf.RowCreatedDate)
           , YEAR(pf.RowCreatedDate)
) AS t1
ORDER BY t1.NDC
       , t1.Mnth
       , t1.Yr ASC;


/*
SELECT t2.NDC
     , MONTH(t2.InvDate) AS mnth
     , YEAR(t2.InvDate) AS yr
     , SUM(t2.Qty) AS TotalUnits
FROM API.dbo.APISalesDetail AS t2
WHERE t2.InvDate >= '20170101'
AND t2.NDC IS NOT NULL
GROUP BY t2.NDC
       , YEAR(t2.InvDate) 
	  , MONTH(t2.InvDate)
ORDER BY t2.NDC
       , YEAR(t2.InvDate) ASC
	  , MONTH(t2.InvDate); 


SELECT TOP 100 *
FROM API.dbo.APISalesDetail


SELECT
SUM(sd.Qty) AS TotalUnits
FROM API.dbo.APISalesDetail AS SD


SELECT TOP 100
*
FROM rx30.dbo.DateDim



SELECT TOP 100 *
FROM  Pricing.dbo.CompetitorDrugDim
ORDER BY Pricing.dbo.CompetitorDrugDim.DateKey DESC


SELECT TOP 100 *
FROM Pricing.dbo.PriceFact AS pf
WHERE pf.CompetitorDrugKey = '8596873'

SELECT
*
FROM RX30.dbo.DrugDim AS DD
WHERE dd.NDC = '27808003703'


SELECT *
FROM API.dbo.APISalesDetail AS t1
WHERE t1.InvDate > '20180601'
AND t1.ItemDescription  LIKE '%HYDROCODONE%'


SELECT TOP 100 *
FROM Pricing.dbo.PriceFact
WHERE Pricing.dbo.PriceFact.DateKey >= 20170101
AND Pricing.dbo.PriceFact.CardinalInvoicePrice IS NOT NULL
AND Pricing.dbo.PriceFact.APICustomerInvoicePrice IS NOT NULL 

SELECT TOP 100 *
FROM Pricing.Staging.CardinalCatalog

*/
GO
