USE [ClaimsDDS]
GO
/****** Object:  StoredProcedure [dbo].[usp_ClaimsDDS_LoadClaimFactFromRX30]    Script Date: 12/22/2020 6:54:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[usp_ClaimsDDS_LoadClaimFactFromRX30]

	@DateKey INT

AS

SET NOCOUNT ON;

BEGIN

	DECLARE @EndDateKey INT
	, @Date DATETIME

	SET @EndDateKey = CAST(CONVERT(varchar(20),DATEADD(DAY, 1 ,CONVERT(datetime, convert(varchar(10), @DateKey))),112) as INT);

	SET @Date = CONVERT(datetime, convert(varchar(10), @DateKey));

	SELECT dt.[RX30EventKey], dt.DateKey, dt.DrugKey, dt.DispensingFeeSubmited
		, dt.IngredientCostSubmitted, DispensingFeePaid, IngredientCostPaid, TotalAmountPaid, AmountofCopay
		, dt.UsualandCustomaryCharge, TotalPrice, PatientPayAmount, GrossAmountDue, OtherAmount, FlatSalesTaxAmountPaid
		, dt.PercentageSalesTaxAmountPaid, PercentageSalesTaxRate, PercentageSalesTaxBasisPaid, IncentiveAmountPaid, AWPUnitPrice
		, dt.CardinalPharmacyCost, APIPharmacyCost, UnitOfSale, TransactionCount, dt.RowCreatedDate, RxDiscount, dt.FDSEventKey
		--, e.QuantityDispensed
	FROM(SELECT e.EventKey AS [RX30EventKey], cf.DateKey, ISNULL(rx.DrugKey, 0) AS DrugKey, cf.DispensingFeeSubmited
		, cf.IngredientCostSubmitted, DispensingFeePaid, IngredientCostPaid, TotalAmountPaid, AmountofCopay
		, cf.UsualandCustomaryCharge, TotalPrice, PatientPayAmount, GrossAmountDue, OtherAmount, FlatSalesTaxAmountPaid
		, cf.PercentageSalesTaxAmountPaid, PercentageSalesTaxRate, PercentageSalesTaxBasisPaid, IncentiveAmountPaid, AWPUnitPrice
		, cf.CardinalPharmacyCost, APIPharmacyCost, UnitOfSale, TransactionCount, cf.RowCreatedDate, RxDiscount, 0 AS FDSEventKey
		--, p1.PharmacyKey
		, ISNULL(ISNULL(p1.PharmacyKey, p2.PharmacyKey),0) AS PharmacyKey
		FROM Rx30.dbo.ClaimFact AS cf
		INNER JOIN ClaimsDDS.dbo.EventDimRX30 AS e ON cf.EventKey = e.OldEventDimPk
		INNER JOIN RX30.dbo.EventDim AS ed ON cf.EventKey = e.OldEventDimPk
		LEFT OUTER JOIN(SELECT DrugKey
							, NDC
							FROM dbo.DrugDim
							WHERE StartDateKey <= @DateKey
							AND EndDateKey > @EndDateKey
							) AS rx ON e.NDC = rx.NDC
		LEFT OUTER JOIN(SELECT PharmacyKey
						, NPI
						FROM dbo.PharmacyDim
						WHERE StartDateKey <= @DateKey
						AND EndDateKey > @EndDateKey				
						) AS p1 ON p1.NPI = e.ServiceProviderID 
		LEFT OUTER JOIN(SELECT PharmacyKey
						, NCPDP
						FROM dbo.PharmacyDim
						WHERE StartDateKey <= @DateKey
						AND EndDateKey > @EndDateKey	
						) AS p2 ON p2.NCPDP = e.ServiceProviderID
		WHERE cf.DateKey = @DateKey
		AND(p1.PharmacyKey IS NOT NULL
				OR p2.PharmacyKey IS NOT NULL	
			)
		) AS dt
	INNER JOIN RX30.dbo.EventDim AS e ON dt.RX30EventKey = e.EventKey
	ORDER BY dt.[RX30EventKey] ASC, dt.DateKey ASC, dt.DrugKey ASC 



END
GO
