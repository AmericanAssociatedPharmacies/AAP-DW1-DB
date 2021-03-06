USE [ODSIntake]
GO
/****** Object:  StoredProcedure [Staging].[usp_CAHFormularyFile_Set_CAHFileType]    Script Date: 12/22/2020 7:30:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [Staging].[usp_CAHFormularyFile_Set_CAHFileType]

AS


SET NOCOUNT ON;

BEGIN

	UPDATE [Staging].[CAH_FormularyFile]
	SET [CAHFileType] = ij.CAHFileType
	FROM [Staging].[CAH_FormularyFile] AS x
	INNER JOIN(SELECT RowID
					,  CAHFileType
					, [Formulary Name]
					FROM(SELECT RowID
							, CASE 
							WHEN [Formulary Name] LIKE '%AAP SOURCE%' THEN 'IsSourceWeekly'
							WHEN [Formulary Name] LIKE '%AAP TOP GENERICS SOURCE%' THEN 'IsTopGenerics'
							WHEN [Formulary Name] LIKE '%BACKUP%' THEN 'IsBackupSource'
							WHEN [Formulary Name] LIKE '%PSB EXCLUDED%' THEN 'IsTenSource'
							ELSE NULL
							END AS CAHFileType
							, [Formulary Name]
							FROM [Staging].[CAH_FormularyFile]
					) AS dt
				) AS ij ON x.RowID = ij.RowID


END 

GO
