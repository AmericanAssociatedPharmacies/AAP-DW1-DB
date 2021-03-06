USE [SalesDDS]
GO
/****** Object:  StoredProcedure [Staging].[usp_StagingAPI_Update]    Script Date: 12/22/2020 7:55:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [Staging].[usp_StagingAPI_Update]

AS

SET NOCOUNT ON;

BEGIN


	UPDATE x
	SET PMID = ISNULL(pd.PMID, 0)
	, PharmacyKey = ISNULL(pd.PharmacyKey,0)
	FROM [Staging].[API] AS x
	LEFT OUTER JOIN dbo.PharmacyDim AS pd ON x.[WHAccountID] = APINumber
												AND x.DateKey BETWEEN pd.APIEffectiveDateKey AND pd.APIQuitDateKey

	UPDATE x
	SET WHAccountID = REPLACE(REPLACE(REPLACE(LTRIM(RTRIM(WHAccountID)), ' ', ''), '  ', ''), '   ', '')
	FROM [Staging].[API] AS x


	UPDATE x
	SET IsCredit = CASE
					WHEN ItemDescription LIKE '%Credit%' THEN 1
					WHEN TransTypeCode = 'R' THEN 1
					ELSE 0
					END
	FROM [Staging].[API] AS x



END





GO
