USE [Reports]
GO
/****** Object:  StoredProcedure [Staging].[usp_ComplianceAllStores_Load]    Script Date: 12/22/2020 7:39:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [Staging].[usp_ComplianceAllStores_Load]

AS

SET NOCOUNT ON;

BEGIN
BEGIN TRY

	TRUNCATE TABLE [Staging].[ComplianceAllStores];

	INSERT INTO [Staging].[ComplianceAllStores](PMID
													, MonthDate
													, GPI
													, TotalQuantityDispensed
													, GenericQuantityDispensed
													, BrandQuantityDispensed
													, APIPurchasedAtIP
													, APIGenericPurchasedAtIP
													, APIBrandPurchasedAtIP
													, APIPurchaseQty
													, APIGenericPurchaseQty
													, APIBrandPurchaseQty
													, APIInvoicePerDose
													, APIGenericInvoicePerDose
													, APIBrandInvoicePerDose
													, CAHPurchasedAtIP
													, CAHGenericPurchasedAtIP
													, CAHBrandPurchasedAtIP
													, CAHPurchaseQty
													, CAHGenericPurchaseQty
													, CAHBrandPurchaseQty
													, CAHInvoicePerDose
													, CAHGenericInvoicePerDose
													, CAHBrandInvoicePerDose
													, TotalDispensedIP
													, GenericDispensedIP
													, BrandDispensedIP 
													, DateKey
													, GPIKey
													, PharmacyKey
													)


				SELECT c.PMID
				, c.MonthDate
				, c.GPI
				, c.TotalQuantityDispensed
				, c.GenericQuantityDispensed
				, c.BrandQuantityDispensed
				, c.APIPurchasedAtIP
				, c.APIGenericPurchasedAtIP
				, c.APIBrandPurchasedAtIP
				, c.APIPurchaseQty
				, c.APIGenericPurchaseQty
				, c.APIBrandPurchaseQty
				, c.APIInvoicePerDose
				, c.APIGenericInvoicePerDose
				, c.APIBrandInvoicePerDose
				, c.CAHPurchasedAtIP
				, c.CAHGenericPurchasedAtIP
				, c.CAHBrandPurchasedAtIP
				, c.CAHPurchaseQty
				, c.CAHGenericPurchaseQty
				, c.CAHBrandPurchaseQty
				, c.CAHInvoicePerDose
				, c.CAHGenericInvoicePerDose
				, c.CAHBrandInvoicePerDose
				, ISNULL(c.TotalQuantityDispensed * ISNULL(ISNULL(ISNULL(NULLIF(c.APIInvoicePerDose,0),NULLIF(CAHInvoicePerDose,0)), agpi.APIPricePerUnit), cgpi.CAHPricePerUnit),0.00) AS DispensedIP
				, ISNULL(c.GenericQuantityDispensed * ISNULL(ISNULL(ISNULL(NULLIF(c.APIGenericInvoicePerDose,0),NULLIF(c.CAHGenericInvoicePerDose,0)), agpi.APIPricePerUnit), cgpi.CAHPricePerUnit),0.00) AS GenericDispensedIP
				, ISNULL(c.BrandQuantityDispensed * ISNULL(ISNULL(ISNULL(NULLIF(c.APIBrandInvoicePerDose,0),NULLIF(c.CAHBrandInvoicePerDose,0)), agpi.APIPricePerUnit), cgpi.CAHPricePerUnit),0.00) AS BrandDispensedIP     
				, c.DateKey
				, c.GPIKey
				, c.PharmacyKey
				FROM(SELECT c.MonthDate
					   , c.PMID
					   , c.GPI
					   , c.TotalQuantityDispensed
					   , c.GenericQuantityDispensed
					   , c.BrandQuantityDispensed
					   , ISNULL(api.APIPurchasedAtIP,0.00) AS APIPurchasedAtIP
					   , ISNULL(api.APIGenericPurchasedAtIP,0.00) AS APIGenericPurchasedAtIP
					   , ISNULL(api.APIBrandPurchasedAtIP,0.00) AS APIBrandPurchasedAtIP
					   , ISNULL(api.APIPurchaseQty,0.00) AS APIPurchaseQty
					   , ISNULL(api.APIGenericPurchaseQty,0.00) AS APIGenericPurchaseQty
					   , ISNULL(api.APIBrandPurchaseQty,0.00) AS APIBrandPurchaseQty
					   , ISNULL(api.APIInvoicePerDose,0.00) AS APIInvoicePerDose
					   , ISNULL(api.APIGenericInvoicePerDose,0.00) AS APIGenericInvoicePerDose
					   , ISNULL(api.APIBrandInvoicePerDose,0.00) AS APIBrandInvoicePerDose
					   , ISNULL(cah.CAHPurchasedAtIP,0.00) AS CAHPurchasedAtIP
					   , ISNULL(cah.CAHGenericPurchasedAtIP,0.00) AS CAHGenericPurchasedAtIP
					   , ISNULL(cah.CAHBrandPurchasedAtIP,0.00) AS CAHBrandPurchasedAtIP
					   , ISNULL(cah.CAHPurchaseQty,0.00) AS CAHPurchaseQty
					   , ISNULL(cah.CAHGenericPurchaseQty,0.00) AS CAHGenericPurchaseQty
					   , ISNULL(cah.CAHBrandPurchaseQty,0.00) AS CAHBrandPurchaseQty
					   , ISNULL(cah.CAHInvoicePerDose,0.00) AS CAHInvoicePerDose
					   , ISNULL(cah.CAHGenericInvoicePerDose,0.00) AS CAHGenericInvoicePerDose
					   , ISNULL(cah.CAHBrandInvoicePerDose,0.00) AS CAHBrandInvoicePerDose
					   , c.DateKey
					   , c.GPIKey
					   , c.PharmacyKey
					   FROM [Staging].[ComplianceAllStoresFDS] AS c
					   LEFT OUTER JOIN [Staging].[ComplianceAllStoresAPI] AS api ON c.[DateKey] = api.[DateKey]
																					AND c.GPIKey = api.GPIKey
																					AND c.PharmacyKey = api.PharmacyKey                                                                                        
					   LEFT OUTER JOIN [Staging].[ComplianceAllStoresCAH] AS cah ON c.[DateKey] = cah.[DateKey]
																					AND c.GPIKey = cah.GPIKey
																					AND c.PharmacyKey = cah.PharmacyKey
						WHERE c.RowID = (c.RowID + 0)
						) AS c
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



	UPDATE t
	SET [CompliancePercent] = ISNULL(s.CompliancePercent,0.00)
	, GenericCompliancePercent = ISNULL(s.GenericCompliancePercent, 0.00)
	, BrandCompliancePercent = ISNULL(s.BrandCompliancePercent,0.00)
	FROM [Staging].[ComplianceAllStores] AS t
	INNER JOIN(SELECT RowID
						 , TRY_CONVERT(DECIMAL(6,2),(SUM((APIPurchasedAtIP + CAHPurchasedAtIP))/NULLIF(SUM(TotalDispensedIP),0))) AS CompliancePercent --Removed *100 so that its a deciaml DAB 6/22
						 , TRY_CONVERT(DECIMAL(6,2), ISNULL(((SUM(APIGenericPurchasedAtIP) + SUM(CAHGenericPurchasedAtIP))/NULLIF(SUM(GenericDispensedIP),0)),0.00)) AS GenericCompliancePercent
						 , TRY_CONVERT(DECIMAL(6,2), ISNULL(((SUM(APIBrandPurchasedAtIP) + SUM(CAHBrandPurchasedAtIP))/NULLIF(SUM(BrandDispensedIP),0)),0.00)) AS BrandCompliancePercent
						 FROM Reports.[Staging].[ComplianceAllStores]
						 GROUP BY RowID
							   ) AS s ON t.RowID = s.RowID     
	
	--Purchase Qty
	UPDATE x
	SET TotalPurchaseQty = [APIPurchaseQty] + [CAHPurchaseQty]
	FROM [Staging].[ComplianceAllStores] AS x

	UPDATE x
	SET GenericPurchaseQty =  [APIGenericPurchaseQty] + [CAHGenericPurchaseQty]
	FROM [Staging].[ComplianceAllStores] AS x

	UPDATE x
	SET BrandPurchaseQty =  [APIBrandPurchaseQty] + [CAHBrandPurchaseQty]
	FROM [Staging].[ComplianceAllStores] AS x

	--Purchase IP
	UPDATE x
	SET TotalPurchaseIP =  [APIPurchasedAtIP] + [CAHPurchasedAtIP]
	FROM [Staging].[ComplianceAllStores] AS x

	UPDATE x
	SET GenericPurchaseIP =  [APIGenericPurchasedAtIP] + [CAHGenericPurchasedAtIP]
	FROM [Staging].[ComplianceAllStores] AS x

	UPDATE x
	SET BrandPurchaseIP =  [APIBrandPurchasedAtIP] + [CAHBrandPurchasedAtIP]
	FROM [Staging].[ComplianceAllStores] AS x

	--Leakage Qty
	UPDATE x
	SET TotalLeakageQty =  [TotalPurchaseQty] - [TotalQuantityDispensed]
	FROM [Staging].[ComplianceAllStores] AS x

	UPDATE x
	SET GenericLeakageQty = [GenericPurchaseQty]  - [GenericQuantityDispensed]
	FROM [Staging].[ComplianceAllStores] AS x

	UPDATE x
	SET BrandLeakageQty = [BrandPurchaseQty]  - [BrandQuantityDispensed]
	FROM [Staging].[ComplianceAllStores] AS x

	--Leakage IP
	UPDATE x
	SET TotalLeakageIP = [TotalPurchaseIP] - [TotalDispensedIP]
	FROM [Staging].[ComplianceAllStores] AS x

	UPDATE x
	SET GenericLeakageIP = [GenericPurchaseIP] - [GenericDispensedIP]
	FROM [Staging].[ComplianceAllStores] AS x

	UPDATE x
	SET BrandLeakageIP = [BrandPurchaseIP] - [BrandDispensedIP]
	FROM [Staging].[ComplianceAllStores] AS x


END TRY
BEGIN CATCH	

	DECLARE @ErrorMessage NVARCHAR(4000)
        , @ErrorNumber INT
        , @ErrorSeverity INT
        , @ErrorState INT
        , @ErrorLine INT
        , @ErrorProcedure NVARCHAR(200)

		SELECT 
        @ErrorNumber = ERROR_NUMBER()
        , @ErrorSeverity = ERROR_SEVERITY()
        , @ErrorState = ERROR_STATE()
        , @ErrorLine = ERROR_LINE()
        , @ErrorProcedure = ISNULL(ERROR_PROCEDURE(), '-')
		, @ErrorMessage = ERROR_MESSAGE();

		RAISERROR 
        (@ErrorMessage 
        , @ErrorSeverity, 1               
        , @ErrorNumber    -- parameter: original error number.
        , @ErrorSeverity  -- parameter: original error severity.
        , @ErrorState     -- parameter: original error state.
        , @ErrorProcedure -- parameter: original error procedure name.
        , @ErrorLine       -- parameter: original error line number.
        );



END CATCH





END



GO
