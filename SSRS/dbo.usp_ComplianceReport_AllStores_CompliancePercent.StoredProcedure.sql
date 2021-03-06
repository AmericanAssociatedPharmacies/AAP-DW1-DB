USE [SSRS]
GO
/****** Object:  StoredProcedure [dbo].[usp_ComplianceReport_AllStores_CompliancePercent]    Script Date: 12/22/2020 8:05:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[usp_ComplianceReport_AllStores_CompliancePercent]

			@StartDate DATE
			, @EndDate DATE

AS

SET NOCOUNT ON;

BEGIN

DECLARE @StartDateKey INT
, @EndDateKey INT


	SELECT @StartDateKey = CAST(CONVERT(VARCHAR(20),[FirstDayOfMonth],112) as INT) 
	FROM SalesDDS.dbo.DateDim
	WHERE TheDate = @StartDate

	SELECT @EndDateKey = CAST(CONVERT(VARCHAR(20),[FirstDayOfMonth],112) as INT) 
	FROM SalesDDS.dbo.DateDim
	WHERE TheDate =  @EndDate


	SELECT dt.PMID
	, dd.PharmacyName
	, dt.CompliancePercent 
	FROM(SELECT PMID
			, CONVERT(DECIMAL(6,2),AVG([CompliancePercent])) AS CompliancePercent		
			FROM Reports.[dbo].[ComplianceAllStores]
			WHERE DateKey BETWEEN @StartDateKey AND @EndDateKey
			GROUP BY PMID
		) AS dt
	INNER JOIN RXMaster.dbo.PharmacyDim AS dd ON dd.PMID = dt.PMID
	ORDER BY dt.PMID ASC

END


/*

SELECT dt.PMID
	, dd.PharmacyName
	, CONVERT(DECIMAL(6,2),(SUM(PurchasesIP)/NULLIF(SUM(DispensedIP),0))) AS CompliancePercent --Removed *100 so that its a deciaml DAB 6/22
	FROM(SELECT dt.PMID, dt.GPI
			, FDSQuantityDispensed * ISNULL(ISNULL(ISNULL(APIInvoicePerDose,CAHInvoicePerDose), APIPricePerUnit), CAHPricePerUnit) AS DispensedIP
			, ISNULL(APIPurchasedAtIP,0.00) + ISNULL(CAHPurchasedAtIP,0.00) AS PurchasesIP
			FROM(SELECT PMID 
					, GPI
					, CONVERT(DECIMAL(18,2),SUM([QuantityDispensed])) AS FDSQuantityDispensed
					FROM ClaimsDDS.[dbo].[FDSComplianceReport]
					WHERE DateKey BETWEEN @StartDateKey AND @EndDateKey
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
									FROM SalesDDS.dbo.APIComplianceReport
									WHERE InvoiceDate BETWEEN @StartDate AND @EndDate
									AND [Doses] = ([Doses] + 0) -- Do not remove. Required for peformance!
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
									, CAST(SUM(Doses) * (InvoicePerDose2) AS DECIMAL(18, 2)) AS CAHPurchasedAtIP
									, AVG(InvoicePerDose2) AS CAHInvoicePerDose
									FROM SalesDDS.dbo.CAHComplianceReport
									WHERE InvoiceDate BETWEEN @StartDate AND @EndDate
									AND [Doses] = ([Doses] + 0) -- Do not remove. Required for peformance!
									GROUP BY PMID, GPI, InvoicePerDose2 
								) AS dt
							GROUP BY dt.PMID, dt.GPI
							) AS c ON c.PMID = dt.PMID	
									AND c.GPI = dt.GPI
			LEFT OUTER JOIN(SELECT dd.GPI
							, MIN(a.APIPricePerUnit) AS APIPricePerUnit
							FROM ODSIntake.[dbo].[vwAPIPricing] AS a
							INNER JOIN DrugMaster.dbo.DrugDim AS dd ON a.NDC = dd.NDC
							INNER JOIN DrugMaster.dbo.APICatalog AS ac ON ac.NDC = dd.NDC
							WHERE ac.[ProductHandlingStatusCode] = 'Active'
							GROUP BY dd.GPI 
							) AS agpi ON agpi.GPI = dt.GPI
			LEFT OUTER JOIN(SELECT dd.GPI
							,MIN(CONVERT(DECIMAL(10,4), c.InvoicePrice/(dd.PackageSize*dd.PackageQuantity))) AS CAHPricePerUnit
							FROM CAHODS.dbo.CardinalComplete AS c
							INNER JOIN DrugMaster.dbo.DrugDim AS dd ON c.NDC = dd.NDC
							GROUP BY dd.GPI
							) AS cgpi ON cgpi.GPI = dt.GPI
		) AS dt
	INNER JOIN RXMaster.dbo.PharmacyDim AS dd ON dd.PMID = dt.PMID
	GROUP BY dt.PMID, dd.PharmacyName
	ORDER BY dt.PMID ASC









*/

GO
