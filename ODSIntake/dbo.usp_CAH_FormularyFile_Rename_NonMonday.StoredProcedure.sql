USE [ODSIntake]
GO
/****** Object:  StoredProcedure [dbo].[usp_CAH_FormularyFile_Rename_NonMonday]    Script Date: 12/22/2020 7:30:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[usp_CAH_FormularyFile_Rename_NonMonday]

AS


SET NOCOUNT ON;

BEGIN

	DECLARE @FileDir VARCHAR(1000)
	, @CurrentDate VARCHAR(8)
 
	SET @FileDir = '\\fs1.aap.local\Server\IT Department\Cardinal\ForumlaryFiles\Archive'

	SET @CurrentDate = CONVERT(VARCHAR(20),GETDATE(),112)

	SELECT dt.Source
	, dt.Destination
	FROM(SELECT CONVERT(VARCHAR(1000), FilePath) AS Source
		, CONVERT(VARCHAR(1000), REPLACE(FilePath, '\Archive', '')) AS Destination 
		FROM dbo.mtvf_GetFileInfo(@FileDir)
		WHERE REPLACE(RIGHT(FileName, 13), '.xlsx' , '') = @CurrentDate
		) AS dt

END





GO
