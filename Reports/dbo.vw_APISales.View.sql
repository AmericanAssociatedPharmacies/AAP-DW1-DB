USE [Reports]
GO
/****** Object:  View [dbo].[vw_APISales]    Script Date: 12/22/2020 7:39:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO








CREATE VIEW [dbo].[vw_APISales]

AS

SELECT PMID
, APIAccountNo
, Date
, [API Generic Sales] AS [APIGenericSales]
, [API Brand Sales] AS APIBrandSales
, [API OTC Sales] AS APIOTCSales
, [APIGenericSalesTier1] AS APIGenericSalesTier1
, [APIGenericSalesTier2] AS APIGenericSalesTier2
FROM pharmacymaster.dbo.pm_rebates_APIMonthly

UNION

SELECT m.PMID
, m.APIAccountNo
, m.Date
, m.GenericSales
, m.BrandSales
, m.OTCSales
, m.GenericSalesTier1
, m.GenericSalesTier2
FROM  Reports.dbo.APISalesUnaudited_Monthly AS m
LEFT OUTER JOIN(SELECT PMID	
				, MAX(Date) AS MaxDate
				FROM pharmacymaster.dbo.pm_rebates_APIMonthly
				GROUP BY PMID	
				) AS dt ON m.PMID = dt.PMID
WHERE m.Date > ISNULL(dt.MaxDate, '19000101')

/*

SELECT DISTINCT ISNULL(a.PMID, u.PMID) AS PMID
, ISNULL(a.APIAccountNo, u.APIAccountNo) AS APIAccountNo
, ISNULL(a.Date, u.Date) AS Date
, ISNULL(a.[API Generic Sales], u.GenericSales) AS [APIGenericSales]
, ISNULL(a.[API Brand Sales], u.[BrandSales]) AS APIBrandSales
, ISNULL(a.[API OTC Sales], u.OTCSales) AS APIOTCSales
, ISNULL(a.[APIGenericSalesTier1], u.GenericSalesTier1) AS APIGenericSalesTier1
, ISNULL(a.[APIGenericSalesTier2], u.GenericSalesTier2) AS APIGenericSalesTier2
FROM Reports.dbo.APISalesUnaudited_Monthly AS u
LEFT OUTER JOIN pharmacymaster.dbo.pm_rebates_APIMonthly AS a ON a.APIAccountNo = u.APIAccountNo
															AND a.PMID = u.PMID
															
CROSS APPLY(SELECT PMID	
			, MAX(Date) AS MaxDate
			FROM pharmacymaster.dbo.pm_rebates_APIMonthly
			GROUP BY PMID
			) AS ca
WHERE (ca.PMID = a.PMID
		AND u.Date > ca.MaxDate
	 )
AND( 
	(a.PMID IS NOT NULL
		OR u.PMID IS NOT NULL
		)
	OR (a.APIAccountNo IS NOT NULL
			OR u.APIAccountNo IS NOT NULL
			)
	OR (a.Date IS NOT NULL
			OR u.Date IS NOT NULL
			)
	OR (a.[API Generic Sales] IS NOT NULL
			OR u.GenericSales IS NOT NULL
			)
	OR (a.[API Brand Sales] IS NOT NULL
			OR u.BrandSales IS NOT NULL
			)
	OR (a.[API OTC Sales] IS NOT NULL
			OR u.OTCSales IS NOT NULL
			)
	OR(a.[APIGenericSalesTier1] IS NULL
		OR u.GenericSalesTier1 IS NULL
		)
	OR(a.[APIGenericSalesTier2] IS NULL
		OR u.GenericSalesTier2 IS NULL
		)
	)

*/





GO
