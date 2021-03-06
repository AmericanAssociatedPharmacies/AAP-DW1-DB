USE [ODSIntake]
GO
/****** Object:  StoredProcedure [dbo].[usp_Medispan_ConfigInfo]    Script Date: 12/22/2020 7:30:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[usp_Medispan_ConfigInfo]

AS

SET NOCOUNT ON;

BEGIN

	SELECT dt.SourceLocation
	, ArchiveLocation
	, dt.ExtractDir
	, dt.UnzipLocation
	, dt.DW1CopyFileDestination
	, dt.DeleteStagingDir
	FROM(SELECT FilePath AS SourceLocation
		, CONVERT(VARCHAR(500), FileDirectory + '\Archive\' + [FileName]) AS ArchiveLocation
		, CONVERT(VARCHAR(500), '\\AAPDW1\c$\Medispan\Staging\' + FileName) AS DW1CopyFileDestination
		, CONVERT(VARCHAR(500), '\\AAPDW1\c$\Medispan\Staging\' + FileName) AS UnzipLocation
		, CONVERT(VARCHAR(500), '\\AAPDW1\c$\Medispan\Staging\') AS ExtractDir
		, CONVERT(VARCHAR(500), '\\AAPDW1\c$\Medispan\Staging\MEDFV2') AS DeleteStagingDir
		FROM [dbo].[mtvf_GetFileInfo]('\\fs1.aap.local\Server\IT Department\Medispan\FTPDownload')
		WHERE FileName LIKE '%.zip'
		AND FileName NOT LIKE '%SWDATINSCD%'
		) AS dt

END
GO
