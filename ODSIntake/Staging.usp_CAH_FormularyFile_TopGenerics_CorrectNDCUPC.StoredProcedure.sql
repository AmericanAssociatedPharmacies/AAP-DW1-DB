USE [ODSIntake]
GO
/****** Object:  StoredProcedure [Staging].[usp_CAH_FormularyFile_TopGenerics_CorrectNDCUPC]    Script Date: 12/22/2020 7:30:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [Staging].[usp_CAH_FormularyFile_TopGenerics_CorrectNDCUPC]

AS

SET NOCOUNT ON;

BEGIN

	/*This will correct any NDC\UPC values that are missing any leading zero's. Per Bob on 02/12/2018, CAH is not contractually obligated to fix
	this data.
	*/
	UPDATE [Staging].[CAH_FormularyFile_TopGenerics]
	SET [CorrectedNDCUPC] = dt.[CorrectedNDCUPC]
	FROM [Staging].[CAH_FormularyFile_TopGenerics] AS x
	INNER JOIN(SELECT ca.RowID
				, ca.[CorrectedNDCUPC]
				FROM(SELECT [RowID]
						, [NDC/UPC]
						, LEN([NDC/UPC]) AS NDCLen
					   FROM [Staging].[CAH_FormularyFile_TopGenerics] AS c
					   ) AS dt
				CROSS APPLY(SELECT dt.RowID
							, CASE
							WHEN dt.NDCLen < 11 THEN REVERSE(LEFT(REVERSE(STUFF(dt.[NDC/UPC], 1, 0, REPLICATE('0', 11 - LEN(NDCLen)))), 11))
							ELSE dt.[NDC/UPC]
							END AS [CorrectedNDCUPC]
							FROM [Staging].[CAH_FormularyFile_TopGenerics] AS c
							WHERE dt.RowID = c.RowID
									 ) AS ca
				WHERE ca.RowID = dt.RowID
				) AS dt ON x.RowID = dt.RowID


END
GO
