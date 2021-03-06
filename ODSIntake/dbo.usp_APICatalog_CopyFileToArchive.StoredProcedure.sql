USE [ODSIntake]
GO
/****** Object:  StoredProcedure [dbo].[usp_APICatalog_CopyFileToArchive]    Script Date: 12/22/2020 7:30:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--DECLARE @FileDir VARCHAR(1000)

--SET @FileDir = '\\fs1.aap.local\Server\IT Department\API\Catalog'

CREATE PROCEDURE [dbo].[usp_APICatalog_CopyFileToArchive]

	@FileDir VARCHAR(1000)

AS

BEGIN

	SELECT dt.Source
	, dt.Destination
	FROM(SELECT CONVERT(VARCHAR(1000), FilePath) AS Source
		, CONVERT(VARCHAR(1000), FileDirectory + '\Archive\' + FileName) AS Destination
		FROM [dbo].[mtvf_GetFileInfo](@FileDir)
		WHERE FileName LIKE '%.txt'
		) AS dt


END
GO
