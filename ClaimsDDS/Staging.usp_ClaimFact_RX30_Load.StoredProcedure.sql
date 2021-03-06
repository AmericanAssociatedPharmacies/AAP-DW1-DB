USE [ClaimsDDS]
GO
/****** Object:  StoredProcedure [Staging].[usp_ClaimFact_RX30_Load]    Script Date: 12/22/2020 6:54:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO









CREATE PROCEDURE [Staging].[usp_ClaimFact_RX30_Load]


AS

SET NOCOUNT ON;

BEGIN

	SELECT DateOfServiceKey, PharmacyKey, EventKey, DrugKey, DispensingFeeSubmitted, IngredientCostSubmitted, DispensingFeePaid, IngredientCostPaid, TotalAmountPaid, AmountofCopay, UsualandCustomaryCharge
	, TotalPrice, PatientPayAmount, GrossAmountDue, OtherAmount, FlatSalesTaxAmountPaid, PercentageSalesTaxAmountPaid, PercentageSalesTaxRate, PercentageSalesTaxBasisPaid, IncentiveAmountPaid
	, AWPUnitPrice, CardinalPharmacyCost, APIPharmacyCost, UnitOfSale, TransactionCount, RXDiscount, QuantityDispensed
	FROM(SELECT ROW_NUMBER() OVER(PARTITION BY DateOfServiceKey, PharmacyKey, EventKey, DrugKey ORDER BY(SELECT NULL)) AS RN
		, DateOfServiceKey, PharmacyKey, EventKey, DrugKey, DispensingFeeSubmitted, IngredientCostSubmitted, DispensingFeePaid, IngredientCostPaid, TotalAmountPaid, AmountofCopay, UsualandCustomaryCharge
		, TotalPrice, PatientPayAmount, GrossAmountDue, OtherAmount, FlatSalesTaxAmountPaid, PercentageSalesTaxAmountPaid, PercentageSalesTaxRate, PercentageSalesTaxBasisPaid, IncentiveAmountPaid
		, AWPUnitPrice, CardinalPharmacyCost, APIPharmacyCost, UnitOfSale, TransactionCount, RXDiscount, QuantityDispensed
		FROM [Staging].[vwClaimFactRX30]
		) AS dt
	WHERE dt.RN = 1
		ORDER BY dt.DateOfServiceKey ASC
		, dt.PharmacyKey ASC
		, dt.EventKey ASC
		, dt.DrugKey ASC	


END
	











GO
