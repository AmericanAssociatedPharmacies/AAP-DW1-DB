USE [SalesDDS]
GO
/****** Object:  StoredProcedure [Staging].[usp_SalesFact_API_Load]    Script Date: 12/22/2020 7:55:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO












CREATE PROCEDURE [Staging].[usp_SalesFact_API_Load]

	@DateKey INT

AS

SET NOCOUNT ON;

BEGIN


	DECLARE @EndDateKey INT

	SET @EndDateKey = CAST(CONVERT(varchar(20),DATEADD(DAY, 1 ,CONVERT(datetime, convert(varchar(10), @DateKey))),112) as INT);


	SELECT dt.PharmacyKey
	, dt.DateKey
	, dt.DrugKey
	, dt.APIEventKey
	, dt.APIEventDateKey
	, dt.APIInvoiceQuantity
	, dt.APIUnitAmount
	, dt.APILineItemAmount
	, dt.APIExtendedAmount
	, dt.GPIKey
	FROM(SELECT s.PharmacyKey
			, s.DateKey
			, ISNULL(rx.DrugKey, 0) AS DrugKey
			, ed.EventKey AS APIEventKey
			, s.DateKey AS APIEventDateKey
			, CONVERT(INT, [Qty]) AS APIInvoiceQuantity
			, CONVERT(MONEY, [UnitAmount]) AS APIUnitAmount
			, CONVERT(MONEY, [LineAmt]) AS APILineItemAmount
			, CONVERT(MONEY, [ExtSales]) AS APIExtendedAmount
			, rx.GPIKey
			FROM Staging.API AS s
			INNER JOIN dbo.EventDimAPI as ed ON CONVERT(VARBINARY(8), s.RowversionID) = ed.RowversionID	
			LEFT OUTER JOIN dbo.DrugDim AS rx ON s.NDC = rx.NDC
												AND s.DateKey BETWEEN rx.StartDateKey AND rx.EndDateKey																	
			--LEFT OUTER JOIN(SELECT DrugKey
			--				, NDC
			--				FROM dbo.DrugDim
			--				WHERE StartDateKey <= @DateKey
			--				AND EndDateKey >= @EndDateKey
			--				) AS rx ON s.NDC = rx.NDC
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
