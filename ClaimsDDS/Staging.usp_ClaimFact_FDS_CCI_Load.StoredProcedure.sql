USE [ClaimsDDS]
GO
/****** Object:  StoredProcedure [Staging].[usp_ClaimFact_FDS_CCI_Load]    Script Date: 12/22/2020 6:54:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO










CREATE PROCEDURE [Staging].[usp_ClaimFact_FDS_CCI_Load]

	


AS

SET NOCOUNT ON;

BEGIN

	INSERT INTO [Staging].[ClaimFactFDS]([MonthYearKey], DateOfServiceKey, PharmacyKey, DrugKey, EventKey, PrescribedRefills, RefillNumber, TotalQuantity, ContractCost, AWP, UandC, CopayAmountSubmitted, IngredientCostSubmitted
										, DispensingFeeSubmitted, IncentiveFeeSubmitted, SalesTaxSubmitted, CopayAmountPaid, IngredientCostPaid, DispensingFeePaid, SalesTaxPaid, IncentiveFeePaid
										, ClaimAmountPaid, QuantityDispensed, DaysSupply, AdjustedContractCost, TransactionCount, [OtherAmountPaid], [eVoucherAmountPaid]
										, GPIKey)
	SELECT [MonthYearKey], DateOfServiceKey, PharmacyKey, DrugKey, EventKey, PrescribedRefills, RefillNumber, TotalQuantity, ContractCost, AWP, UandC, CopayAmountSubmitted, IngredientCostSubmitted
	, DispensingFeeSubmitted, IncentiveFeeSubmitted, SalesTaxSubmitted, CopayAmountPaid, IngredientCostPaid, DispensingFeePaid, SalesTaxPaid, IncentiveFeePaid
	, ClaimAmountPaid, QuantityDispensed, DaysSupply, AdjustedContractCost, TransactionCount, [OtherAmountPaid], [eVoucherAmountPaid], GPIKey
	FROM Staging.vwClaimFactFDS
	ORDER BY DateOfServiceKey ASC
	, PharmacyKey ASC
	, DrugKey ASC
	, EventKey ASC
	


END








GO
