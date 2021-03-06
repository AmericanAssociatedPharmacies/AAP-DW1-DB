USE [SSRS]
GO
/****** Object:  StoredProcedure [dbo].[usp_ComplianceReport_AllStores_CompliancePercent_RSE_20200629_Test]    Script Date: 12/22/2020 8:05:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[usp_ComplianceReport_AllStores_CompliancePercent_RSE_20200629_Test]

			@StartDate DATE
			, @EndDate DATE

AS

SET NOCOUNT ON;

BEGIN

DECLARE @StartDateKey INT
, @EndDateKey INT


	--SELECT @StartDateKey = DateKey
	--FROM SalesDDS.dbo.DateDim
	--WHERE TheDate = @StartDate

	--SELECT @EndDateKey = DateKey
	--FROM SalesDDS.dbo.DateDim
	--WHERE TheDate = @EndDate


	SELECT dt.PMID
	, pd.PharmacyName
	, CONVERT(DECIMAL(6,2),(SUM(PurchasesIP)/NULLIF(SUM(DispensedIP),0))) AS CompliancePercent --Removed *100 so that its a deciaml DAB 6/22
	, CONVERT(DECIMAL(6,2), ISNULL(((SUM(dt.APIGenericPurchasesIP) + SUM(dt.CAHGenericPurchasesIP))/NULLIF(SUM(GenericDispensedIP),0)),0.00)) AS GenericCompliancePercent
	, CONVERT(DECIMAL(6,2), ISNULL(((SUM(dt.APIBrandPurchasesIP) + SUM(dt.CAHBrandPurchasesIP))/NULLIF(SUM(BrandDispensedIP),0)),0.00)) AS BrandCompliancePercent
	FROM(SELECT c.PMID
			, c.TotalQuantityDispensed * ISNULL(ISNULL(ISNULL(NULLIF(c.APIInvoicePerDose,0),NULLIF(CAHInvoicePerDose,0)), agpi.APIPricePerUnit), cgpi.CAHPricePerUnit) AS DispensedIP
			, c.GenericQuantityDispensed * ISNULL(ISNULL(ISNULL(NULLIF(c.APIGenericInvoicePerDose,0),NULLIF(c.CAHGenericInvoicePerDose,0)), agpi.APIPricePerUnit), cgpi.CAHPricePerUnit) AS GenericDispensedIP
			, c.BrandQuantityDispensed * ISNULL(ISNULL(ISNULL(NULLIF(c.APIBrandInvoicePerDose,0),NULLIF(c.CAHBrandInvoicePerDose,0)), agpi.APIPricePerUnit), cgpi.CAHPricePerUnit) AS BrandDispensedIP	
			, (c.APIPurchasedAtIP + c.CAHPurchasedAtIP) AS PurchasesIP
			, c.APIGenericPurchasedAtIP AS APIGenericPurchasesIP
			, c.APIBrandPurchasedAtIP AS APIBrandPurchasesIP
			, c.CAHGenericPurchasedAtIP AS CAHGenericPurchasesIP
			, c.CAHBrandPurchasedAtIP AS CAHBrandPurchasesIP	
			FROM Reports.[dbo].[ComplianceAllStores] AS c
			LEFT OUTER JOIN(SELECT dd.GPI
							, MIN(a.APIPricePerUnit) AS APIPricePerUnit
							FROM ODSIntake.[dbo].[vwAPIPricing] AS a
							INNER JOIN DrugMaster.dbo.DrugDim AS dd ON a.NDC = dd.NDC
							INNER JOIN DrugMaster.dbo.APICatalog AS ac ON ac.NDC = dd.NDC
							GROUP BY dd.GPI 
							) AS agpi ON agpi.GPI = c.GPI						
			LEFT OUTER JOIN(SELECT dd.GPI
							,MIN(CONVERT(DECIMAL(10,4), c.InvoicePrice/(dd.PackageSize*dd.PackageQuantity))) AS CAHPricePerUnit
							FROM CAHODS.dbo.CardinalComplete AS c
							INNER JOIN DrugMaster.dbo.DrugDim AS dd ON c.NDC = dd.NDC
							GROUP BY dd.GPI
							) AS cgpi ON cgpi.GPI = c.GPI		
			WHERE c.MonthDate BETWEEN @StartDate AND @EndDate
			AND c.PMID = (c.PMID + 0)
		) AS dt
	INNER JOIN RXMaster.dbo.PharmacyDim AS pd ON dt.PMID = pd.PMID
	GROUP BY dt.PMID, pd.PharmacyName
	ORDER BY dt.PMID ASC

END


--SELECT dt.PMID
	--, dd.PharmacyName
	--, CONVERT(DECIMAL(6,2),(SUM(PurchasesIP)/NULLIF(SUM(DispensedIP),0))) AS CompliancePercent --Removed *100 so that its a deciaml DAB 6/22
	--, CONVERT(DECIMAL(6,2), ISNULL(((SUM(dt.APIGenericPurchasesIP) + SUM(dt.CAHGenericPurchasesIP))/NULLIF(SUM(GenericDispensedIP),0)),0.00)) AS GenericCompliancePercent
	--, CONVERT(DECIMAL(6,2), ISNULL(((SUM(dt.APIBrandPurchasesIP) + SUM(dt.CAHBrandPurchasesIP))/NULLIF(SUM(BrandDispensedIP),0)),0.00)) AS BrandCompliancePercent
	--FROM(SELECT dt.PMID
	--		, dt.GPI
	--		, FDSQuantityDispensed * ISNULL(ISNULL(ISNULL(a.APIInvoicePerDose,c.CAHInvoicePerDose), agpi.APIPricePerUnit), cgpi.CAHPricePerUnit) AS DispensedIP
	--		, FDSGenericQuantityDispensed * ISNULL(ISNULL(ISNULL(a.APIGenericInvoicePerDose,c.CAHGenericInvoicePerDose), agpi.APIPricePerUnit), cgpi.CAHPricePerUnit) AS GenericDispensedIP
	--		, FDSBrandQuantityDispensed * ISNULL(ISNULL(ISNULL(a.APIBrandInvoicePerDose,c.CAHBrandInvoicePerDose), agpi.APIPricePerUnit), cgpi.CAHPricePerUnit) AS BrandDispensedIP			
	--		, ISNULL(a.APIPurchasedAtIP,0.00) + ISNULL(c.CAHPurchasedAtIP,0.00) AS PurchasesIP
	--		, ISNULL(a.APIGenericPurchasedAtIP,0.00) AS APIGenericPurchasesIP
	--		, ISNULL(a.APIBrandPurchasedAtIP,0.00) AS APIBrandPurchasesIP
	--		, ISNULL(c.CAHGenericPurchasedAtIP,0.00) AS CAHGenericPurchasesIP
	--		, ISNULL(c.CAHBrandPurchasedAtIP,0.00) AS CAHBrandPurchasesIP
	--		FROM(SELECT dt.PMID
	--			, dt.GPI
	--			, ISNULL(g.FDSGenericQuantityDispensed,0.00) AS FDSGenericQuantityDispensed
	--			, ISNULL(b.FDSBrandQuantityDispensed,0.00) AS FDSBrandQuantityDispensed
	--			, dt.FDSQuantityDispensed
	--			FROM(SELECT PMID 
	--				, GPI
	--				, SUM([QuantityDispensed]) AS FDSQuantityDispensed 
	--				FROM ClaimsDDS.[dbo].[FDSComplianceReport] 
	--				WHERE DateKey BETWEEN @StartDateKey AND @EndDateKey
	--				GROUP BY PMID
	--				, GPI
	--				) AS dt
	--			LEFT OUTER JOIN(SELECT PMID 
	--							, GPI
	--							, SUM([QuantityDispensed]) AS FDSGenericQuantityDispensed
	--							FROM ClaimsDDS.[dbo].[FDSComplianceReport] 
	--							WHERE DateKey BETWEEN @StartDateKey AND @EndDateKey
	--							AND IsGeneric = 1
	--							GROUP BY PMID
	--							, GPI
	--						) AS g ON dt.PMID = g.PMID
	--									AND dt.GPI = g.GPI
	--			LEFT OUTER JOIN(SELECT PMID 
	--							, GPI
	--							, SUM([QuantityDispensed]) AS FDSBrandQuantityDispensed
	--							FROM ClaimsDDS.[dbo].[FDSComplianceReport] 
	--							WHERE DateKey BETWEEN @StartDateKey AND @EndDateKey
	--							AND IsGeneric = 0
	--							GROUP BY PMID
	--							, GPI
	--						) AS b ON dt.PMID = b.PMID
	--									AND dt.GPI = b.GPI
	--	) AS dt
	--LEFT OUTER JOIN(SELECT dt.PMID
	--						, dt.GPI
	--						, SUM(dt.APIPurchaseQty) AS APIPurchaseQty
	--						, SUM(dt.APIPurchasedAtIP) AS APIPurchasedAtIP
	--						, AVG(dt.APIInvoicePerDose) AS APIInvoicePerDose
	--						, SUM(dt.APIGenericPurchaseQty) AS APIGenericPurchaseQty
	--						, SUM(dt.APIBrandPurchaseQty) AS APIBrandPurchaseQty
	--						, SUM(dt.APIGenericPurchasedAtIP) AS APIGenericPurchasedAtIP
	--						, SUM(dt.APIBrandPurchasedAtIP) AS APIBrandPurchasedAtIP
	--						, AVG(dt.APIGenericInvoicePerDose) AS APIGenericInvoicePerDose
	--						, AVG(dt.APIBrandInvoicePerDose) AS APIBrandInvoicePerDose
	--						FROM(SELECT dt.PMID
	--							, dt.GPI
	--							, dt.APIPurchasedAtIP
	--							, ISNULL(g.APIGenericPurchasedAtIP,0.00) AS APIGenericPurchasedAtIP
	--							, ISNULL(b.APIBrandPurchasedAtIP,0.00) AS APIBrandPurchasedAtIP
	--							, dt.APIPurchaseQty
	--							, ISNULL(g.APIGenericPurchaseQty,0.00) AS APIGenericPurchaseQty
	--							, ISNULL(b.APIBrandPurchaseQty,0.00) AS APIBrandPurchaseQty
	--							, dt.APIInvoicePerDose
	--							, ISNULL(g.APIGenericInvoicePerDose,0.00) AS APIGenericInvoicePerDose
	--							, ISNULL(b.APIBrandInvoicePerDose,0.00) AS APIBrandInvoicePerDose
	--							FROM(SELECT PMID
	--								, GPI
	--								, SUM(Doses) AS APIPurchaseQty
	--								, CAST((SUM(Doses) * AVG(InvoicePerDose)) AS DECIMAL(18, 2)) AS APIPurchasedAtIP 
	--								, AVG(InvoicePerDose) AS APIInvoicePerDose
	--								FROM SalesDDS.dbo.APIComplianceReport
	--								WHERE InvoiceDate BETWEEN @StartDate AND @EndDate
	--								GROUP BY PMID, GPI
	--								--, InvoicePerDose
	--								) AS dt
	--							LEFT OUTER JOIN(SELECT PMID
	--											, GPI
	--											, SUM(Doses) AS APIGenericPurchaseQty
	--											, CAST((SUM(Doses) * AVG(InvoicePerDose))AS DECIMAL(18, 2)) AS APIGenericPurchasedAtIP
	--											, AVG(InvoicePerDose) AS APIGenericInvoicePerDose
	--											FROM SalesDDS.dbo.APIComplianceReport
	--											WHERE InvoiceDate BETWEEN @StartDate AND @EndDate
	--											AND IsGeneric = 1
	--											GROUP BY PMID, GPI
	--											--, InvoicePerDose
	--											) AS g ON dt.PMID = g.PMID
	--														AND dt.GPI = g.GPI
	--							LEFT OUTER JOIN(SELECT PMID
	--											, GPI
	--											, SUM(Doses) AS APIBrandPurchaseQty
	--											, CAST((SUM(Doses) * AVG(InvoicePerDose))AS DECIMAL(18, 2)) AS APIBrandPurchasedAtIP
	--											, AVG(InvoicePerDose) AS APIBrandInvoicePerDose
	--											FROM SalesDDS.dbo.APIComplianceReport 
	--											WHERE InvoiceDate BETWEEN @StartDate AND @EndDate
	--											AND IsGeneric = 0
	--											GROUP BY PMID, GPI
	--											--, InvoicePerDose
	--											) AS b ON dt.PMID = b.PMID
	--														AND dt.GPI = b.GPI
	--						) AS dt
	--						GROUP BY dt.PMID, dt.GPI
	--			) AS a ON dt.PMID = a.PMID
	--				AND dt.GPI = a.GPI
	--LEFT OUTER JOIN(SELECT dt.PMID
	--				, dt.GPI
	--				, SUM(dt.CAHPurchaseQty) AS CAHPurchaseQty
	--				, SUM(dt.CAHGenericPurchaseQty) AS CAHGenericPurchaseQty
	--				, SUM(dt.CAHBrandPurchaseQty) AS CAHBrandPurchaseQty
	--				, SUM(dt.CAHPurchasedAtIP) AS CAHPurchasedAtIP
	--				, SUM(dt.CAHGenericPurchasedAtIP) AS CAHGenericPurchasedAtIP
	--				, SUM(dt.CAHBrandPurchasedAtIP) AS CAHBrandPurchasedAtIP
	--				, AVG(dt.CAHInvoicePerDose) AS CAHInvoicePerDose	
	--				, AVG(dt.CAHGenericInvoicePerDose) AS CAHGenericInvoicePerDose
	--				, AVG(dt.CAHBrandInvoicePerDose) AS CAHBrandInvoicePerDose								
	--				FROM (SELECT dt.PMID
	--					, dt.GPI
	--					, dt.CAHPurchasedAtIP
	--					, ISNULL(g.CAHGenericPurchasedAtIP,0.00) AS CAHGenericPurchasedAtIP
	--					, ISNULL(b.CAHBrandPurchasedAtIP,0.00) AS CAHBrandPurchasedAtIP
	--					, dt.CAHPurchaseQty
	--					, ISNULL(g.CAHGenericPurchaseQty,0.00) AS CAHGenericPurchaseQty
	--					, ISNULL(b.CAHBrandPurchaseQty,0.00) AS CAHBrandPurchaseQty
	--					, dt.CAHInvoicePerDose
	--					, ISNULL(g.CAHGenericInvoicePerDose,0.00) AS CAHGenericInvoicePerDose
	--					, ISNULL(b.CAHBrandInvoicePerDose,0.00) AS CAHBrandInvoicePerDose
	--					FROM(SELECT PMID
	--						, GPI
	--						, SUM(Doses) AS CAHPurchaseQty
	--						, (SUM(Doses) * AVG(InvoicePerDose2)) AS CAHPurchasedAtIP
	--						, CONVERT(DECIMAL(18,2),AVG(InvoicePerDose2)) AS CAHInvoicePerDose
	--						FROM SalesDDS.dbo.CAHComplianceReport 
	--						WHERE InvoiceDate BETWEEN @StartDate AND @EndDate
	--						GROUP BY PMID, GPI
	--						--, InvoicePerDose2
	--						) AS dt
	--					LEFT OUTER JOIN(SELECT PMID
	--									, GPI
	--									, SUM(Doses) AS CAHGenericPurchaseQty
	--									, (SUM(Doses) * AVG(InvoicePerDose2)) AS CAHGenericPurchasedAtIP
	--									, CONVERT(DECIMAL(18,2),AVG(InvoicePerDose2)) AS CAHGenericInvoicePerDose
	--									FROM SalesDDS.dbo.CAHComplianceReport 
	--									WHERE InvoiceDate BETWEEN @StartDate AND @EndDate
	--									AND IsGeneric = 1
	--									GROUP BY PMID, GPI
	--									--, InvoicePerDose2
	--									) AS g ON dt.PMID = g.PMID
	--												AND dt.GPI = g.GPI
	--					LEFT OUTER JOIN(SELECT PMID
	--									, GPI
	--									, SUM(Doses) AS CAHBrandPurchaseQty
	--									, (SUM(Doses) * AVG(InvoicePerDose2)) AS CAHBrandPurchasedAtIP
	--									, CONVERT(DECIMAL(18,2),AVG(InvoicePerDose2)) AS CAHBrandInvoicePerDose
	--									FROM SalesDDS.dbo.CAHComplianceReport 
	--									WHERE InvoiceDate BETWEEN @StartDate AND @EndDate
	--									AND IsGeneric = 0
	--									GROUP BY PMID, GPI
	--									--, InvoicePerDose2
	--									) AS b ON dt.PMID = b.PMID
	--												AND dt.GPI = b.GPI
	--					) AS dt
	--				GROUP BY dt.PMID, dt.GPI
	--				) AS c ON c.PMID = dt.PMID	
	--						AND c.GPI = dt.GPI
	--LEFT OUTER JOIN(SELECT dd.GPI
	--				, MIN(a.APIPricePerUnit) AS APIPricePerUnit
	--				FROM ODSIntake.[dbo].[vwAPIPricing] AS a
	--				INNER JOIN DrugMaster.dbo.DrugDim AS dd ON a.NDC = dd.NDC
	--				INNER JOIN DrugMaster.dbo.APICatalog AS ac ON ac.NDC = dd.NDC
	--				GROUP BY dd.GPI 
	--				) AS agpi ON agpi.GPI = dt.GPI
	--LEFT OUTER JOIN(SELECT dd.GPI
	--				,MIN(CONVERT(DECIMAL(10,4), c.InvoicePrice/(dd.PackageSize*dd.PackageQuantity))) AS CAHPricePerUnit
	--				FROM CAHODS.dbo.CardinalComplete AS c
	--				INNER JOIN DrugMaster.dbo.DrugDim AS dd ON c.NDC = dd.NDC
	--				GROUP BY dd.GPI
	--				) AS cgpi ON cgpi.GPI = dt.GPI
	--	) AS dt
	--INNER JOIN RXMaster.dbo.PharmacyDim AS dd ON dd.PMID = dt.PMID
	--GROUP BY dt.PMID, dd.PharmacyName
	--ORDER BY dt.PMID A


GO
