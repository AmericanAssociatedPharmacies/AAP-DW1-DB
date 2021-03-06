USE [SalesDDS]
GO
/****** Object:  StoredProcedure [dbo].[usp_SalesFact_CAH_Update]    Script Date: 12/22/2020 7:55:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[usp_SalesFact_CAH_Update]

	@DateKey INT

AS

SET NOCOUNT ON;

BEGIN
BEGIN TRY


	UPDATE x
	SET PricePerUnit = CONVERT(DECIMAL(18,2),(x.[CAHExtendedSales]/x.[CAHInvoiceQuantity])/(dd.PackageSize * dd.PackageQuantity))
	FROM [dbo].[SalesFact_CAH] AS x
	INNER JOIN SalesDDS.dbo.DrugDim AS dd ON x.DrugKey = dd.DrugKey
	WHERE x.DateKey = @DateKey
	AND dd.DrugKey > 0
	AND dd.PackageQuantity IS NOT NULL
	AND x.[CAHInvoiceQuantity] > 0


	--INSERT INTO dbo.Loop20200710(DateKey, StartDate)
	--VALUES(@DateKey, GETDATE())


	--UPDATE x
	--SET Doses = x.[CAHInvoiceQuantity] * (dd.PackageSize * dd.PackageQuantity)
	--, InvoicePerDose = x.[CAHExtendedSales]/(x.[CAHInvoiceQuantity] * (dd.PackageSize * dd.PackageQuantity))
	--FROM [dbo].[SalesFact_CAH] AS x
	----INNER JOIN dbo.EventDimCAH AS e ON x.DateKey = e.DateKey
	----									AND x.CAHEventKey = e.EventKey
	--INNER JOIN dbo.PharmacyDim AS pd ON x.PharmacyKey = pd.PharmacyKey
	--INNER JOIN dbo.DrugDim AS dd ON x.DrugKey =  dd.DrugKey
	--WHERE dd.DrugKey > 0
	--AND x.[CAHInvoiceQuantity] > 0
	--AND pd.PharmacyKey > 0
	--AND dd.PackageSize IS NOT NULL
	--AND dd.PackageQuantity IS NOT NULL 
	--AND x.DateKey = @DateKey

	--UPDATE x
	--SET GenericDoses = x.[CAHInvoiceQuantity] * (dd.PackageSize * dd.PackageQuantity)
	--, GenericInvoicePerDose = x.[CAHExtendedSales]/(x.[CAHInvoiceQuantity] * (dd.PackageSize * dd.PackageQuantity))
	--FROM [dbo].[SalesFact_CAH] AS x
	----INNER JOIN dbo.EventDimCAH AS e ON x.DateKey = e.DateKey
	----									AND x.CAHEventKey = e.EventKey
	--INNER JOIN dbo.PharmacyDim AS pd ON x.PharmacyKey = pd.PharmacyKey
	--INNER JOIN dbo.DrugDim AS dd ON x.DrugKey =  dd.DrugKey
	--WHERE dd.DrugKey > 0
	--AND x.[CAHInvoiceQuantity] > 0
	--AND pd.PharmacyKey > 0
	--AND dd.PackageSize IS NOT NULL
	--AND dd.PackageQuantity IS NOT NULL 
	--AND dd.IsGeneric = 1
	--AND x.DateKey = @DateKey

	--UPDATE x
	--SET BrandDoses = x.[CAHInvoiceQuantity] * (dd.PackageSize * dd.PackageQuantity)
	--, BrandInvoicePerDose = x.[CAHExtendedSales]/(x.[CAHInvoiceQuantity]  * (dd.PackageSize * dd.PackageQuantity))
	--FROM [dbo].[SalesFact_CAH] AS x
	----INNER JOIN dbo.EventDimCAH AS e ON x.DateKey = e.DateKey
	----									AND x.CAHEventKey = e.EventKey
	--INNER JOIN dbo.PharmacyDim AS pd ON x.PharmacyKey = pd.PharmacyKey
	--INNER JOIN dbo.DrugDim AS dd ON x.DrugKey =  dd.DrugKey
	--WHERE dd.DrugKey > 0
	--AND x.[CAHInvoiceQuantity] > 0
	--AND pd.PharmacyKey > 0
	--AND dd.PackageSize IS NOT NULL
	--AND dd.PackageQuantity IS NOT NULL 
	--AND dd.IsGeneric = 0
	--AND x.DateKey = @DateKey


	--UPDATE x
	--SET [PurchaseQty] = x.Doses
	--, [GenericPurchaseQty] = x.[GenericDoses]
	--, [BrandPurchaseQty] = x.[BrandDoses]
	--, [PurchaseAtIP] = (x.Doses * x.[InvoicePerDose])
	--, [GenericPurchaseAtIP] = (x.[GenericDoses] * x.[GenericInvoicePerDose])
	--, [BrandPurchaseAtIP] = (x.[BrandDoses] * x.[BrandInvoicePerDose])
	--FROM [dbo].[SalesFact_CAH] AS x
	--WHERE x.DateKey = @DateKey


	--UPDATE dbo.Loop20200710
	--SET EndDate = GETDATE()
	--WHERE DateKey = @DateKey

	--DECLARE @p1 VARCHAR(25)
	--, @p2 VARCHAR(255)

	--SET @p1 = CONVERT(VARCHAR(25),@DateKey)

	--SET @p2 = 'The following key has been updated: ' + @p1

	--	--Send email to advise files were not available for download
	--	EXEC msdb.dbo.sp_send_dbmail  
	--		@recipients = 'scott.edwards@rxaap.com'
	--		, @body = @p2
	--		, @subject = 'Sales CAH Update' 		
	--		--, @importance = 'High'


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
