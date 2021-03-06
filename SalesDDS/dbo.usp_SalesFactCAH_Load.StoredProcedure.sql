USE [SalesDDS]
GO
/****** Object:  StoredProcedure [dbo].[usp_SalesFactCAH_Load]    Script Date: 12/22/2020 7:55:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[usp_SalesFactCAH_Load]

AS

SET NOCOUNT ON;

BEGIN
BEGIN TRY 

	INSERT INTO [dbo].[SalesFact_CAH](MonthYearKey, PharmacyKey, DateKey, DrugKey, CAHEventKey, CAHEventDateKey, CAHInvoiceQuantity, CAHUnitAmount, CAHExtendedSales, CAH_AWP, CAH_WAC
									, PurchaseAtIP, GenericPurchaseAtIP, BrandPurchaseAtIP, PurchaseQty, GenericPurchaseQty, BrandPurchaseQty, InvoicePerDose, GenericInvoicePerDose
									, BrandInvoicePerDose, Doses, GenericDoses, BrandDoses, PricePerUnit, s.GPIKey
									)
	SELECT CONVERT(VARCHAR,LEFT(s.Datekey,4)) + SUBSTRING(CONVERT(VARCHAR,DateKey), 5,2) AS MonthYearKey, s.PharmacyKey, s.DateKey, s.DrugKey, s.CAHEventKey, s.CAHEventDateKey, s.CAHInvoiceQuantity
	, s.CAHUnitAmount, s.CAHExtendedSales, s.CAH_AWP, s.CAH_WAC, s.PurchaseAtIP, s.GenericPurchaseAtIP, s.BrandPurchaseAtIP, s.PurchaseQty
	, s.GenericPurchaseQty, s.BrandPurchaseQty, s.InvoicePerDose, s.GenericInvoicePerDose, s.BrandInvoicePerDose, s.Doses, s.GenericDoses, s.BrandDoses, s.PricePerUnit
	, s.GPIKey
	FROM [Staging].[SalesFact_CAH] AS s
	WHERE NOT EXISTS(SELECT 1
						FROM dbo.SalesFact_CAH AS f
						WHERE f.PharmacyKey = s.PharmacyKey
						AND f.DateKey = s.DateKey
						AND f.DrugKey = s.DrugKey
						AND f.CAHEventKey = s.CAHEventKey
						AND f.CAHEventDateKey = s.CAHEventDateKey
						)
	ORDER BY PharmacyKey ASC
	, DateKey ASC 
	, DrugKey ASC
	, CAHEventKey ASC
	, CAHEventDateKey ASC

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
