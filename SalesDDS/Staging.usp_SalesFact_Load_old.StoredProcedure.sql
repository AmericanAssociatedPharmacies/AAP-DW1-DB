USE [SalesDDS]
GO
/****** Object:  StoredProcedure [Staging].[usp_SalesFact_Load_old]    Script Date: 12/22/2020 7:55:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







CREATE PROCEDURE [Staging].[usp_SalesFact_Load_old]

	@DateKey INT

AS

SET NOCOUNT ON;


BEGIN

DECLARE @RXDimEndDateKey INT

--Convert DateKey to INT, add 1 day, convert back to INT
SET @RXDimEndDateKey = CAST(CONVERT(varchar(20),DATEADD(DAY, 1 ,CONVERT(datetime, convert(varchar(10), @DateKey))),112) as INT);

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
	FROM(SELECT ROW_NUMBER() OVER(PARTITION BY dt.PharmacyKey, dt.DateKey, dt.DrugKey, dt.APIEventKey, dt.CAHEventKey ORDER BY (SELECT NULL)) AS RN
		, dt.PharmacyKey
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
			INNER JOIN (SELECT ISNULL(p.PharmacyKey, 0) AS PharmacyKey
						, dd.DateKey
						, ISNULL(rx.DrugKey, 0) AS DrugKey
						, ed.EventKey AS CAHEventKey	
						, CONVERT(INT, s.[ORDER_QTY]) AS [CAHOrderQuantity]
						, CONVERT(INT, s.[SHIP_QTY]) AS [CAHShipQuantity]
						, CONVERT(MONEY, s.[UNIT_COST]) AS [CAHUnitAmount]
						, CONVERT(MONEY, s.[EXT_COST]) AS [CAHExtendedSales]
						, CONVERT(MONEY, s.[CORP_AWP]) AS [CAH_AWP]
						, CONVERT(MONEY, s.[WAC]) AS [CAH_WAC]
						FROM [Staging].[CAH] AS s
						INNER JOIN dbo.EventDimCAH as ed ON CONVERT(VARBINARY(8), s.RowversionID) = ed.RowversionID
															AND ed.DateKey = s.DateKey
						INNER JOIN dbo.DateDim AS dd ON ed.DateKey = dd.DateKey
						INNER JOIN dbo.PharmacyDim AS p ON ed.PMID = p.PMID
						LEFT OUTER JOIN dbo.DrugDim AS rx ON ed.NDC = rx.NDC
						WHERE s.DateKey = @DateKey		
						AND ed.DateKey = @DateKey				
						AND p.StartDateKey <= @DateKey
						AND p.EndDateKey > @RXDimEndDateKey
						--GROUP BY dd.DateKey
						--, rx.DrugKey
						--, ed.EventKey 
						--, s.[ORDER_QTY] 
						--, s.[SHIP_QTY] 
						--, s.[UNIT_COST] 
						--, s.[EXT_COST] 
						--, s.[CORP_AWP] 
						--, s.[WAC]
						) AS CAH ON CAH.PharmacyKey = pd.PharmacyKey
									AND CAH.DateKey = di.DateKey
									AND CAH.DrugKey = dd.DrugKey
			FULL OUTER JOIN(SELECT ISNULL(p.PharmacyKey, 0) AS PharmacyKey
							, dd.DateKey
							, ISNULL(rx.DrugKey, 0) AS DrugKey
							, ed.EventKey AS APIEventKey
							, CONVERT(INT, [Qty]) AS APIInvoiceQuantity
							, CONVERT(MONEY, [UnitAmount]) AS APIUnitAmount
							, CONVERT(MONEY, [LineAmt]) AS APILineItemAmount
							, CONVERT(MONEY, [ExtSales]) AS APIExtendedAmount
							FROM Staging.API AS s
							INNER JOIN dbo.EventDimAPI as ed ON CONVERT(VARBINARY(8), s.RowversionID) = ed.RowversionID
																	AND ed.DateKey = s.DateKey
							INNER JOIN dbo.DateDim AS dd ON ed.DateKey = dd.DateKey
							INNER JOIN dbo.PharmacyDim AS p ON ed.[PMID] = p.PMID
							LEFT OUTER JOIN dbo.DrugDim AS rx ON ed.NDC = rx.NDC
							WHERE s.DateKey = @DateKey
							AND ed.DateKey = @DateKey
							AND p.StartDateKey <= @DateKey
							AND p.EndDateKey > @RXDimEndDateKey
							--GROUP BY dd.DateKey
							--, rx.DrugKey
							--, ed.EventKey 
							--, s.[Qty]
							--, s.[UnitAmount]
							--, s.[LineAmt]
							--, s.[ExtSales]
							) AS API ON API.PharmacyKey = pd.PharmacyKey
									AND API.DateKey = di.DateKey
									AND API.DrugKey = dd.DrugKey										
			) AS dt
			--WHERE NOT EXISTS(SELECT 1
			--				FROM dbo.SalesFact AS sf WITH(NOLOCK)
			--				WHERE dt.PharmacyKey = sf.PharmacyKey
			--				AND dt.DateKey = sf.DateKey
			--				AND dt.DrugKey = sf.DrugKey
			--				AND dt.APIEventKey = sf.APIEventKey
			--				AND dt.CAHEventKey = sf.CAHEventKey
			--					)
		) AS dt
	WHERE dt.RN = 1
	ORDER BY dt.PharmacyKey ASC
	, dt.DateKey ASC
	, dt.DrugKey ASC
	, dt.APIEventKey ASC
	, dt.CAHEventKey ASC

END






GO
