USE [ODSIntake]
GO
/****** Object:  StoredProcedure [dbo].[usp_NADAC_CopyToArchiveFolder]    Script Date: 12/22/2020 7:30:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_NADAC_CopyToArchiveFolder]

AS

SET NOCOUNT ON;

BEGIN

	DECLARE @FileDir VARCHAR(500)

	SET @FileDir = '\\fs1.aap.local\Server\IT Department\NADAC\'


	SELECT dt.SourceLocation
	, dt.DestinationLocation
	FROM(SELECT CONVERT(VARCHAR(1000), FilePath) AS SourceLocation
		, CONVERT(VARCHAR(1000), FileDirectory + '\Archive\' + FileName) AS DestinationLocation
		FROM [dbo].[mtvf_GetFileInfo](@FileDir)
		) AS dt

END
GO
