USE [ODSIntake]
GO
/****** Object:  StoredProcedure [dbo].[usp_APICatalog_Config]    Script Date: 12/22/2020 7:30:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[usp_APICatalog_Config]

	@FileDir VARCHAR(1000)

AS

SET NOCOUNT ON;

BEGIN

	SELECT dt.SourcePath
	, dt.ArchivePath
	, dt.DateKey
	FROM(SELECT CONVERT(VARCHAR(1000), FilePath) AS SourcePath
	, CONVERT(VARCHAR(1000), FileDirectory + '\Archive\' + FileName) AS ArchivePath
	, CONVERT(INT, RIGHT(LEFT(FileName, CHARINDEX('_', FileName) - 1), 8)) AS DateKey
	FROM dbo.mtvf_GetFileInfo(@FileDir)
	WHERE FileName LIKE '%.txt'
	) AS dt
	

END


GO
