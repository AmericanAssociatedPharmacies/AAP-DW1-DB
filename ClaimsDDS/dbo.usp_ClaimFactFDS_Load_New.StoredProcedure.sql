USE [ClaimsDDS]
GO
/****** Object:  StoredProcedure [dbo].[usp_ClaimFactFDS_Load_New]    Script Date: 12/22/2020 6:54:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_ClaimFactFDS_Load_New]

	@DateKey INT

AS

SET NOCOUNT ON;

BEGIN

	SELECT DateofServiceKey, PharmacyKey, DrugKey, EventKey, PrescribedRefills, RefillNumber
	, TotalQuantity, ContractCost, AWP, UandC, CopayAmountSubmitted, IngredientCostSubmitted
	, DispensingFeeSubmitted, IncentiveFeeSubmitted, SalesTaxSubmitted, CopayAmountPaid
	, IngredientCostPaid, DispensingFeePaid, SalesTaxPaid, IncentiveFeePaid, ClaimAmountPaid
	, QuantityDispensed, DaysSupply, AdjustedContractCost, TransactionCount
	, IsPaidClaim, OtherAmountPaid, eVoucherAmountPaid, DispensedRevenue, BrandCost
	, GenericCost, SPXCost, GPIKey
	FROM dbo.ClaimFactFDS
	WHERE DateofServiceKey = @DateKey

END
GO
