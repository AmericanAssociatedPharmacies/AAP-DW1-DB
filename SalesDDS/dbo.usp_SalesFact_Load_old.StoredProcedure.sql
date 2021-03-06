USE [SalesDDS]
GO
/****** Object:  StoredProcedure [dbo].[usp_SalesFact_Load_old]    Script Date: 12/22/2020 7:55:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[usp_SalesFact_Load_old]

	@APIStartDateKey INT
	, @APIEndDateKey INT
	, @CAHStartDateKey INT
	, @CAHEndDateKey INT

AS

SET NOCOUNT ON;

BEGIN

	SELECT dt.PharmacyKey
	, dt.DateKey
	, dt.DrugKey
	, dt.APIEventKey
	, dt.CAHEventKey
	, dt.APIInvoiceQuantity
	, dt.APIUnitAmount
	, dt.APILineItemAmount
	, dt.APIExtendedAmount
	, dt.[CAHOrderQuantity]
	, dt.[CAHShipQuantity]
	, dt.[CAHUnitAmount]
	, dt.[CAHExtendedSales]
	, dt.[CAH_AWP]
	, dt.[CAH_WAC]
	FROM(SELECT ISNULL(pd.PharmacyKey, API.PharmacyKey) AS PharmacyKey
		, ISNULL(di.DateKey, API.DateKey) AS DateKey
		, ISNULL(dd.DrugKey, API.DrugKey) AS DrugKey
		, ISNULL(API.APIEventKey, 0) AS APIEventKey
		, ISNULL(CAH.CAHEventKey, 0) AS CAHEventKey
		, API.APIInvoiceQuantity
		, API.APIUnitAmount
		, API.APILineItemAmount
		, API.APIExtendedAmount
		, cah.[CAHOrderQuantity]
		, cah.[CAHShipQuantity]
		, cah.[CAHUnitAmount]
		, cah.[CAHExtendedSales]
		, cah.[CAH_AWP]
		, cah.[CAH_WAC]
		FROM dbo.DrugDim AS dd
		CROSS JOIN dbo.PharmacyDim AS pd 
		CROSS JOIN dbo.DateDim AS di 
		INNER JOIN (SELECT p.PharmacyKey
					, dd.DateKey
					, rx.DrugKey
					, ed.EventKey AS CAHEventKey	
					, CONVERT(INT, s.[ORDER_QTY]) AS [CAHOrderQuantity]
					, CONVERT(INT, s.[SHIP_QTY]) AS [CAHShipQuantity]
					, CONVERT(MONEY, s.[UNIT_COST]) AS [CAHUnitAmount]
					, CONVERT(MONEY, s.[EXT_COST]) AS [CAHExtendedSales]
					, CONVERT(MONEY, s.[CORP_AWP]) AS [CAH_AWP]
					, CONVERT(MONEY, s.[WAC]) AS [CAH_WAC]
					FROM [Staging].[CAH] AS s
					INNER JOIN dbo.EventDimCAH as ed ON CONVERT(VARBINARY(8), s.RowversionID) = ed.CAHRowversionID
					INNER JOIN dbo.DateDim AS dd ON ed.CAHInvoiceDate = dd.TheDate
					INNER JOIN dbo.PharmacyDim AS p ON ed.[CAH_PMID] = p.PMID
					INNER JOIN dbo.DrugDim AS rx ON ed.CAH_NDC = rx.NDC
					WHERE s.DateKey >= @CAHStartDateKey
					AND s.DateKey < @CAHEndDateKey
					) AS CAH ON CAH.PharmacyKey = pd.PharmacyKey
								AND CAH.DateKey = di.DateKey
								AND CAH.DrugKey = dd.DrugKey
		FULL OUTER JOIN(SELECT p.PharmacyKey
						, dd.DateKey
						, rx.DrugKey
						, ed.EventKey AS APIEventKey
						, CONVERT(INT, [Qty]) AS APIInvoiceQuantity
						, CONVERT(MONEY, [UnitAmount]) AS APIUnitAmount
						, CONVERT(MONEY, [LineAmt]) AS APILineItemAmount
						, CONVERT(MONEY, [ExtSales]) AS APIExtendedAmount
						FROM Staging.API AS s
						INNER JOIN dbo.EventDimAPI as ed ON CONVERT(VARBINARY(8), s.RowversionID) = ed.APIRowversionID
						INNER JOIN dbo.DateDim AS dd ON ed.APIInvoiceDate = dd.TheDate
						INNER JOIN dbo.PharmacyDim AS p ON ed.[API_PMID] = p.PMID
						INNER JOIN dbo.DrugDim AS rx ON ed.APINDC = rx.NDC
						WHERE dd.DateKey >= @APIStartDateKey
						AND dd.DateKey < @APIEndDateKey
						) AS API ON API.PharmacyKey = pd.PharmacyKey
								AND API.DateKey = di.DateKey
								AND API.DrugKey = dd.DrugKey
		
	) AS dt
	WHERE NOT EXISTS(SELECT 1
					FROM dbo.SalesFact AS sf WITH(NOLOCK)
					WHERE dt.PharmacyKey = sf.PharmacyKey
					AND dt.DateKey = sf.DateKey
					AND dt.DrugKey = sf.DrugKey
					AND dt.APIEventKey = sf.APIEventKey
					AND dt.CAHEventKey = sf.CAHEventKey
						)
	ORDER BY dt.PharmacyKey ASC
	, dt.DateKey ASC
	, dt.DrugKey ASC
	, dt.APIEventKey ASC
	, dt.CAHEventKey ASC

END

GO
