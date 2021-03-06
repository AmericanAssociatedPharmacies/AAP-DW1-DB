USE [ClaimsDDS]
GO
/****** Object:  StoredProcedure [dbo].[usp_FDS_GetZipFileInfo]    Script Date: 12/22/2020 6:54:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_FDS_GetZipFileInfo]

AS

SET NOCOUNT ON;

BEGIN

	DECLARE @FileDir VARCHAR(500)

	SET @FileDir = '\\fs1.aap.local\Server\IT Department\FDS\Staging'

	SELECT CONVERT(VARCHAR(500), FileDirectory) AS FileDirectory
	, CONVERT(VARCHAR(500), FilePath) AS SourceFile
	FROM ODSIntake.dbo.mtvf_GetFileInfo(@FileDir)
	WHERE FileName LIKE '%.zip'

END
GO
