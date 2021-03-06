USE [ClaimsDDS]
GO
/****** Object:  View [dbo].[vwComplianceReportAllStores]    Script Date: 12/22/2020 6:54:01 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [dbo].[vwComplianceReportAllStores]


AS




SELECT d.FirstDayOfMonth AS Date
, f.PMID
, f.GPI
, ISNULL(SUM(f.[QuantityDispensed]),0.00) AS TotalQuantityDispensed
, ISNULL(SUM(a.[QuantityDispensed]),0.00) AS GenericQuantityDispensed
, ISNULL(SUM(b.[QuantityDispensed]),0.00) AS BrandQuantityDispensed
FROM [dbo].[FDSComplianceReport] AS f
INNER JOIN dbo.DateDim AS d ON f.DateKey = d.DateKey
FULL OUTER JOIN [dbo].[FDSComplianceReport] AS a ON f.DateKey = a.DateKey
													AND f.PMID = a.PMID
													AND f.GPI = a.GPI
													AND a.IsGeneric = 1
FULL OUTER JOIN [dbo].[FDSComplianceReport] AS b ON f.DateKey = b.DateKey
													AND f.PMID = b.PMID
													AND f.GPI = b.GPI
													AND b.IsGeneric = 0

GROUP BY d.FirstDayOfMonth
, f.PMID
, f.GPI
GO
