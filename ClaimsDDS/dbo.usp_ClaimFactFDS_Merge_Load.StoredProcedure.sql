USE [ClaimsDDS]
GO
/****** Object:  StoredProcedure [dbo].[usp_ClaimFactFDS_Merge_Load]    Script Date: 12/22/2020 6:54:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[usp_ClaimFactFDS_Merge_Load]

	@PartitionID INT

AS

SET NOCOUNT ON;

BEGIN
BEGIN TRY

	BEGIN TRAN

	--Switch data from Prod into Staging to execute MERGE query
	ALTER TABLE [dbo].[ClaimFactFDS]
	SWITCH PARTITION @PartitionID 
	TO  [Staging].[ClaimFactFDS] PARTITION @PartitionID


	--If a row does exist, update it. If not, insert new row(s). Must include the DateOfServiceKey column to only load the data for that partition that has been swtiched in.
	MERGE [Staging].[ClaimFactFDS] AS t
	USING(SELECT DateofServiceKey, PharmacyKey, DrugKey, EventKey, PrescribedRefills, RefillNumber, TotalQuantity, ContractCost, AWP, UandC, CopayAmountSubmitted
				, IngredientCostSubmitted, DispensingFeeSubmitted, IncentiveFeeSubmitted, SalesTaxSubmitted, CopayAmountPaid, IngredientCostPaid, DispensingFeePaid
				, SalesTaxPaid, IncentiveFeePaid, ClaimAmountPaid, QuantityDispensed, DaysSupply, AdjustedContractCost
			FROM [Staging].[ClaimFactFDS_PreLoad] AS s
			WHERE EXISTS(SELECT 1
							FROM [Staging].[ClaimFactFDS] AS t
							WHERE s.DateOfServiceKey = t.DateOfServiceKey			
						)
			) AS s (DateofServiceKey, PharmacyKey, DrugKey, EventKey, PrescribedRefills, RefillNumber, TotalQuantity, ContractCost, AWP, UandC, CopayAmountSubmitted
				, IngredientCostSubmitted, DispensingFeeSubmitted, IncentiveFeeSubmitted, SalesTaxSubmitted, CopayAmountPaid, IngredientCostPaid, DispensingFeePaid
				, SalesTaxPaid, IncentiveFeePaid, ClaimAmountPaid, QuantityDispensed, DaysSupply, AdjustedContractCost
					) ON t.DateOfServiceKey = s.DateOfServiceKey
					AND t.PharmacyKey = s.PharmacyKey
					AND t.EventKey = s.EventKey
					AND t.DrugKey = s.DrugKey

	WHEN MATCHED THEN
	UPDATE SET t.DateOfServiceKey = s.DateOfServiceKey
		, t.PharmacyKey = s.PharmacyKey
		, t.EventKey = s.EventKey
		, t.DrugKey = s.DrugKey
		, t.PrescribedRefills = s.PrescribedRefills
		, t.RefillNumber = s.RefillNumber
		, t.TotalQuantity = s.TotalQuantity
		, t.ContractCost = s.ContractCost
		, t.AWP = s.AWP
		, t.UandC = s.UandC
		, t.CopayAmountSubmitted = s.CopayAmountSubmitted
		, t.IngredientCostSubmitted = s.IngredientCostSubmitted
		, t.DispensingFeeSubmitted = s.DispensingFeeSubmitted
		, t.IncentiveFeeSubmitted = s.IncentiveFeeSubmitted
		, t.SalesTaxSubmitted = s.SalesTaxSubmitted
		, t.CopayAmountPaid = s.CopayAmountPaid
		, t.IngredientCostPaid = s.IngredientCostPaid
		, t.DispensingFeePaid = s.DispensingFeePaid
		, t.SalesTaxPaid = s.SalesTaxPaid
		, t.IncentiveFeePaid = s.IncentiveFeePaid
		, t.ClaimAmountPaid = s.ClaimAmountPaid
		, t.QuantityDispensed = s.QuantityDispensed
		, t.DaysSupply = s.DaysSupply
		, t.AdjustedContractCost = s.AdjustedContractCost

	WHEN NOT MATCHED THEN
	INSERT(DateofServiceKey, PharmacyKey, DrugKey, EventKey, PrescribedRefills, RefillNumber, TotalQuantity, ContractCost, AWP, UandC, CopayAmountSubmitted
				, IngredientCostSubmitted, DispensingFeeSubmitted, IncentiveFeeSubmitted, SalesTaxSubmitted, CopayAmountPaid, IngredientCostPaid, DispensingFeePaid
				, SalesTaxPaid, IncentiveFeePaid, ClaimAmountPaid, QuantityDispensed, DaysSupply, AdjustedContractCost
			)
	VALUES(s.DateofServiceKey, s.PharmacyKey, s.DrugKey, s.EventKey, s.PrescribedRefills, s.RefillNumber, s.TotalQuantity, s.ContractCost, s.AWP, s.UandC, s.CopayAmountSubmitted
				, s.IngredientCostSubmitted, s.DispensingFeeSubmitted, s.IncentiveFeeSubmitted, s.SalesTaxSubmitted, s.CopayAmountPaid, s.IngredientCostPaid, s.DispensingFeePaid
				, s.SalesTaxPaid, s.IncentiveFeePaid, s.ClaimAmountPaid, s.QuantityDispensed, s.DaysSupply, s.AdjustedContractCost
			);

	--Switch data from Staging into Prod
	ALTER TABLE [Staging].[ClaimFactFDS]
	SWITCH PARTITION @PartitionID 
	TO  [dbo].[ClaimFactFDS] PARTITION @PartitionID

	--Switch data from Staging Preload into Prod
	ALTER TABLE [Staging].[ClaimFactFDS_PreLoad]
	SWITCH PARTITION @PartitionID 
	TO [Archive].[ClaimFactFDS_PreLoad] PARTITION @PartitionID

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
