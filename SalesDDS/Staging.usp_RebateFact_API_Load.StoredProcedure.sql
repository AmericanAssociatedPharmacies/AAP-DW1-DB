USE [SalesDDS]
GO
/****** Object:  StoredProcedure [Staging].[usp_RebateFact_API_Load]    Script Date: 12/22/2020 7:55:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [Staging].[usp_RebateFact_API_Load]

	@DateKey INT

AS

SET NOCOUNT ON;

BEGIN


	DECLARE @RXDimEndDateKey INT

	--Add one day and convert back to INT data type
	SET @RXDimEndDateKey = CAST(CONVERT(varchar(20),DATEADD(DAY, 1 ,CONVERT(datetime, convert(varchar(10), @DateKey))),112) as INT);


	SELECT dt.PharmacyKey
	, dt.DateKey
	, dt.DrugKey
	, dt.APIEventKey
	, dt.APIEventDateKey
	, dt.[APIHoldbackPercent]
	, dt.[APIHoldbackAmount]
	, dt.[RebateAfterAPIHoldbackAmount]
	, dt.[AffiliateHoldbackPercent]
	, dt.[AffiliateHoldbackAmount]
	, dt.[FinalRebateAmount]
	FROM(SELECT s.PharmacyKey
		, s.DateKey
		, ISNULL(rx.DrugKey, 0) AS DrugKey
		, ISNULL(ed.EventKey, 0) AS APIEventKey
		, s.DateKey AS APIEventDateKey
		, s.[APIHoldbackPercent]
		, s.[APIHoldbackAmount]
		, s.[RebateAfterAPIHoldbackAmount]
		, s.[AffiliateHoldbackPercent]
		, s.[AffiliateHoldbackAmount]
		, s.[FinalRebateAmount]
		FROM Staging.API AS s
		LEFT OUTER JOIN dbo.EventDimAPI as ed ON s.RowversionID = ed.RowversionID																		
		LEFT OUTER JOIN(SELECT DrugKey
						, NDC
						, StartDateKey
						, EndDateKey
						FROM dbo.DrugDim
						WHERE StartDateKey >= @RXDimEndDateKey
						AND EndDateKey <= @RXDimEndDateKey
						) AS rx ON ed.NDC = rx.NDC
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
