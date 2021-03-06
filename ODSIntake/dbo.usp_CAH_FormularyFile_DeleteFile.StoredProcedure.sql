USE [ODSIntake]
GO
/****** Object:  StoredProcedure [dbo].[usp_CAH_FormularyFile_DeleteFile]    Script Date: 12/22/2020 7:30:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[usp_CAH_FormularyFile_DeleteFile]

	@FileDir VARCHAR(1000) = '\\fs1.aap.local\Server\IT Department\Cardinal\FormularyFiles',
	@FileDir1 VARCHAR(1000) = 'C:\Cardinal\FormularyFiles\'

AS

SET NOCOUNT ON;

BEGIN

	   SELECT dt.FName
	   FROM(SELECT FilePath AS FName
	   		FROM [dbo].[mtvf_GetFileInfo] (@FileDir) 
	   	   ) AS dt
	   UNION
	   SELECT dt.FName
	   FROM(SELECT FilePath AS FName
	   		FROM [dbo].[mtvf_GetFileInfo] (@FileDir1) 
	   	   ) AS dt			
END


GO
