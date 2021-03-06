USE [Analysis]
GO
/****** Object:  View [dbo].[vw_CompanyGoals_Goal3]    Script Date: 12/22/2020 6:06:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vw_CompanyGoals_Goal3]
AS
--API Sales 
WITH CTE_APIMonthly(Year
                  , Month
                  , PMID
                  , APIGenerics
                  , APIBrands
                  , APIOTCs
                  , APIMonthlySalesTotal)
     AS (
     SELECT YEAR(d.Date) AS Year
          , MONTH(d.Date) AS Month
          , d.PMID
          , d.[API Generic Sales] AS APIGenerics -- As defined by the API catalog 
          , d.[API Brand Sales] AS APIBrands -- As defined by the API catalog 
          , d.[API OTC Sales] AS APIOTCs -- As defined by the API catalog 
          , (d.[API Generic Sales] + d.[API Brand Sales] + d.[API OTC Sales]) AS APIMonthlySalesTotal
     FROM
(
    SELECT a.PMID
         , b.LinkedPMIDs
    FROM PharmacyMaster.dbo.PM_Pharmacy AS a
         LEFT JOIN WebDev.dbo.RebateLinkedPMIDs AS b ON a.PMID = b.PMID
) AS c
LEFT JOIN PharmacyMaster.dbo.PM_Rebates_APIMonthly AS d ON d.PMID = c.PMID
                                                           OR d.PMID = c.LinkedPMIDs
     WHERE d.Date >= DATEFROMPARTS(DATEPART(yyyy, GETDATE()) - 1, 1, 1)
           AND d.Date <= DATEADD(yy, DATEDIFF(yy, 0, GETDATE()) + 1, -1))

-- Cardinal Health Monthly
     ,CTE_CAHMonthly(Year
                   , Month
                   , PMID
                   , CAHBrandRx
                   , CAHExcludedRx
                   , CAHSourceGenericRx
                   , CAHNonContractGenericRx
                   , CAHOTC
                   , CAHSuppliesOther
                   , CAHMonthlySalesTotal)
     AS (
     SELECT YEAR(e.date) AS Year
          , MONTH(e.Date) AS Month
          , e.PMID
          , (e.AAPBrand - e.AAPExcludedFromTotalRX) AS CAHBrandRx --brand rx 
          , e.AAPExcludedFromTotalRX AS CAHExcludedRx --excluded rx 
          , e.AAPGENTotalSrc AS CAHSourceGenericRx --source generic rx 
          , (e.AAPTotalRX - e.AAPBrand - e.AAPGENTotalSrc) AS CAHNonContractGenericRx
          , e.AAPOTC AS CAHOTC
          , (e.AAPNonRXOTCandHH - e.AAPOTC) AS CAHSuppliesOther
          , ((e.AAPBrand - e.AAPExcludedFromTotalRX) + e.AAPExcludedFromTotalRX + e.AAPGENTotalSrc + (e.AAPTotalRX - e.AAPBrand - e.AAPGENTotalSrc) + e.AAPOTC + (e.AAPNonRXOTCandHH - e.AAPOTC)) AS CAHMonthlySalesTotal
     FROM
(
    SELECT a.PMID
         , b.LinkedPMIDs
    FROM PharmacyMaster.dbo.PM_Pharmacy AS a
         LEFT JOIN WebDev.dbo.RebateLinkedPMIDs AS b ON a.PMID = b.PMID
) AS c
LEFT JOIN [PharmacyMaster].dbo.ALL_Volume_New AS e ON e.PMID = c.PMID
                                                      OR e.PMID = c.LinkedPMIDs
     WHERE e.Date >= DATEFROMPARTS(DATEPART(yyyy, GETDATE()) - 1, 1, 1)
           AND e.Date <= DATEADD(yy, DATEDIFF(yy, 0, GETDATE()) + 1, -1))

--Combnined 

     SELECT d4.Year
          , d4.Month
          , SUM(d4.Qulified) AS QMemberCount
     FROM
(
    SELECT d3.PMID
         , d3.Year
         , d3.Month
         , d3.APIMonthlySalesTotal
         , d3.CAHMonthlySalesTotal
         , d3.Total
         , CASE
               WHEN d3.Total > 50000
               THEN 1
               ELSE 0
           END AS Qulified
    FROM
(
    SELECT d1.PMID
         , d1.Year
         , d1.Month
         , d2.APIMonthlySalesTotal
         , d1.CAHMonthlySalesTotal
         , (d2.APIMonthlySalesTotal + d1.CAHMonthlySalesTotal) AS Total
    FROM CTE_CAHMonthly AS d1 
--RIGHT JOIN PharmacyMaster.dbo.PM_Pharmacy AS d3 ON d1.PMID = d3.PMID
         LEFT JOIN CTE_APIMonthly AS d2 ON d1.PMID = d2.PMID
                                           AND d1.Year = d2.Year
                                           AND d1.Month = d2.Month
) AS d3
) AS d4
     GROUP BY d4.Year
            , d4.Month
    

GO
