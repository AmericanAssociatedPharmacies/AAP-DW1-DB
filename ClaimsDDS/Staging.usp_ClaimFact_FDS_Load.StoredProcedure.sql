USE [ClaimsDDS]
GO
/****** Object:  StoredProcedure [Staging].[usp_ClaimFact_FDS_Load]    Script Date: 12/22/2020 6:54:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [Staging].[usp_ClaimFact_FDS_Load]

	@DateKey INT 


AS

SET NOCOUNT ON;

BEGIN

	SELECT DateOfServiceKey, PharmacyKey, DrugKey, EventKey, PrescribedRefills, RefillNumber, TotalQuantity, ContractCost, AWP, UandC, CopayAmountSubmitted, IngredientCostSubmitted
	, DispensingFeeSubmitted, IncentiveFeeSubmitted, SalesTaxSubmitted, CopayAmountPaid, IngredientCostPaid, DispensingFeePaid, SalesTaxPaid, IncentiveFeePaid
	, ClaimAmountPaid, QuantityDispensed, DaysSupply, AdjustedContractCost, TransactionCount, [OtherAmountPaid], [eVoucherAmountPaid], GPIKey, MonthYearKey
	FROM(SELECT ROW_NUMBER() OVER(PARTITION BY DateOfServiceKey, PharmacyKey, DrugKey, EventKey ORDER BY(SELECT 1)) AS RN
	, DateOfServiceKey, PharmacyKey, DrugKey, EventKey, PrescribedRefills, RefillNumber, TotalQuantity, ContractCost, AWP, UandC
	, CopayAmountSubmitted, IngredientCostSubmitted, DispensingFeeSubmitted, IncentiveFeeSubmitted, SalesTaxSubmitted, CopayAmountPaid
	, IngredientCostPaid, DispensingFeePaid, SalesTaxPaid, IncentiveFeePaid, ClaimAmountPaid, QuantityDispensed, DaysSupply, AdjustedContractCost, TransactionCount
	, [OtherAmountPaid], [eVoucherAmountPaid], GPIKey, MonthYearKey
	FROM Staging.vwClaimFactFDS	
	WHERE DateOfServiceKey = @DateKey
	) AS dt
	WHERE dt.RN = 1
	ORDER BY DateOfServiceKey ASC
	, PharmacyKey ASC
	, DrugKey ASC
	, EventKey ASC


END









GO
