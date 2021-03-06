USE [SalesDDS]
GO
/****** Object:  StoredProcedure [dbo].[usp_CAH_MapPMID]    Script Date: 12/22/2020 7:55:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_CAH_MapPMID]

	@DateKey INT

AS

SET NOCOUNT ON;

BEGIN

	--UPDATE x
	--SET PMID = c.PMID
	--FROM dbo.EventDimCAH AS x
	--INNER JOIN dbo.CAHAccount AS c ON x.CAHAccountNo = c.CorrectedCAHAccountNo
	--					AND x.DateKey BETWEEN c.AAPEffectiveDateKey AND c.AAPQuitDateKey
	--WHERE x.DateKey = @DateKey


	UPDATE c
	SET PharmacyKey = pd.PharmacyKey
	FROM [dbo].[SalesFact_CAH] AS c 
	INNER JOIN dbo.EventDimCAH AS e ON c.[CAHEventKey] = e.EventKey
									AND c.[CAHEventDateKey] = e.[DateKey]
	INNER JOIN dbo.PharmacyDim AS pd ON e.PMID = pd.PMID
										--AND c.DateKey BETWEEN pd.AAPEffectiveDateKey AND pd.AAPQuitDateKey
	WHERE c.DateKey = @DateKey

END
GO
