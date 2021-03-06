USE [ClaimsDDS]
GO
/****** Object:  View [Staging].[vwClaimFactRX30]    Script Date: 12/22/2020 6:54:01 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [Staging].[vwClaimFactRX30]


AS

SELECT ISNULL(d.DateKey, 0) AS DateOfServiceKey
	, r.PharmacyKey
	, e.EventKey
	, ISNULL(rx.DrugKey, 0) AS DrugKey
	, r.DispensingFeeSubmitted
	, r.IngredientCostSubmitted
	, r.DispensingFeePaid
	, r.IngredientCostPaid
	, r.TotalAmountPaid
	, r.AmountofCopay
	, r.UsualandCustomaryCharge
	, r.TotalPrice
	, r.PatientPayAmount
	, r.GrossAmountDue
	, r.OtherAmount
	, FlatSalesTaxAmountPaid
	, r.PercentageSalesTaxAmountPaid
	, r.PercentageSalesTaxRate
	, r.PercentageSalesTaxBasisPaid
	, r.IncentiveAmountPaid
	, r.[AWPUnitPrice]
	, r.[CardinalPharmacyCost]
	, r.[APIPharmacyCost]
	, r.[UnitOfSale]
	, r.[TransactionCount]
	, r.RXDiscount
	, r.QuantityDispensed 
	FROM(SELECT DateKey AS DateOfServiceKey
		, PharmacyKey
		, DispensingFeeSubmitted
		, IngredientCostSubmitted
		, DispensingFeePaid
		, IngredientCostPaid
		, TotalAmountPaid
		, AmountofCopay
		, UsualandCustomaryCharge
		, TotalPrice
		, PatientPayAmount
		, GrossAmountDue
		, OtherAmount
		, FlatSalesTaxAmountPaid
		, PercentageSalesTaxAmountPaid
		, PercentageSalesTaxRate
		, CONVERT(MONEY, PercentageSalesTaxBasisPaid) AS PercentageSalesTaxBasisPaid
		, IncentiveAmountPaid
		, CONVERT(NUMERIC(13,5), UnitAWP) AS [AWPUnitPrice]
		, CONVERT(MONEY, 0.00) AS [CardinalPharmacyCost]
		, CONVERT(MONEY, 0.00) [APIPharmacyCost]
		, CONVERT(MONEY, 0.00) AS [UnitOfSale]
		, CONVERT(TINYINT, 1) AS [TransactionCount]
		, RXDiscount
		, QuantityDispensed 
		, RowVersionID
		, NDC
		, CONVERT(INT, CONVERT(VARCHAR(20), DATEADD(DAY, 1, CONVERT(datetime, convert(varchar(10), DateKey))),112)) AS EndDateKey
		FROM Staging.Rx30
		) AS r
	INNER JOIN dbo.EventDimRX30 AS e ON r.RowversionID = e.RowversionID
	LEFT OUTER JOIN dbo.DateDim AS d ON r.DateOfServiceKey = d.DateKey
	LEFT OUTER JOIN(SELECT DrugKey
					, NDC
					, StartDateKey
					, EndDateKey
					FROM dbo.DrugDim AS dd
					) AS rx ON r.NDC = rx.NDC
								AND rx.StartDateKey <= r.DateOfServiceKey
								AND rx.EndDateKey >= r.EndDateKey
GO
