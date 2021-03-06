USE [SalesDDS]
GO
/****** Object:  StoredProcedure [dbo].[usp_RebateFact_API_BulkInsert]    Script Date: 12/22/2020 7:55:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_RebateFact_API_BulkInsert]

	@DateKey INT

AS

SET NOCOUNT ON;

BEGIN

	SELECT a.PharmacyKey
	, a.DateKey
	, a.DrugKey
	, a.[APIHoldbackPercent]
	, a.[APIHoldbackAmount]
	, a.[RebateAfterAPIHoldbackAmount]
	, a.[AffiliateHoldbackPercent]
	, a.[AffiliateHoldbackAmount]
	, a.[FinalRebateAmount]
	FROM Staging.RebateFact_API AS a
	WHERE a.DateKey = @DateKey
	AND NOT EXISTS(SELECT 1
						FROM dbo.RebateFact_API AS s WITH(NOLOCK)
						WHERE a.[PharmacyKey] = s.[PharmacyKey]
						AND a.[DateKey] = s.DateKey
						AND a.[DrugKey] = s.DrugKey
						AND a.[APIEventKey] = s.[APIEventKey]
						AND a.[APIEventDateKey] = s.[APIEventDateKey]
						)

END
GO
