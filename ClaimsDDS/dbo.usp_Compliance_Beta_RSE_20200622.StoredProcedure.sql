USE [ClaimsDDS]
GO
/****** Object:  StoredProcedure [dbo].[usp_Compliance_Beta_RSE_20200622]    Script Date: 12/22/2020 6:54:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_Compliance_Beta_RSE_20200622]

		@PMID INT
		, @StartDate DATETIME
		, @EndDate DATETIME


AS

BEGIN

DECLARE @StartDateKey INT
, @EndDateKey INT


SELECT @StartDateKey = DateKey
FROM SalesDDS.dbo.DateDim
WHERE TheDate = @StartDate


SELECT @EndDateKey = DateKey
FROM SalesDDS.dbo.DateDim
WHERE TheDate = @EndDate

	SELECT dt.GPI
	, ca.Description
	, dt.PurchaseQty AS [Purchase Qty]
	, PurchasesIP AS [Purchases @ IP]
	, dt.DispenseQty AS [Dispense Qty]
	, ISNULL(dt.DispensedIP, (dt.DispenseQty * (ISNULL(agpi.APIPricePerUnit, cgpi.CAHPricePerUnit)))) AS [Dispense @ IP]
	, (dt.PurchaseQty - DispenseQty) AS [Leakage Quantity]
	, ISNULL(dt.PurchasesIP, 0) - (ISNULL(dt.DispensedIP, (dt.DispenseQty * (ISNULL(agpi.APIPricePerUnit, cgpi.CAHPricePerUnit))))) AS [Leakage @ IP]
	FROM(SELECT dt.GPI
		, CONVERT(DECIMAL(18,2),FDSQuantityDispensed * ISNULL(a.APIInvoicePerDose,c.CAHInvoicePerDose)) AS DispensedIP
		, ISNULL(a.APIPurchasedAtIP,0.00) + ISNULL(c.CAHPurchasedAtIP,0.00) AS PurchasesIP
		, ISNULL(a.APIPurchaseQty,0.00) + ISNULL(c.CAHPurchaseQty,0.00) AS PurchaseQty
		, FDSQuantityDispensed  AS DispenseQty
		FROM(SELECT PMID 
				, GPI
				, CONVERT(DECIMAL(18,2),SUM([QuantityDispensed])) AS FDSQuantityDispensed
				FROM ClaimsDDS.[dbo].[vwFDSComplianceReport]
				WHERE DateKey BETWEEN @StartDateKey AND @EndDateKey
				AND PMID = @PMID
				AND QuantityDispensed = (0 + QuantityDispensed) -- Do not remove. Required for peformance!
				GROUP BY PMID
				, GPI
				) AS dt
		LEFT OUTER JOIN(SELECT dt.PMID
						, dt.GPI
						, SUM(dt.APIPurchaseQty) AS APIPurchaseQty
						, SUM(dt.APIPurchasedAtIP) AS APIPurchasedAtIP
						, AVG(dt.APIInvoicePerDose) AS APIInvoicePerDose
						FROM(SELECT PMID
								, GPI
								, SUM(Doses) AS APIPurchaseQty
								, CAST(SUM(Doses) * (InvoicePerDose)AS DECIMAL(18, 2)) AS APIPurchasedAtIP
								, AVG(InvoicePerDose) AS APIInvoicePerDose
								FROM SalesDDS.dbo.vwAPIComplianceReport
								WHERE DateKey BETWEEN @StartDateKey AND @EndDateKey
								AND [Doses] = ([Doses] + 0) -- Do not remove. Required for peformance!
								AND PMID = @PMID
								GROUP BY PMID, GPI, InvoicePerDose
							) AS dt
						GROUP BY dt.PMID, dt.GPI
						) AS a ON dt.PMID = a.PMID
									AND dt.GPI = a.GPI
		LEFT OUTER JOIN(SELECT dt.PMID
						, dt.GPI
						, SUM(dt.CAHPurchaseQty) AS CAHPurchaseQty
						, SUM(dt.CAHPurchasedAtIP) AS CAHPurchasedAtIP
						, AVG(dt.CAHInvoicePerDose) AS CAHInvoicePerDose							
						FROM (SELECT PMID
								, LTRIM(RTRIM(GPI)) AS GPI
								, SUM(Doses) AS CAHPurchaseQty
								, CAST(SUM(Doses) * (InvoicePerDose) AS DECIMAL(18, 2)) AS CAHPurchasedAtIP
								, AVG(InvoicePerDose) AS CAHInvoicePerDose
								FROM SalesDDS.dbo.vwCAHComplianceReport
								WHERE DateKey BETWEEN @StartDateKey AND @EndDateKey
								AND [Doses] = ([Doses] + 0) -- Do not remove. Required for peformance!
								AND PMID = @PMID
								GROUP BY PMID, GPI, InvoicePerDose
							) AS dt
						GROUP BY dt.PMID, dt.GPI
						) AS c ON c.PMID = dt.PMID	
								AND c.GPI = dt.GPI

				) AS dt
	LEFT OUTER JOIN(SELECT dd.GPI
						, MIN(a.APIPricePerUnit) AS APIPricePerUnit
						FROM ODSIntake.[dbo].[vwAPIPricing] AS a
						INNER JOIN DrugMaster.dbo.DrugDim AS dd ON a.NDC = dd.NDC
						INNER JOIN DrugMaster.dbo.APICatalog AS ac ON ac.NDC = dd.NDC
						GROUP BY dd.GPI 
						) AS agpi ON agpi.GPI = dt.GPI
	LEFT OUTER JOIN(SELECT dd.GPI
						,MIN(CONVERT(DECIMAL(10,4), c.InvoicePrice/(dd.PackageSize*dd.PackageQuantity))) AS CAHPricePerUnit
						FROM CAHODS.dbo.CardinalComplete AS c
						INNER JOIN DrugMaster.dbo.DrugDim AS dd ON c.NDC = dd.NDC
						GROUP BY dd.GPI
						) AS cgpi ON cgpi.GPI = dt.GPI
	CROSS APPLY(SELECT DISTINCT GPI, Description
				FROM DrugMaster.dbo.DrugDim AS dd
				WHERE dt.GPI = dd.GPI
				) AS ca
	WHERE dt.GPI = ca.GPI
	ORDER BY dt.GPI ASC



END
GO
