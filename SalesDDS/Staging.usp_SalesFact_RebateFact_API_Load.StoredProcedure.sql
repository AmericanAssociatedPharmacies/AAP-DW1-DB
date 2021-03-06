USE [SalesDDS]
GO
/****** Object:  StoredProcedure [Staging].[usp_SalesFact_RebateFact_API_Load]    Script Date: 12/22/2020 7:55:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO













CREATE PROCEDURE [Staging].[usp_SalesFact_RebateFact_API_Load]

	@DateKey INT 

AS

SET NOCOUNT ON;

BEGIN


	DECLARE @EndDateKey INT

	
	SELECT dt.PharmacyKey
	, dt.DateKey
	, dt.DrugKey
	, dt.APIEventKey
	, dt.APIEventDateKey
	, dt.APIInvoiceQuantity
	, dt.APIUnitAmount
	, dt.APILineItemAmount
	, dt.APIExtendedAmount
	, dt.APIHoldbackPercent
	, dt.APIHoldbackAmount
	, dt.RebateAfterAPIHoldbackAmount
	, dt.AffiliateHoldbackPercent
	, dt.AffiliateHoldbackAmount
	, dt.FinalRebateAmount
	, dt.TransactionCount	
	, dt.IsCredit
	, dt.GPIKey
	FROM(SELECT ROW_NUMBER() OVER(PARTITION BY dt.PharmacyKey, dt.DateKey, ISNULL(dd.DrugKey, 0), ed.EventKey, dt.APIEventDateKey ORDER BY(SELECT NULL)) AS RN
		, dt.PharmacyKey
		, dt.DateKey
		, ISNULL(dd.DrugKey, 0) AS DrugKey
		, ed.EventKey AS APIEventKey
		, dt.APIEventDateKey
		, dt.APIInvoiceQuantity
		, dt.APIUnitAmount
		, dt.APILineItemAmount
		, dt.APIExtendedAmount
		, dt.APIHoldbackPercent
		, dt.APIHoldbackAmount
		, dt.RebateAfterAPIHoldbackAmount
		, dt.AffiliateHoldbackPercent
		, dt.AffiliateHoldbackAmount
		, dt.FinalRebateAmount
		, dt.TransactionCount
		, dt.IsCredit
		, dd.GPIKey
		FROM(SELECT s.PharmacyKey
			, s.DateKey          
			, s.DateKey AS APIEventDateKey
			, CONVERT(INT, [Qty]) AS APIInvoiceQuantity
			, CONVERT(MONEY, [UnitAmount]) AS APIUnitAmount
			, CONVERT(MONEY, [LineAmt]) AS APILineItemAmount
			, CONVERT(MONEY, [ExtSales]) AS APIExtendedAmount
			, CONVERT(DECIMAL(18,4), s.[APIHoldbackPercent]) AS APIHoldbackPercent
			, CONVERT(MONEY, s.[APIHoldbackAmount]) AS APIHoldbackAmount
			, CONVERT(MONEY, s.[RebateAfterAPIHoldbackAmount]) AS RebateAfterAPIHoldbackAmount
			, CONVERT(DECIMAL(18,4), s.[AffiliateHoldbackPercent]) AS AffiliateHoldbackPercent
			, CONVERT(MONEY, s.[AffiliateHoldbackAmount]) AS AffiliateHoldbackAmount
			, CONVERT(MONEY, s.[FinalRebateAmount]) AS FinalRebateAmount
			, s.RowversionID
			, CAST(CONVERT(varchar(20),DATEADD(DAY, 1 ,CONVERT(datetime, convert(varchar(10), s.DateKey))),112) as INT) AS EndDateKey
			, s.NDC
			, CONVERT(TINYINT, 1) AS TransactionCount
			, s.IsCredit
			FROM Staging.API AS s
			WHERE s.DateKey = @DateKey
			) AS dt
		INNER JOIN dbo.EventDimAPI as ed ON dt.RowversionID = ed.[RowversionIDOnDB1]   
											AND ed.DateKey = dt.APIEventDateKey   
		LEFT OUTER JOIN dbo.DrugDim AS dd ON dt.NDC = dd.NDC			
											AND dt.DateKey BETWEEN dd.StartDateKey AND dd.EndDateKey                                                                                                                      
		) AS dt
	WHERE dt.RN = 1
	ORDER BY dt.PharmacyKey ASC
	, dt.DateKey ASC
	, dt.DrugKey ASC
	, dt.APIEventKey ASC
	, dt.APIEventDateKey ASC


END




GO
