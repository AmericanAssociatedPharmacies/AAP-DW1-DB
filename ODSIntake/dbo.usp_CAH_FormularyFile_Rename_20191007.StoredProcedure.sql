USE [ODSIntake]
GO
/****** Object:  StoredProcedure [dbo].[usp_CAH_FormularyFile_Rename_20191007]    Script Date: 12/22/2020 7:30:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[usp_CAH_FormularyFile_Rename_20191007]

	@FileDir VARCHAR(1000) = '\\fs1.aap.local\Server\IT Department\Cardinal\FormularyFiles'

AS

SET NOCOUNT ON;

BEGIN

--SET  = '\\fs1.aap.local\Server\IT Department\Cardinal\ForumlaryFiles'

SELECT dt.Source
, dt.Destination
--, dt.Archive
FROM(SELECT CONVERT(VARCHAR(1000), dt.Source) AS Source
		, CONVERT(VARCHAR(1000), dt.FileDirectory + '\'+ REPLACE(REPLACE(dt.FileName, RIGHT(dt.FileName, 11) , ca.C1), ' ', '')) AS Destination 
		--, CONVERT(VARCHAR(1000), dt.FileDirectory + '\Archive\'+ REPLACE(REPLACE(dt.FileName, RIGHT(dt.FileName, 11) , ca.C1), ' ', '')) AS Archive 
		FROM(SELECT FilePath AS Source
				, FileDirectory
				, FileName
				, REPLACE(RIGHT(FileName, 11), '.xlsx', '') AS C1
				FROM [dbo].[mtvf_GetFileInfo] (@FileDir) 
				) AS dt
				CROSS APPLY(SELECT  CONVERT(VARCHAR(250), CONVERT(VARCHAR, DATEPART(yy, GETDATE())) + SUBSTRING(dt.C1, 1, 2) + SUBSTRING(dt.C1, 3, 2) + '.xlsx') AS C1
						) AS ca
			 ) AS dt
END



GO
