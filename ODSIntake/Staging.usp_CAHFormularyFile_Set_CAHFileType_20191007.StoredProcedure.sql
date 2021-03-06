USE [ODSIntake]
GO
/****** Object:  StoredProcedure [Staging].[usp_CAHFormularyFile_Set_CAHFileType_20191007]    Script Date: 12/22/2020 7:30:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [Staging].[usp_CAHFormularyFile_Set_CAHFileType_20191007]

AS


SET NOCOUNT ON;

BEGIN

	UPDATE [Staging].[CAH_FormularyFile]
	SET [CAHFileType] = ij.CAHFileType
	FROM [Staging].[CAH_FormularyFile] AS x
	INNER JOIN(SELECT RowID
					,  CAHFileType
					, FileProcessed
					FROM(SELECT RowID
							, CASE 
							WHEN FileProcessed LIKE '%AAP_Source_Weekly_Formulary%' THEN 'IsSourceWeekly'
							WHEN FileProcessed LIKE '%AAP_Top_Generics_Weekly_%' THEN 'IsTopGenerics'
							WHEN FileProcessed LIKE  '%AAP_Backup_Source_Weekly%' THEN 'IsBackupSource'
							WHEN FileProcessed LIKE  '%AAP_Ten_Source_Generics_%' THEN 'IsTenSource'
							ELSE NULL
							END AS CAHFileType
							, FileProcessed
							FROM [Staging].[CAH_FormularyFile]
					) AS dt
				) AS ij ON x.RowID = ij.RowID


END 

GO
