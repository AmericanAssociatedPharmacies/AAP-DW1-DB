USE [Analysis]
GO
/****** Object:  View [dbo].[APISales]    Script Date: 12/22/2020 6:06:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[APISales]
	AS 
SELECT ISNULL(a.PMID, u.PMID) AS PMID
, ISNULL(a.APIAccountNo, u.APIAccountNo) AS APIAccountNo
, ISNULL(a.Date, u.Date) AS Date
, ISNULL(a.[API Generic Sales], u.GenericSales) AS [APIGenericSales]
, ISNULL(a.[API Brand Sales], u.[BrandSales]) AS APIBrandSales
, ISNULL(a.[API OTC Sales], u.OTCSales) AS APIOTCSales 
FROM [Reports].dbo.APISalesUnaudited_Monthly AS u
LEFT OUTER JOIN [PharmacyMaster].dbo.PM_Rebates_APIMonthly_New AS a ON CONVERT(VARCHAR(15), a.APIAccountNo) = u.APIAccountNo
															AND CONVERT(INT, a.PMID) = u.PMID
															AND a.Date = u.Date
WHERE (a.PMID IS NOT NULL
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
GO
