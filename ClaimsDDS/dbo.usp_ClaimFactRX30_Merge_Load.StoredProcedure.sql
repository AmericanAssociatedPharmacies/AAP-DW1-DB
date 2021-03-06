USE [ClaimsDDS]
GO
/****** Object:  StoredProcedure [dbo].[usp_ClaimFactRX30_Merge_Load]    Script Date: 12/22/2020 6:54:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[usp_ClaimFactRX30_Merge_Load]

	@PartitionID INT

AS

SET NOCOUNT ON;

BEGIN
BEGIN TRY

	BEGIN TRAN

	--Switch data from Prod into Staging to execute MERGE query
	ALTER TABLE [dbo].[ClaimFactRX30]
	SWITCH PARTITION @PartitionID 
	TO  [Staging].[ClaimFactRX30] PARTITION @PartitionID


	--If a row does exist, update it. If not, insert new row(s).Must include the DateOfServiceKey column to only load the data for that partition that has been swtiched in.
	MERGE [Staging].[ClaimFactRX30] AS t
	USING(SELECT DateOfServiceKey, PharmacyKey, EventKey, DrugKey, DispensingFeeSubmitted, IngredientCostSubmitted, DispensingFeePaid, IngredientCostPaid, TotalAmountPaid
			, AmountofCopay, UsualandCustomaryCharge, TotalPrice, PatientPayAmount, GrossAmountDue, OtherAmount, FlatSalesTaxAmountPaid, PercentageSalesTaxAmountPaid
			, PercentageSalesTaxRate, PercentageSalesTaxBasisPaid, IncentiveAmountPaid, AWPUnitPrice, CardinalPharmacyCost, APIPharmacyCost, UnitOfSale, TransactionCount
			, RxDiscount, QuantityDispensed
			FROM [Staging].[ClaimFactRX30_PreLoad] AS s
			WHERE EXISTS(SELECT 1
							FROM [Staging].[ClaimFactRX30] AS t
							WHERE s.DateOfServiceKey = t.DateOfServiceKey			
						)
			) AS s (DateOfServiceKey, PharmacyKey, EventKey, DrugKey, DispensingFeeSubmitted, IngredientCostSubmitted, DispensingFeePaid, IngredientCostPaid, TotalAmountPaid
					, AmountofCopay, UsualandCustomaryCharge, TotalPrice, PatientPayAmount, GrossAmountDue, OtherAmount, FlatSalesTaxAmountPaid, PercentageSalesTaxAmountPaid
					, PercentageSalesTaxRate, PercentageSalesTaxBasisPaid, IncentiveAmountPaid, AWPUnitPrice, CardinalPharmacyCost, APIPharmacyCost, UnitOfSale, TransactionCount
					, RxDiscount, QuantityDispensed
					) ON t.DateOfServiceKey = s.DateOfServiceKey
					AND t.PharmacyKey = s.PharmacyKey
					AND t.EventKey = s.EventKey
					AND t.DrugKey = s.DrugKey

	WHEN MATCHED THEN
	UPDATE SET t.DateOfServiceKey = s.DateOfServiceKey
		, t.PharmacyKey = s.PharmacyKey
		, t.EventKey = s.EventKey
		, t.DrugKey = s.DrugKey
		, t.DispensingFeeSubmitted = s.DispensingFeeSubmitted
		, t.IngredientCostSubmitted = s.IngredientCostSubmitted
		, t.DispensingFeePaid = s.DispensingFeePaid
		, t.IngredientCostPaid = s.IngredientCostPaid
		, t.TotalAmountPaid = s.TotalAmountPaid
		, t.AmountofCopay = s.AmountofCopay
		, t.UsualandCustomaryCharge = s.UsualandCustomaryCharge
		, t.TotalPrice = s.TotalPrice
		, t.PatientPayAmount = s.PatientPayAmount
		, t.GrossAmountDue = s.GrossAmountDue
		, t.OtherAmount = s.OtherAmount
		, t.FlatSalesTaxAmountPaid = s.FlatSalesTaxAmountPaid
		, t.PercentageSalesTaxAmountPaid = s.PercentageSalesTaxAmountPaid
		, t.PercentageSalesTaxRate = s.PercentageSalesTaxRate
		, t.PercentageSalesTaxBasisPaid = s.PercentageSalesTaxBasisPaid
		, t.IncentiveAmountPaid = s.IncentiveAmountPaid
		, t.AWPUnitPrice = s.AWPUnitPrice
		, t.CardinalPharmacyCost = s.CardinalPharmacyCost
		, t.APIPharmacyCost = s.APIPharmacyCost
		, t.UnitOfSale = s.UnitOfSale
		, t.RxDiscount = s.RxDiscount
		, t.QuantityDispensed = s.QuantityDispensed

	WHEN NOT MATCHED THEN
	INSERT(DateOfServiceKey, PharmacyKey, EventKey, DrugKey, DispensingFeeSubmitted, IngredientCostSubmitted, DispensingFeePaid, IngredientCostPaid, TotalAmountPaid
			, AmountofCopay, UsualandCustomaryCharge, TotalPrice, PatientPayAmount, GrossAmountDue, OtherAmount, FlatSalesTaxAmountPaid, PercentageSalesTaxAmountPaid
			, PercentageSalesTaxRate, PercentageSalesTaxBasisPaid, IncentiveAmountPaid, AWPUnitPrice, CardinalPharmacyCost, APIPharmacyCost, UnitOfSale, TransactionCount
			, RxDiscount, QuantityDispensed
			)
	VALUES(s.DateOfServiceKey, s.PharmacyKey, s.EventKey, s.DrugKey, s.DispensingFeeSubmitted, s.IngredientCostSubmitted, s.DispensingFeePaid, s.IngredientCostPaid, s.TotalAmountPaid
			, s.AmountofCopay, s.UsualandCustomaryCharge, s.TotalPrice, s.PatientPayAmount, s.GrossAmountDue, s.OtherAmount, s.FlatSalesTaxAmountPaid, s.PercentageSalesTaxAmountPaid
			, s.PercentageSalesTaxRate, s.PercentageSalesTaxBasisPaid, s.IncentiveAmountPaid, s.AWPUnitPrice, s.CardinalPharmacyCost, s.APIPharmacyCost, s.UnitOfSale, s.TransactionCount
			, s.RxDiscount, s.QuantityDispensed
			);

	--Switch data from Staging into Prod
	ALTER TABLE [Staging].[ClaimFactRX30]
	SWITCH PARTITION @PartitionID 
	TO  [dbo].[ClaimFactRX30] PARTITION @PartitionID

	--Truncate Archive table before swtiching partitions
	--TRUNCATE TABLE [Archive].[ClaimFactRX30_PreLoad]

	--Switch data from Staging Preload into Archive
	ALTER TABLE [Staging].[ClaimFactRX30_PreLoad]
	SWITCH PARTITION @PartitionID 
	TO [Archive].[ClaimFactRX30_PreLoad] PARTITION @PartitionID

	COMMIT TRAN

END TRY
BEGIN CATCH

	ROLLBACK TRAN

	DECLARE 
        @ErrorMessage    NVARCHAR(4000),
        @ErrorNumber     INT,
        @ErrorSeverity   INT,
        @ErrorState      INT,
        @ErrorLine       INT,
        @ErrorProcedure  NVARCHAR(200);

		SELECT 
        @ErrorNumber = ERROR_NUMBER(),
        @ErrorSeverity = ERROR_SEVERITY(),
        @ErrorState = ERROR_STATE(),
        @ErrorLine = ERROR_LINE(),
        @ErrorProcedure = ISNULL(ERROR_PROCEDURE(), '-'),
		@ErrorMessage = ERROR_MESSAGE();

		RAISERROR 
        (
        @ErrorMessage, 
        @ErrorSeverity, 
        1,               
        @ErrorNumber,    -- parameter: original error number.
        @ErrorSeverity,  -- parameter: original error severity.
        @ErrorState,     -- parameter: original error state.
        @ErrorProcedure, -- parameter: original error procedure name.
        @ErrorLine       -- parameter: original error line number.
        );	
	

END CATCH
END

GO
