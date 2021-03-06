USE [SalesDDS]
GO
/****** Object:  StoredProcedure [dbo].[usp_SalesFact_CAH_UpdateUnmappedPMID]    Script Date: 12/22/2020 7:55:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_SalesFact_CAH_UpdateUnmappedPMID]

AS

SET NOCOUNT ON;

BEGIN

	UPDATE x
	SET PharmacyKey = dt.CorrectedPharmacyKey
	FROM dbo.SalesFact_CAH AS x
	INNER JOIN(SELECT s.DateKey, s.CAHEventKey, s.CAHEventDateKey, pd.PharmacyKey AS CorrectedPharmacyKey
				FROM dbo.SalesFact_CAH AS s
				INNER JOIN dbo.EventDimCAH AS c ON s.[CAHEventKey] = c.EventKey
													AND s.CAHEventDateKey = c.DateKey
				INNER JOIN dbo.PharmacyDim AS pd ON c.PMID = pd.PMID
				WHERE s.PharmacyKey = 0
				AND c.PMID > 0
				) AS dt ON x.CAHEventKey = dt.CAHEventKey
							AND x.CAHEventDateKey = dt.CAHEventDateKey
							AND x.DateKey = dt.DateKey

END
GO
