USE [ClaimsDDS]
GO
/****** Object:  StoredProcedure [dbo].[usp_ClaimFact_fromRX30ClaimFact_Load]    Script Date: 12/22/2020 6:54:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_ClaimFact_fromRX30ClaimFact_Load]

	@DateKey INT

AS

SET NOCOUNT ON;

BEGIN

	DECLARE @EndDateKey INT
	, @EndDate DATETIME

	--Convert DateKey to DATETIME
	SET @EndDate = CONVERT(datetime, convert(varchar(10), @DateKey))

	--Add 1 day and then convert back to INT data type
	SET @EndDateKey = CONVERT(INT, CONVERT(VARCHAR(20), DATEADD(DAY, 1, @EndDate),112))

	
	SELECT dt.DateKey,  dt.PharmacyKey, dt.RX30EventKey, dt.FDSEventKey, dt.DrugKey
	, dt.DispensingFeeSubmited, dt.IngredientCostSubmitted, dt.DispensingFeePaid, dt.IngredientCostPaid, dt.TotalAmountPaid, dt.AmountofCopay
	, dt.UsualandCustomaryCharge, dt.TotalPrice, dt.PatientPayAmount, dt.GrossAmountDue, dt.OtherAmount, dt.FlatSalesTaxAmountPaid, dt.PercentageSalesTaxAmountPaid
	, dt.PercentageSalesTaxRate, dt.PercentageSalesTaxBasisPaid, dt.IncentiveAmountPaid, dt.AWPUnitPrice, dt.CardinalPharmacyCost, dt.APIPharmacyCost, dt.UnitOfSale
	, dt.TransactionCount, dt.RxDiscount, dt.QuantityDispensed
	FROM(SELECT cf.DateKey, ISNULL(pd1.Pharmacykey, pd2.Pharmacykey) AS PharmacyKey, ed.EventKey AS RX30EventKey, 0 AS FDSEventKey, ISNULL(rx.DrugKey, 0) AS DrugKey
	, cf.DispensingFeeSubmited, cf.IngredientCostSubmitted, cf.DispensingFeePaid, cf.IngredientCostPaid, cf.TotalAmountPaid, cf.AmountofCopay
	, cf.UsualandCustomaryCharge, cf.TotalPrice, cf.PatientPayAmount, cf.GrossAmountDue, cf.OtherAmount, cf.FlatSalesTaxAmountPaid, cf.PercentageSalesTaxAmountPaid
	, cf.PercentageSalesTaxRate, cf.PercentageSalesTaxBasisPaid, cf.IncentiveAmountPaid, cf.AWPUnitPrice, cf.CardinalPharmacyCost, cf.APIPharmacyCost, cf.UnitOfSale
	, cf.TransactionCount, cf.RxDiscount, e.QuantityDispensed
	FROM RX30.dbo.ClaimFact AS cf
	INNER JOIN [dbo].[RX30_OldEventDimPk] AS r ON cf.EventKey = r.OldEventDimPk
											AND cf.DateKey = r.DateKey
	INNER JOIN dbo.EventDimRX30 AS ed ON ed.OldEventDimPk = r.OldEventDimPk
	INNER JOIN Rx30.dbo.EventDim AS e ON cf.EventKey = e.EventKey
										AND r.OldEventDimPk = e.EventKey
	LEFT OUTER JOIN(SELECT PharmacyKey
						, NPI
						FROM dbo.PharmacyDim
						WHERE StartDateKey <= @DateKey
						AND EndDateKey > @EndDateKey                           
						) AS pd1 ON ed.[ServiceProviderID] = pd1.NPI
	LEFT OUTER JOIN(SELECT PharmacyKey
					, NCPDP
					FROM dbo.PharmacyDim
					WHERE StartDateKey <= @DateKey
					AND EndDateKey > @EndDateKey                           
					) AS pd2 ON ed.[ServiceProviderID] = pd2.NCPDP
	LEFT OUTER JOIN(SELECT DrugKey
					, NDC
					, CONVERT(MONEY, ISNULL(G.Unit_Price, 0.00)) AS AWP
					FROM dbo.DrugDim AS dd
					LEFT OUTER JOIN [Medispan_Staging].dbo.MF2PRC_M AS G ON G.NDC_UPC_HRI = dd.NDC AND G.Price_Code = 'A' -- AWP
					WHERE StartDateKey <= @DateKey
					AND EndDateKey > @EndDateKey
					) AS rx ON ed.NDC = rx.NDC
	WHERE cf.DateKey = @DateKey
	AND r.DateKey = @DateKey
	AND (pd1.Pharmacykey IS NOT NULL
				  OR pd2.Pharmacykey IS NOT NULL
				  ) 
	) AS dt
	ORDER BY dt.DateKey ASC,  dt.PharmacyKey ASC, dt.RX30EventKey ASC, dt.FDSEventKey ASC, dt.DrugKey ASC

END
GO
