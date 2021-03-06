USE [ODSIntake]
GO
/****** Object:  StoredProcedure [dbo].[usp_CAH_FormularyFile_CopyToDW1]    Script Date: 12/22/2020 7:30:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[usp_CAH_FormularyFile_CopyToDW1]

	@FileDir VARCHAR(1000) = '\\fs1.aap.local\Server\IT Department\Cardinal\FormularyFiles'

AS

SET NOCOUNT ON;

BEGIN

SELECT dt.Source
	 , dt.Destination
FROM(SELECT CONVERT(VARCHAR(1000), '\\fs1.aap.local\Server\IT Department\Cardinal\FormularyFiles\' + FileName) AS Source
		  , CONVERT(VARCHAR(1000), 'C:\Cardinal\FormularyFiles\') AS Destination 
	  FROM [dbo].[mtvf_GetFileInfo] (@FileDir)
	 ) AS dt
END



GO
