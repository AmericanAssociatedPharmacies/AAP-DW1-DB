USE [Reports]
GO
/****** Object:  StoredProcedure [Staging].[ComplianceAllStoresAPI_Load]    Script Date: 12/22/2020 7:39:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [Staging].[ComplianceAllStoresAPI_Load]

AS

SET NOCOUNT ON;

BEGIN
BEGIN TRY

	DECLARE @StartDateKey INT
	, @EndDateKey INT

	SELECT @StartDateKey = DateKey
	FROM ClaimsDDS.dbo.DateDim
	WHERE TheDate =  CONVERT(DATE,DATEADD(year, -1, getdate()))

	SELECT @EndDateKey = DateKey
	FROM ClaimsDDS.dbo.DateDim
	WHERE TheDate =  CONVERT(DATE, getdate())

	TRUNCATE TABLE [Staging].[ComplianceAllStoresAPI];


	INSERT INTO [Staging].[ComplianceAllStoresAPI](MonthDate, PMID, GPI, APIPurchasedAtIP, APIGenericPurchasedAtIP, APIBrandPurchasedAtIP, APIPurchaseQty, APIGenericPurchaseQty, APIBrandPurchaseQty, APIInvoicePerDose
													, APIGenericInvoicePerDose, APIBrandInvoicePerDose, DateKey, GPIKey, PharmacyKey
													)
	SELECT dd.FirstDayOfMonth
	, pd.PMID
	, d.GPI
	, c.APIPurchasedAtIP
	, c.APIGenericPurchasedAtIP
	, c.APIBrandPurchasedAtIP
	, c.APIPurchaseQty
	, c.APIGenericPurchaseQty
	, c.APIBrandPurchaseQty
	, c.APIInvoicePerDose
	, c.APIGenericInvoicePerDose
	, c.APIBrandInvoicePerDose
	, dd.DateKey
	, c.GPIKey
	, c.PharmacyKey
	FROM SalesDDS.[dbo].[tvfAPIComplianceReport](@StartDateKey,@EndDateKey) AS c
	INNER JOIN(SELECT DateKey, FirstDayOfMonth
				FROM  SalesDDS.dbo.DateDim
				WHERE [DayOfMonth] = 1 
				) AS dd ON c.FirstDayOfMonth = dd.FirstDayOfMonth
	INNER JOIN(SELECT DISTINCT GPI, GPIKey
				FROM SalesDDS.dbo.DrugDim
				WHERE DrugKey > 0
				AND GPI NOT IN('94100030006100')
				) AS d ON c.GPIKey = d.GPIKey
	INNER JOIN SalesDDS.dbo.PharmacyDim AS pd ON c.PharmacyKey = pd.PharmacyKey
	

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
