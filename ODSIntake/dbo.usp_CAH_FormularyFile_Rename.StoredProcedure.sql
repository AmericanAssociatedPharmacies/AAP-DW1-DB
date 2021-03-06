USE [ODSIntake]
GO
/****** Object:  StoredProcedure [dbo].[usp_CAH_FormularyFile_Rename]    Script Date: 12/22/2020 7:30:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE PROCEDURE [dbo].[usp_CAH_FormularyFile_Rename]

	@FileDir VARCHAR(1000) = '\\fs1.aap.local\Server\IT Department\Cardinal\FormularyFiles'

AS

SET NOCOUNT ON;

BEGIN

SELECT dt.Source
	 , LEFT(dt.Destination, LEN(dt.Destination)) AS Destination --+ '_' + CONVERT(VARCHAR, GETDATE(), 112) + '.xlsx' AS Destination
FROM(SELECT CONVERT(VARCHAR(1000), dt.Source) AS Source
		  , CONVERT(VARCHAR(1000), dt.Destination) AS Destination 
	  FROM(SELECT FilePath AS Source
				, REPLACE(REPLACE(FilePath, ' ', ''), '\IT', '\IT ') AS Destination
			FROM [dbo].[mtvf_GetFileInfo] (@FileDir) 
			) AS dt
	 ) AS dt
END



GO
