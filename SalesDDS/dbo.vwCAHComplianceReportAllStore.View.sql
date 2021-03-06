USE [SalesDDS]
GO
/****** Object:  View [dbo].[vwCAHComplianceReportAllStore]    Script Date: 12/22/2020 7:55:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [dbo].[vwCAHComplianceReportAllStore]


AS




SELECT pd.PMID
, c.DateKey
, dd.GPI		
, dd.IsGeneric
, SUM(ISNULL((c.[CAHInvoiceQuantity] * (dd.PackageSize * dd.PackageQuantity)),0.0)) AS Doses
, SUM(ISNULL(c.[CAHExtendedSales]/ (c.[CAHInvoiceQuantity] * dd.PackageSize * dd.PackageQuantity),0.00)) AS [InvoicePerDose]
, COUNT_BIG(*) AS COUNT
FROM dbo.SalesFact_CAH AS c
INNER JOIN dbo.EventDimCAH AS e ON c.[CAHEventKey] = e.EventKey
										AND c.[CAHEventDateKey] = e.DateKey
INNER JOIN dbo.PharmacyDim AS pd ON c.PharmacyKey = pd.PharmacyKey
INNER JOIN dbo.DrugDim AS dd ON c.DrugKey = dd.DrugKey	
WHERE c.[CAHInvoiceQuantity] > 0 
AND pd.PMID > 0
AND e.ItemType = 'RX'
GROUP BY pd.PMID
, c.DateKey
, dd.GPI		
, dd.IsGeneric
GO
