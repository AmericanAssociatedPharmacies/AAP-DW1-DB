USE [ClaimsDDS]
GO
/****** Object:  View [Staging].[vwClaimFactFDS]    Script Date: 12/22/2020 6:54:01 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







CREATE VIEW [Staging].[vwClaimFactFDS]


AS

SELECT dt.[MonthYearKey]
	, dt.DateOfServiceKey
	, dt.PharmacyKey
	, ISNULL(dd.DrugKey, 0) AS DrugKey
	, dt.EventKey
	, dt.PrescribedRefills
	, dt.RefillNumber
	, dt.TotalQuantity
	, dt.ContractCost
	, dt.AWP
	, dt.UandC
	, dt.CopayAmountSubmitted
	, dt.IngredientCostSubmitted
	, dt.DispensingFeeSubmitted
	, dt.IncentiveFeeSubmitted
	, dt.SalesTaxSubmitted
	, dt.CopayAmountPaid
	, dt.IngredientCostPaid
	, dt.DispensingFeePaid
	, dt.SalesTaxPaid
	, dt.IncentiveFeePaid
	, dt.ClaimAmountPaid
	, dt.QuantityDispensed
	, dt.DaysSupply
	, dt.AdjustedContractCost
	, dt.TransactionCount
	, dt.OtherAmountPaid
	, dt.eVoucherAmountPaid
	, ISNULL(dd.GPIKey,0) AS GPIKey	
	FROM(SELECT d.CCYYMM AS MonthYearKey
			, s.DateKey AS DateOfServiceKey
			, s.PharmacyKey
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
			, CONVERT(INT, CONVERT(VARCHAR(20), DATEADD(DAY, 1, CONVERT(datetime, convert(varchar(10), s.DateKey))),112)) AS EndDatekey
			, s.DispensedProductID
			, CONVERT(TINYINT, 1) AS TransactionCount
			, s.OtherAmountPaid
			, s.eVoucherAmountPaid			
			FROM Staging.FDS AS s
			INNER JOIN dbo.DateDim AS d on s.DateKey = d.DateKey
			INNER JOIN dbo.EventDimFDS AS e ON s.RowversionID = e.RowversionID
			) as dt
	LEFT OUTER JOIN dbo.DrugDim AS dd ON dt.DispensedProductID = dd.NDC
											AND dt.DateOfServiceKey BETWEEN dd.StartDateKey AND dd.EndDateKey








GO
