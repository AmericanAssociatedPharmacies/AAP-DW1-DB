USE [ODSIntake]
GO
/****** Object:  StoredProcedure [dbo].[usp_Medispan_SFTP_File_ConfigInfo]    Script Date: 12/22/2020 7:30:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO











CREATE PROCEDURE [dbo].[usp_Medispan_SFTP_File_ConfigInfo]

	@FileDir VARCHAR(1000) = NULL
	, @Load INT

AS


SET NOCOUNT ON;

BEGIN

	--SET @FileDir = ISNULL(@FileDir, '\\fs1.aap.local\Server\IT Department\Medispan\FTPDownload')
	--SET @FileDir = ISNULL(@FileDir, '\\fs1\g\IT Department\Medispan\FTPDownload') --New location per Jason White --No longer works
	 SET @FileDir = ISNULL(@FileDir, '\\fs1\Server\IT Department\Medispan\FTPDownload')
	 --\\fs1\Server\IT Department\Medispan\FTPDownload\Data

	DECLARE @DataDir VARCHAR(1000)
	, @ImagesDir VARCHAR(1000)

	SET @DataDir = '\\fs1\Server\IT Department\Medispan\FTPDownload\Data'
	SET @ImagesDir = '\\fs1\Server\IT Department\Medispan\FTPDownload\Images'


	--Data file
	SELECT dt.SourceLocation
	, ArchiveLocation
	, dt.ExtractDir
	, dt.UnzipLocation
	, dt.DW1CopyFileDestination
	, dt.DeleteStagingDir
	FROM(SELECT FilePath AS SourceLocation
		, CONVERT(VARCHAR(500), '\\fs1\Server\IT Department\Medispan\FTPDownload\Archive\Data\' + [FileName]) AS ArchiveLocation
		, CONVERT(VARCHAR(500), '\\AAPDW1\c$\Medispan\Staging\Data\' + FileName) AS DW1CopyFileDestination
		, CONVERT(VARCHAR(500), '\\AAPDW1\c$\Medispan\Staging\Data\' + FileName) AS UnzipLocation
		, CONVERT(VARCHAR(500), '\\AAPDW1\c$\Medispan\Staging\Data\') AS ExtractDir
		, CONVERT(VARCHAR(500), '\\AAPDW1\c$\Medispan\Staging\Data\MEDFV2') AS DeleteStagingDir
		, @Load AS DataLoad
		FROM [dbo].[mtvf_GetFileInfo](@DataDir)
		WHERE FileName LIKE '%delimt_pricing%'
		AND FileName LIKE '%.zip'
		AND FileName NOT LIKE '%SWDATINSCD%'
		AND FileName NOT LIKE 'image%'
		) AS dt
	WHERE dt.DataLoad = 1

	UNION 

	--Images file
	SELECT dt.SourceLocation
	, ArchiveLocation
	, dt.ExtractDir
	, dt.UnzipLocation
	, dt.DW1CopyFileDestination
	, dt.DeleteStagingDir
	FROM(SELECT FilePath AS SourceLocation
		, CONVERT(VARCHAR(500), '\\fs1\Server\IT Department\Medispan\FTPDownload\Archive\Images\' + [FileName]) AS ArchiveLocation
		, CONVERT(VARCHAR(500), '\\AAPDW1\c$\Medispan\Staging\Images\Images\' + REPLACE(FileName, FIleName ,'Images.zip')) AS DW1CopyFileDestination
		, CONVERT(VARCHAR(500), '\\AAPDW1\c$\Medispan\Staging\Images\Images\' + REPLACE(FileName, FIleName ,'Images.zip')) AS UnzipLocation
		, CONVERT(VARCHAR(500), '\\AAPDW1\c$\Medispan\Staging\Images\Images\') AS ExtractDir
		, CONVERT(VARCHAR(500), '\\AAPDW1\c$\Medispan\Staging\Images\Images') AS DeleteStagingDir
		, @Load AS ImageLoad
		FROM [dbo].[mtvf_GetFileInfo](@ImagesDir)
		WHERE FileName LIKE 'image%'
		AND FileName LIKE '%.zip'
		AND FileName NOT LIKE '%SWDATINSCD%'
		AND FileName NOT LIKE '%delimt_pricing%'
		) AS dt
	WHERE dt.ImageLoad = 2

END










GO
