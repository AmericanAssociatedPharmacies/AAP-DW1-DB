USE [SalesDDS]
GO
/****** Object:  StoredProcedure [Staging].[usp_SalesFact_API_Load_Test]    Script Date: 12/22/2020 7:55:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [Staging].[usp_SalesFact_API_Load_Test]

	@DateKey INT

AS

SET NOCOUNT ON;

BEGIN


	DECLARE @RXDimEndDateKey INT

	SET @RXDimEndDateKey = CAST(CONVERT(varchar(20),DATEADD(DAY, 1 ,CONVERT(datetime, convert(varchar(10), @DateKey))),112) as INT);


	SELECT dt.PharmacyKey
	, dt.DateKey
	, dt.DrugKey
	, dt.APIEventKey
	, dt.APIEventDateKey
	, dt.APIInvoiceQuantity
	, dt.APIUnitAmount
	, dt.APILineItemAmount
	, dt.APIExtendedAmount
	FROM(SELECT 
		--ISNULL(ISNULL(p1.PharmacyKey, p2.PharmacyKey), 0) AS PharmacyKey
		p1.PharmacyKey
		, s.DateKey
		, ISNULL(rx.DrugKey, 0) AS DrugKey
		, ed.EventKey AS APIEventKey
		, s.DateKey AS APIEventDateKey
		, CONVERT(INT, [Qty]) AS APIInvoiceQuantity
		, CONVERT(MONEY, [UnitAmount]) AS APIUnitAmount
		, CONVERT(MONEY, [LineAmt]) AS APILineItemAmount
		, CONVERT(MONEY, [ExtSales]) AS APIExtendedAmount
		FROM Staging.API AS s
		INNER JOIN dbo.EventDimAPI as ed ON CONVERT(VARBINARY(8), s.RowversionID) = ed.RowversionID																		
		LEFT OUTER JOIN(SELECT PharmacyKey
						, PMID
						FROM dbo.PharmacyDim
						WHERE StartDateKey >= @DateKey
						AND EndDateKey < @RXDimEndDateKey
						) AS p1 ON ed.[PMID] = p1.PMID
		--LEFT OUTER JOIN(SELECT PMID
		--				, MAX(PharmacyKey) AS PharmacyKey
		--				FROM dbo.PharmacyDim
		--				WHERE StartDateKey >= @RXDimEndDateKey
		--				AND EndDateKey <= @RXDimEndDateKey
		--				GROUP BY PMID
		--				) AS p2 ON ed.PMID = p2.PMID
		LEFT OUTER JOIN dbo.DrugDim AS rx ON ed.NDC = rx.NDC
		WHERE s.DateKey = @DateKey
		AND ed.DateKey = @DateKey
		) AS dt
		ORDER BY dt.PharmacyKey ASC
		, dt.DateKey ASC
		, dt.DrugKey ASC
		, dt.APIEventKey ASC
		, dt.APIEventDateKey ASC



END


GO
