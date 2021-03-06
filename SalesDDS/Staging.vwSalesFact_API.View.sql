USE [SalesDDS]
GO
/****** Object:  View [Staging].[vwSalesFact_API]    Script Date: 12/22/2020 7:55:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [Staging].[vwSalesFact_API]

AS 

SELECT dt.PharmacyKey
, dt.DateKey
, dt.DrugKey
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
		, ISNULL(dd.DrugKey, 0) AS DrugKey
		FROM Staging.API AS s
		LEFT OUTER JOIN dbo.DrugDim AS dd ON s.NDC = dd.NDC
												AND s.DateKey BETWEEN dd.StartDateKey AND dd.EndDateKey	
		) AS dt
INNER JOIN dbo.EventDimAPI as ed ON dt.RowversionID = ed.RowversionID	
																			
--LEFT OUTER JOIN(SELECT PharmacyKey
--				, PMID
--				, StartDateKey
--				, EndDateKey
--				FROM dbo.PharmacyDim
--				) AS p1 ON ed.[PMID] = p1.PMID
--						AND p1.StartDateKey <= dt.DateKey
--						AND p1.EndDateKey >= dt.EndDateKey
--LEFT OUTER JOIN(SELECT DrugKey
--					, NDC
--					, StartDateKey
--					, EndDateKey
--					FROM dbo.DrugDim							
--					) AS rx ON dt.NDC = rx.NDC
--						AND rx.StartDateKey <= dt.DateKey
--					AND rx.EndDateKey >= dt.EndDateKey

GO
