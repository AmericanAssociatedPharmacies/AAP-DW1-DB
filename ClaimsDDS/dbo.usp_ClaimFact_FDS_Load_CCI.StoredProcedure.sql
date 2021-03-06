USE [ClaimsDDS]
GO
/****** Object:  StoredProcedure [dbo].[usp_ClaimFact_FDS_Load_CCI]    Script Date: 12/22/2020 6:54:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO














CREATE PROCEDURE [dbo].[usp_ClaimFact_FDS_Load_CCI]

	

AS

SET NOCOUNT ON;

BEGIN

	INSERT INTO [dbo].[ClaimFactFDS]([MonthYearKey], DateOfServiceKey, PharmacyKey, DrugKey, EventKey, PrescribedRefills, RefillNumber, TotalQuantity, ContractCost, AWP, UandC, CopayAmountSubmitted, IngredientCostSubmitted
	, DispensingFeeSubmitted, IncentiveFeeSubmitted, SalesTaxSubmitted, CopayAmountPaid, IngredientCostPaid, DispensingFeePaid, SalesTaxPaid, IncentiveFeePaid
	, ClaimAmountPaid, QuantityDispensed, DaysSupply, AdjustedContractCost, TransactionCount, [OtherAmountPaid], [eVoucherAmountPaid], [DispensedRevenue], [BrandCost], [GenericCost], [SPXCost], GPIKey
	)
	SELECT [MonthYearKey], DateOfServiceKey, PharmacyKey, DrugKey, EventKey, PrescribedRefills, RefillNumber, TotalQuantity, ContractCost, AWP, UandC, CopayAmountSubmitted, IngredientCostSubmitted
	, DispensingFeeSubmitted, IncentiveFeeSubmitted, SalesTaxSubmitted, CopayAmountPaid, IngredientCostPaid, DispensingFeePaid, SalesTaxPaid, IncentiveFeePaid
	, ClaimAmountPaid, QuantityDispensed, DaysSupply, AdjustedContractCost, TransactionCount, [OtherAmountPaid], [eVoucherAmountPaid], [DispensedRevenue], [BrandCost], [GenericCost], [SPXCost], GPIKey
	FROM(SELECT [MonthYearKey], DateOfServiceKey, PharmacyKey, DrugKey, EventKey, PrescribedRefills, RefillNumber, TotalQuantity, ContractCost, AWP, UandC
	, CopayAmountSubmitted, IngredientCostSubmitted, DispensingFeeSubmitted, IncentiveFeeSubmitted, SalesTaxSubmitted, CopayAmountPaid
	, IngredientCostPaid, DispensingFeePaid, SalesTaxPaid, IncentiveFeePaid, ClaimAmountPaid, QuantityDispensed, DaysSupply, AdjustedContractCost, TransactionCount
	, [OtherAmountPaid], [eVoucherAmountPaid], [DispensedRevenue], [BrandCost], [GenericCost], [SPXCost], GPIKey
	FROM Staging.ClaimFactFDS (NOLOCK)
	) AS dt
	WHERE NOT EXISTS(SELECT 1
					FROM dbo.ClaimFactFDS AS c WITH(NOLOCK)
					WHERE dt.DateOfServiceKey = c.DateOfServiceKey
					AND dt.PharmacyKey = c.PharmacyKey
					AND dt.DrugKey = c.DrugKey
					AND dt.EventKey = c.EventKey
					)
	ORDER BY DateOfServiceKey ASC
	, PharmacyKey ASC
	, DrugKey ASC
	, EventKey ASC


END












GO
