USE [SalesDDS]
GO
/****** Object:  StoredProcedure [Staging].[usp_SalesFact_API_Update]    Script Date: 12/22/2020 7:55:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [Staging].[usp_SalesFact_API_Update]

AS

SET NOCOUNT ON;

BEGIN
BEGIN TRY


	UPDATE x
	SET Doses = x.[APIInvoiceQuantity] * (dd.PackageSize * dd.PackageQuantity)
	, InvoicePerDose = x.APIExtendedAmount/(x.[APIInvoiceQuantity] * (dd.PackageSize * dd.PackageQuantity))
	FROM [Staging].[SalesFact_API] AS x
	INNER JOIN dbo.EventDimAPI AS e ON x.DateKey = e.DateKey
										AND x.APIEventKey = e.EventKey
	INNER JOIN dbo.PharmacyDim AS pd ON x.PharmacyKey = pd.PharmacyKey
	INNER JOIN dbo.DrugDim AS dd ON x.DrugKey =  dd.DrugKey
	WHERE e.IsCredit = 0
	AND dd.DrugKey > 0
	AND x.[APIInvoiceQuantity] > 0
	AND pd.PharmacyKey > 0
	AND dd.PackageSize IS NOT NULL
	AND dd.PackageQuantity IS NOT NULL 

	UPDATE x
	SET GenericDoses = x.[APIInvoiceQuantity] * (dd.PackageSize * dd.PackageQuantity)
	, GenericInvoicePerDose = x.APIExtendedAmount/(x.[APIInvoiceQuantity] * (dd.PackageSize * dd.PackageQuantity))
	FROM [Staging].[SalesFact_API] AS x
	INNER JOIN dbo.EventDimAPI AS e ON x.DateKey = e.DateKey
										AND x.APIEventKey = e.EventKey
	INNER JOIN dbo.PharmacyDim AS pd ON x.PharmacyKey = pd.PharmacyKey
	INNER JOIN dbo.DrugDim AS dd ON x.DrugKey =  dd.DrugKey
	WHERE e.IsCredit = 0
	AND dd.DrugKey > 0
	AND x.[APIInvoiceQuantity] > 0
	AND pd.PharmacyKey > 0
	AND dd.PackageSize IS NOT NULL
	AND dd.PackageQuantity IS NOT NULL 
	AND dd.IsGeneric = 1

	UPDATE x
	SET BrandDoses = x.[APIInvoiceQuantity] * (dd.PackageSize * dd.PackageQuantity)
	, BrandInvoicePerDose = x.APIExtendedAmount/(x.[APIInvoiceQuantity] * (dd.PackageSize * dd.PackageQuantity))
	, [PricePerUnit] = CONVERT(DECIMAL(18,2),(x.[APIExtendedAmount]/NULLIF(x.APIInvoiceQuantity,0))/(dd.PackageSize * dd.PackageQuantity)) 
	FROM [Staging].[SalesFact_API] AS x
	INNER JOIN dbo.EventDimAPI AS e ON x.DateKey = e.DateKey
										AND x.APIEventKey = e.EventKey
	INNER JOIN dbo.PharmacyDim AS pd ON x.PharmacyKey = pd.PharmacyKey
	INNER JOIN dbo.DrugDim AS dd ON x.DrugKey =  dd.DrugKey
	WHERE e.IsCredit = 0
	AND dd.DrugKey > 0
	AND x.[APIInvoiceQuantity] > 0
	AND pd.PharmacyKey > 0
	AND dd.PackageSize IS NOT NULL
	AND dd.PackageQuantity IS NOT NULL 
	AND dd.IsGeneric = 0


	UPDATE x
	SET [PurchaseQty] = x.Doses
	, [GenericPurchaseQty] = x.[GenericDoses]
	, [BrandPurchaseQty] = x.[BrandDoses]
	, [PurchaseAtIP] = (x.Doses * x.[InvoicePerDose])
	, [GenericPurchaseAtIP] = (x.[GenericDoses] * x.[GenericInvoicePerDose])
	, [BrandPurchaseAtIP] = (x.[BrandDoses] * x.[BrandInvoicePerDose])
	FROM [Staging].[SalesFact_API] AS x


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
