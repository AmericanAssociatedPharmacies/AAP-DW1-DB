USE [ODSIntake]
GO
/****** Object:  StoredProcedure [dbo].[usp_CAH_FormularyFile_CopyToArchive]    Script Date: 12/22/2020 7:30:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO









CREATE PROCEDURE [dbo].[usp_CAH_FormularyFile_CopyToArchive]

	@FileDir VARCHAR(1000) = '\\fs1.aap.local\Server\IT Department\Cardinal\FormularyFiles'

AS

SET NOCOUNT ON;

BEGIN


SELECT dt.Source
     , dt.Archive
FROM(SELECT CONVERT(VARCHAR(1000), FilePath) AS Source
		  , CONVERT(VARCHAR(1000), '\\fs1.aap.local\Server\IT Department\Cardinal\FormularyFiles\Archive\' + REPLACE(FileName, '.xlsx', '_' + CONVERT(VARCHAR, GETDATE(), 112) + '.xlsx')) AS Archive
	 FROM [dbo].[mtvf_GetFileInfo] (@FileDir) 
	) AS dt
				
END


GO
