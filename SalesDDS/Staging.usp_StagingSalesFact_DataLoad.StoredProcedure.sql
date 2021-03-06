USE [SalesDDS]
GO
/****** Object:  StoredProcedure [Staging].[usp_StagingSalesFact_DataLoad]    Script Date: 12/22/2020 7:55:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [Staging].[usp_StagingSalesFact_DataLoad]

	@DateKey INT


AS

SET NOCOUNT ON;

BEGIN

	DECLARE @RXDimEndDateKey INT

	SET @RXDimEndDateKey = CAST(CONVERT(varchar(20),DATEADD(DAY, 1 ,CONVERT(datetime, convert(varchar(10), @DateKey))),112) as INT);


	--INSERT INTO [Staging].[SalesFact](PharmacyKey, DateKey, DrugKey, APIEventKey, CAHEventKey, APIInvoiceQuantity, APIUnitAmount, APILineItemAmount, APIExtendedAmount, CAHInvoiceQuantity, CAHUnitAmount, CAHExtendedSales, CAH_AWP, CAH_WAC)
	SELECT dt.PharmacyKey
	, dt.DateKey
	, dt.DrugKey
	, dt.APIEventKey
	, dt.CAHEventKey
	, dt.APIInvoiceQuantity
	, dt.APIUnitAmount
	, dt.APILineItemAmount
	, dt.APIExtendedAmount
	, dt.[CAHInvoiceQuantity] 
	, dt.[CAHUnitAmount]
	, dt.[CAHExtendedSales]
	, dt.[CAH_AWP]
	, dt.[CAH_WAC]
	FROM(SELECT ISNULL(CAH.PharmacyKey, API.PharmacyKey) AS PharmacyKey
		, ISNULL(CAH.DateKey, API.DateKey) AS DateKey
		, ISNULL(CAH.DrugKey, API.DrugKey) AS DrugKey
		, ISNULL(API.APIEventKey, 0) AS APIEventKey
		, ISNULL(CAH.CAHEventKey, 0) AS CAHEventKey
		, API.APIInvoiceQuantity
		, API.APIUnitAmount
		, API.APILineItemAmount
		, API.APIExtendedAmount
		, cah.[CAHInvoiceQuantity] 
		, cah.[CAHUnitAmount]
		, cah.[CAHExtendedSales]
		, cah.[CAH_AWP]
		, cah.[CAH_WAC]
	FROM(SELECT ISNULL(p.PharmacyKey, 0) AS PharmacyKey
			, s.DateKey
			, ISNULL(rx.DrugKey, 0) AS DrugKey
			, ed.EventKey AS CAHEventKey      
			, CONVERT(INT, s.[ORDER_QTY]) AS CAHInvoiceQuantity
			, CONVERT(INT, s.[SHIP_QTY]) AS [CAHShipQuantity]
			, CONVERT(MONEY, s.[UNIT_COST]) AS [CAHUnitAmount]
			, CONVERT(MONEY, s.[EXT_COST]) AS [CAHExtendedSales]
			, CONVERT(MONEY, s.[CORP_AWP]) AS [CAH_AWP]
			, CONVERT(MONEY, s.[WAC]) AS [CAH_WAC]
			FROM [Staging].[CAH] AS s
			INNER JOIN dbo.EventDimCAH as ed ON CONVERT(VARBINARY(8), s.RowversionID) = ed.RowversionID
																		AND ed.DateKey = s.DateKey
			LEFT OUTER JOIN dbo.PharmacyDim AS p ON ISNULL(ed.PMID, 0) = p.PMID
			LEFT OUTER JOIN dbo.DrugDim AS rx ON ed.NDC = rx.NDC
			WHERE s.DateKey = @DateKey        
			AND ed.DateKey = @DateKey                       
			AND p.StartDateKey <= @DateKey
			AND p.EndDateKey > @RXDimEndDateKey
			) AS CAH
	FULL OUTER JOIN(SELECT ISNULL(ISNULL(p1.PharmacyKey, p2.PharmacyKey), 0) AS PharmacyKey
									  , s.DateKey
									  , ISNULL(rx.DrugKey, 0) AS DrugKey
									  , ed.EventKey AS APIEventKey
									  , CONVERT(INT, [Qty]) AS APIInvoiceQuantity
									  , CONVERT(MONEY, [UnitAmount]) AS APIUnitAmount
									  , CONVERT(MONEY, [LineAmt]) AS APILineItemAmount
									  , CONVERT(MONEY, [ExtSales]) AS APIExtendedAmount
									  FROM Staging.API AS s
									  INNER JOIN dbo.EventDimAPI as ed ON CONVERT(VARBINARY(8), s.RowversionID) = ed.RowversionID
																																								  AND ed.DateKey = s.DateKey
									  LEFT OUTER JOIN(SELECT PharmacyKey
																		 , PMID
																		 FROM dbo.PharmacyDim
																		 WHERE StartDateKey <= @DateKey
																		 AND EndDateKey > @RXDimEndDateKey
																		 ) AS p1 ON ed.[PMID] = p1.PMID
									  LEFT OUTER JOIN(SELECT PMID
																		 , MAX(PharmacyKey) AS PharmacyKey
																		 FROM dbo.PharmacyDim
																		 GROUP BY PMID
																  ) AS p2 ON ed.PMID = p2.PMID
									  LEFT OUTER JOIN dbo.DrugDim AS rx ON ed.NDC = rx.NDC
									  WHERE s.DateKey = @DateKey
									  AND ed.DateKey = @DateKey
					   ) AS API ON CAH.DateKey = API.DateKey
						AND CAH.PharmacyKey = API.PharmacyKey
						AND CAH.DrugKey = API.DrugKey
	) AS dt
	ORDER BY dt.PharmacyKey ASC
	, dt.DateKey ASC
	, dt.DrugKey ASC
	, dt.APIEventKey ASC
	, dt.CAHEventKey ASC

END
GO
