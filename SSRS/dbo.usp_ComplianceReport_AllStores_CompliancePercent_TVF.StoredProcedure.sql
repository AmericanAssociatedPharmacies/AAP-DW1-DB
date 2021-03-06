USE [SSRS]
GO
/****** Object:  StoredProcedure [dbo].[usp_ComplianceReport_AllStores_CompliancePercent_TVF]    Script Date: 12/22/2020 8:05:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE PROCEDURE [dbo].[usp_ComplianceReport_AllStores_CompliancePercent_TVF]

			@StartDate DATE
			, @EndDate DATE

AS

SET NOCOUNT ON;

BEGIN

DECLARE @StartDateKey INT
, @EndDateKey INT
, @StartMonthYearKey INT
, @EndMonthYearKey INT


	SELECT @StartDateKey = DateKey
	FROM SalesDDS.dbo.DateDim
	WHERE TheDate = @StartDate

	SELECT @EndDateKey = DateKey
	FROM SalesDDS.dbo.DateDim
	WHERE TheDate = @EndDate

	SELECT @StartMonthYearKey = CCYYMM
	FROM SalesDDS.dbo.DateDim
	WHERE TheDate = @StartDate

	SELECT @EndMonthYearKey = CCYYMM
	FROM SalesDDS.dbo.DateDim
	WHERE TheDate = @EndDate


	SELECT dd.PMID
	, dd.PharmacyName
	, CONVERT(DECIMAL(6,2),(SUM(PurchasesIP)/NULLIF(SUM(DispensedIP),0))) AS CompliancePercent --Removed *100 so that its a deciaml DAB 6/22
	, CONVERT(DECIMAL(6,2), ISNULL(((SUM(dt.APIGenericPurchasesIP) + SUM(dt.CAHGenericPurchasesIP))/NULLIF(SUM(GenericDispensedIP),0)),0.00)) AS GenericCompliancePercent
	, CONVERT(DECIMAL(6,2), ISNULL(((SUM(dt.APIBrandPurchasesIP) + SUM(dt.CAHBrandPurchasesIP))/NULLIF(SUM(BrandDispensedIP),0)),0.00)) AS BrandCompliancePercent
	FROM(SELECT dt.PHarmacyKey
			, dt.GPIKey
			, FDSQuantityDispensed * ISNULL(ISNULL(ISNULL(a.APIInvoicePerDose,c.CAHInvoicePerDose), agpi.APIPricePerUnit), cgpi.CAHPricePerUnit) AS DispensedIP
			, FDSGenericQuantityDispensed * ISNULL(ISNULL(ISNULL(a.APIGenericInvoicePerDose,c.CAHGenericInvoicePerDose), agpi.APIPricePerUnit), cgpi.CAHPricePerUnit) AS GenericDispensedIP
			, FDSBrandQuantityDispensed * ISNULL(ISNULL(ISNULL(a.APIBrandInvoicePerDose,c.CAHBrandInvoicePerDose), agpi.APIPricePerUnit), cgpi.CAHPricePerUnit) AS BrandDispensedIP			
			, ISNULL(a.APIPurchasedAtIP,0.00) + ISNULL(c.CAHPurchasedAtIP,0.00) AS PurchasesIP
			, ISNULL(a.APIGenericPurchasedAtIP,0.00) AS APIGenericPurchasesIP
			, ISNULL(a.APIBrandPurchasedAtIP,0.00) AS APIBrandPurchasesIP
			, ISNULL(c.CAHGenericPurchasedAtIP,0.00) AS CAHGenericPurchasesIP
			, ISNULL(c.CAHBrandPurchasedAtIP,0.00) AS CAHBrandPurchasesIP
			FROM(SELECT PharmacyKey, GPIKey, FDSQuantityDispensed, FDSGenericQuantityDispensed, FDSBrandQuantityDispensed
				 FROM ClaimsDDS.dbo.tvfClaimsQtyDispensed (@StartMonthYearKey,@EndMonthYearKey)									
				) AS dt
	LEFT OUTER JOIN(SELECT PharmacyKey, GPIKey, APIPurchaseQty, APIPurchasedAtIP, APIInvoicePerDose
					, APIGenericPurchaseQty, APIGenericPurchasedAtIP, APIGenericInvoicePerDose
					, APIBrandPurchaseQty, APIBrandPurchasedAtIP, APIBrandInvoicePerDose
					FROM SalesDDS.[dbo].[tvfAPIComplianceReport] (@StartDateKey,@EndDateKey)
					) AS a ON dt.PharmacyKey = a.PharmacyKey
						AND dt.GPIKey = a.GPIKey
	LEFT OUTER JOIN(SELECT PharmacyKey, GPIKey, CAHPurchaseQty, CAHPurchasedAtIP, CAHInvoicePerDose
					, CAHGenericPurchaseQty, CAHGenericPurchasedAtIP, CAHGenericInvoicePerDose
					, CAHBrandPurchaseQty, CAHBrandPurchasedAtIP, CAHBrandInvoicePerDose
					FROM SalesDDS.[dbo].[tvfCAHComplianceReport] (@StartMonthYearKey,@EndMonthYearKey)
					) AS c ON dt.PharmacyKey = c.PharmacyKey
						AND dt.GPIKey = c.GPIKey					
	LEFT OUTER JOIN(SELECT dd.GPIKey
					, MIN(a.APIPricePerUnit) AS APIPricePerUnit
					FROM ODSIntake.[dbo].[vwAPIPricing] AS a
					INNER JOIN DrugMaster.dbo.DrugDim AS dd ON a.NDC = dd.NDC
					INNER JOIN DrugMaster.dbo.APICatalog AS ac ON ac.NDC = dd.NDC
					WHERE dd.GPIKey > 0
					GROUP BY dd.GPIKey 
					) AS agpi ON agpi.GPIKey = dt.GPIKey
	LEFT OUTER JOIN(SELECT dd.GPIKey
					,MIN(CONVERT(DECIMAL(10,4), c.InvoicePrice/(dd.PackageSize*dd.PackageQuantity))) AS CAHPricePerUnit
					FROM CAHODS.dbo.CardinalComplete AS c
					INNER JOIN DrugMaster.dbo.DrugDim AS dd ON c.NDC = dd.NDC
					WHERE dd.GPIKey > 0
					GROUP BY dd.GPIKey
					) AS cgpi ON cgpi.GPIKey = dt.GPIKey
	) AS dt
	INNER JOIN RXMaster.dbo.PharmacyDim AS dd ON dd.PharmacyKey = dt.PharmacyKey
	GROUP BY dd.PMID, dd.PharmacyName
	ORDER BY dd.PMID ASC

END




GO
