USE [SalesDDS]
GO
/****** Object:  StoredProcedure [dbo].[usp_API_MapPMID]    Script Date: 12/22/2020 7:55:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[usp_API_MapPMID]

	@Datekey INT

AS

SET NOCOUNT ON;


BEGIN

	--UPDATE a
	--SET PMID = ISNULL(pd.PMID)
	--FROM dbo.EventDimAPI AS a	
	--LEFT OUTER JOIN dbo.PharmacyDim AS pd ON a.[AccountNumber] = APINumber
	--												AND a.DateKey BETWEEN pd.APIEffectiveDateKey AND pd.APIQuitDateKey											
	--WHERE a.Datekey = @DateKey

	--DELETE x
	--FROM [dbo].[SalesFact_API] AS x
	--INNER JOIN(SELECT ROW_NUMBER() OVER(PARTITION BY [DateKey], [DrugKey], [APIEventKey], [APIEventDateKey] ORDER BY PharmacyKey ASC) AS C1
	--			, [PharmacyKey]
	--			, [DateKey]
	--			, DrugKey
	--			, [APIEventKey]
	--			, [APIEventDateKey]
	--			FROM [dbo].[SalesFact_API]
	--			WHERE DateKey = @Datekey
	--			) AS dt ON x.[PharmacyKey] = dt.PharmacyKey
	--					AND x.DateKey = dt.DateKey
	--					AND x.DrugKey = dt.DrugKey
	--					AND x.APIEventKey = dt.APIEventKey
	--					AND x.APIEventDateKey = dt.APIEventDateKey
	--WHERE dt.C1 > 1

	UPDATE x
	SET AccountNumber = REPLACE(REPLACE(REPLACE(LTRIM(RTRIM(x.AccountNumber)), ' ', ''), '  ', ''), '   ', '')
	FROM [dbo].[EventDimAPI] AS x
	WHERE x.EventKey = @DateKey

	UPDATE s
	SET PharmacyKey = pd.PharmacyKey
	FROM [dbo].[SalesFact_API] AS s
	INNER JOIN [dbo].[EventDimAPI] AS e ON s.APIEventKey = e.EventKey
									AND s.[APIEventDateKey] = e.DateKey
	INNER JOIN dbo.PharmacyDim AS pd ON pd.APINumber = e.[AccountNumber]
										AND s.[DateKey] BETWEEN pd.APIEffectiveDateKey AND pd.APIQuitDateKey																						
	WHERE s.Datekey = @DateKey


	UPDATE r
	SET PharmacyKey = pd.PharmacyKey
	FROM [dbo].[RebateFact_API] AS r
	INNER JOIN [dbo].[EventDimAPI] AS e ON r.APIEventKey = e.EventKey
									AND r.[APIEventDateKey] = e.DateKey
	INNER JOIN dbo.PharmacyDim AS pd ON pd.APINumber = e.[AccountNumber]
										AND r.[DateKey] BETWEEN pd.APIEffectiveDateKey AND pd.APIQuitDateKey																						
	WHERE r.Datekey = @DateKey
	


END

GO
