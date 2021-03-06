USE [SalesDDS]
GO
/****** Object:  StoredProcedure [Staging].[usp_SalesFact_CAH_Load_2]    Script Date: 12/22/2020 7:55:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [Staging].[usp_SalesFact_CAH_Load_2]

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
	, dt.CAHEventKey	
	, dt.CAHEventDateKey
	, dt.CAHInvoiceQuantity
	, dt.[CAHUnitAmount]
	, dt.[CAHExtendedSales]
	, dt.[CAH_AWP]
	, dt.[CAH_WAC]
	FROM(SELECT ISNULL(ISNULL(p1.PharmacyKey, p2.PharmacyKey), 0) AS PharmacyKey
	, dd.DateKey
	, ISNULL(rx.DrugKey, 0) AS DrugKey
	, ed.EventKey AS CAHEventKey	
	, ed.DateKey AS CAHEventDateKey
	--, CONVERT(INT, s.[ORDER_QTY]) AS [CAHOrderQuantity]
	, CONVERT(INT, s.[SHIP_QTY])  AS CAHInvoiceQuantity
	, CONVERT(MONEY, s.[UNIT_COST]) AS [CAHUnitAmount]
	, CONVERT(MONEY, s.[EXT_COST]) AS [CAHExtendedSales]
	, CONVERT(MONEY, s.[CORP_AWP]) AS [CAH_AWP]
	, CONVERT(MONEY, s.[WAC]) AS [CAH_WAC]
	FROM [Staging].[CAH] AS s
	INNER JOIN dbo.EventDimCAH as ed ON CONVERT(VARBINARY(8), s.RowversionID) = ed.RowversionID
										AND ed.DateKey = s.DateKey
	INNER JOIN dbo.DateDim AS dd ON ed.DateKey = dd.DateKey
	LEFT OUTER JOIN(SELECT PMID
						, PharmacyKey
						FROM dbo.PharmacyDim 
						WHERE StartDateKey <= @DateKey
						AND EndDateKey > @RXDimEndDateKey
					) AS p1 ON ed.PMID = p1.PMID
	LEFT OUTER JOIN(SELECT PMID
						, MAX(PharmacyKey) AS PharmacyKey
						FROM dbo.PharmacyDim
						GROUP BY PMID
						) AS p2 ON ed.PMID = p2.PMID
	LEFT OUTER JOIN dbo.DrugDim AS rx ON ed.NDC = rx.NDC
	WHERE s.DateKey = @DateKey		
	AND ed.DateKey = @DateKey
	) AS dt
	ORDER BY dt.PharmacyKey ASC
	, dt.DateKey ASC
	, dt.DrugKey ASC
	, dt.CAHEventKey ASC
	, dt.CAHEventDateKey ASC				
	


END



GO
