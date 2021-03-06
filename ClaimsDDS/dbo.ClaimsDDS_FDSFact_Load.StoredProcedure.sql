USE [ClaimsDDS]
GO
/****** Object:  StoredProcedure [dbo].[ClaimsDDS_FDSFact_Load]    Script Date: 12/22/2020 6:54:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[ClaimsDDS_FDSFact_Load]

	@DateKey INT


AS

SET NOCOUNT ON;

BEGIN

	SELECT [DateofServiceKey], [PharmacyKey], [DrugKey], [EventKey], [PrescribedRefills], [RefillNumber], [TotalQuantity], [ContractCost], [AWP], [UandC], [CopayAmountSubmitted]
		, [IngredientCostSubmitted], [DispensingFeeSubmitted], [IncentiveFeeSubmitted], [SalesTaxSubmitted], [CopayAmountPaid], [IngredientCostPaid], [DispensingFeePaid], [SalesTaxPaid]
		, [IncentiveFeePaid], [ClaimAmountPaid], [QuantityDispensed], [DaysSupply], [AdjustedContractCost], [TransactionCount], [OtherAmountPaid], [eVoucherAmountPaid]
	FROM(SELECT ROW_NUMBER() OVER(PARTITION BY [DateofServiceKey], [PharmacyKey], [DrugKey], [EventKey] ORDER BY(SELECT NULL)) AS RN
		, [DateofServiceKey], [PharmacyKey], [DrugKey], [EventKey], [PrescribedRefills], [RefillNumber], [TotalQuantity], [ContractCost], [AWP], [UandC], [CopayAmountSubmitted]
		, [IngredientCostSubmitted], [DispensingFeeSubmitted], [IncentiveFeeSubmitted], [SalesTaxSubmitted], [CopayAmountPaid], [IngredientCostPaid], [DispensingFeePaid], [SalesTaxPaid]
		, [IncentiveFeePaid], [ClaimAmountPaid], [QuantityDispensed], [DaysSupply], [AdjustedContractCost], [TransactionCount], [OtherAmountPaid], [eVoucherAmountPaid]
		FROM [Staging].[ClaimFactFDS]	
		WHERE [DateofServiceKey] = @DateKey
		) AS dt
	WHERE dt.RN = 1
	AND NOT EXISTS(SELECT 1
					FROM dbo.ClaimFactFDS AS c WITH(NOLOCK)
					WHERE dt.[DateofServiceKey] = c.[DateofServiceKey]
					AND dt.[PharmacyKey] = c.PharmacyKey
					AND dt.[DrugKey] = c.DrugKey
					AND dt.[EventKey] = c.EventKey	
				)

END
GO
