USE [SalesDDS]
GO
/****** Object:  View [dbo].[vwAPIComplianceReportAllStore]    Script Date: 12/22/2020 7:55:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [dbo].[vwAPIComplianceReportAllStore]

WITH SCHEMABINDING

AS




SELECT pd.PMID
, a.DateKey
, dd.GPI		
, dd.IsGeneric
--, ISNULL(SUM(a.[APIInvoiceQuantity]),0.00) * (dd.PackageSize * dd.PackageQuantity) AS Doses
, SUM(ISNULL(a.[APIInvoiceQuantity],0.00)) AS APIInvoiceQuantity
, a.APIExtendedAmount
, dd.PackageSize
, PackageQuantity
--, AVG(a.APIExtendedAmount)/ (a.[APIInvoiceQuantity] * (dd.PackageSize * dd.PackageQuantity))) AS [InvoicePerDose]
, COUNT_BIG(*) AS COUNT
FROM dbo.SalesFact_API AS a
INNER JOIN dbo.EventDimAPI AS e ON a.[APIEventKey] = e.EventKey
										AND a.[APIEventDateKey] = e.DateKey
INNER JOIN dbo.PharmacyDim AS pd ON a.PharmacyKey = pd.PharmacyKey
INNER JOIN dbo.DrugDim AS dd ON a.DrugKey = dd.DrugKey	
WHERE e.IsCredit = 0
AND a.[APIInvoiceQuantity] > 0
AND pd.PMID > 0
GROUP BY pd.PMID
, a.DateKey
, dd.GPI		
, dd.IsGeneric
, a.APIExtendedAmount
, dd.PackageSize
, dd.PackageQuantity



GO
