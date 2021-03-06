USE [ClaimsDDS]
GO
/****** Object:  StoredProcedure [Staging].[usp_ClaimFact_FDS_PreLoad]    Script Date: 12/22/2020 6:54:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [Staging].[usp_ClaimFact_FDS_PreLoad]

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


	SELECT s.DateKey AS DateOfServiceKey
	, s.PharmacyKey
	, ISNULL(rx.DrugKey, 0) AS DrugKey
	, e.EventKey
	, s.PrescribedRefills
	, s.RefillNumber
	, s.TotalQuantity
	, s.ContractCost
	, s.AWP
	, s.UandC
	, s.CopayAmountSubmitted
	, s.IngredientCostSubmitted
	, s.DispensingFeeSubmitted
	, s.IncentiveFeeSubmitted
	, s.SalesTaxSubmitted
	, s.CopayAmountPaid
	, s.IngredientCostPaid
	, s.DispensingFeePaid
	, s.SalesTaxPaid
	, s.IncentiveFeePaid
	, s.ClaimAmountPaid
	, s.QuantityDispensed
	, s.DaysSupply
	, s.AdjustedContractCost
	--INTO ##foo
	FROM Staging.FDS AS s
	INNER JOIN dbo.EventDimFDS AS e ON s.RowversionID = e.RowversionID
	LEFT OUTER JOIN(SELECT DrugKey
							, NDC
							, CONVERT(MONEY, ISNULL(G.Unit_Price, 0.00)) AS AWP
							FROM dbo.DrugDim AS dd
							LEFT OUTER JOIN [Medispan_Staging].dbo.MF2PRC_M AS G ON G.NDC_UPC_HRI = dd.NDC AND G.Price_Code = 'A' -- AWP
							WHERE StartDateKey <= @DateKey
							AND EndDateKey > @EndDateKey
							) AS rx ON s.DispensedProductID = rx.NDC
	WHERE s.DateKey = @DateKey


END

GO
