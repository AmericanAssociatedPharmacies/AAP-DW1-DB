USE [ODSIntake]
GO
/****** Object:  StoredProcedure [dbo].[usp_FDS_FileConfig]    Script Date: 12/22/2020 7:30:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_FDS_FileConfig]

AS

SET NOCOUNT ON;

BEGIN

	SELECT dt.SourcePath
	FROM(SELECT FilePath AS SourcePath
		, REPLACE(FilePath, 'Staging', 'Archive') AS ArchivePath
		FROM [dbo].[mtvf_GetFileInfo]('\\fs1.aap.local\Server\IT Department\FDS\Staging\')
		WHERE FileName LIKE '%.txt'
		) AS dt

END
GO
