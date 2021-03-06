USE [SalesDDS]
GO
/****** Object:  StoredProcedure [Staging].[usp_StagingCAH_UpdateFormularyFile]    Script Date: 12/22/2020 7:55:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [Staging].[usp_StagingCAH_UpdateFormularyFile]

AS

SET NOCOUNT ON;

BEGIN

	UPDATE x
	SET IsBackupSource = ISNULL(f1.[IsBackupSource], 0)
	, IsTenSource = ISNULL(f1.[IsTenSource], 0)
	, [IsSourceWeekly] = ISNULL(f1.[IsSourceWeekly], 0)
	, [IsTopGenerics] = ISNULL(f1.[IsTopGenerics], 0)
	FROM Staging.[CAH] AS x
	FULL OUTER JOIN (SELECT [CorrectedNDCUPC]
						, DateKey
						, [CIN]
						, [IsBackupSource]
						, [IsTenSource]
						, [IsSourceWeekly]
						, [IsTopGenerics]
						FROM CAHODS.dbo.CAH_FormularyFile AS c
						CROSS APPLY(SELECT MAX(DateKey) AS MaxDateKey
										FROM CAHODS.dbo.CAH_FormularyFile
									) AS ca
						WHERE c.DateKey = ca.MaxDateKey
						) AS f1 ON x.NDC = f1.CorrectedNDCUPC
									AND x.ITEM_NO = f1.CIN

END
GO
