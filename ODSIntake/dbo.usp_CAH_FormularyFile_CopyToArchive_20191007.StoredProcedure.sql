USE [ODSIntake]
GO
/****** Object:  StoredProcedure [dbo].[usp_CAH_FormularyFile_CopyToArchive_20191007]    Script Date: 12/22/2020 7:30:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_CAH_FormularyFile_CopyToArchive_20191007]

	@FileDir VARCHAR(1000) = '\\fs1.aap.local\Server\IT Department\Cardinal\FormularyFiles'

AS

SET NOCOUNT ON;

BEGIN

--SET  = '\\fs1.aap.local\Server\IT Department\Cardinal\ForumlaryFiles'

SELECT dt.Source
, dt.Archive
FROM(SELECT CONVERT(VARCHAR(1000), FilePath) AS Source
		, CONVERT(VARCHAR(1000), FileDirectory + '\Archive\' + FileName) AS Archive
		FROM [dbo].[mtvf_GetFileInfo] (@FileDir) 
	) AS dt
				
END


GO
