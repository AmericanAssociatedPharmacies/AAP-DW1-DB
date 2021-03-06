USE [ODSIntake]
GO
/****** Object:  StoredProcedure [dbo].[usp_GetCHAAPImportConfigInfo]    Script Date: 12/22/2020 7:30:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[usp_GetCHAAPImportConfigInfo]

	@FileDir VARCHAR(500)

AS

SET NOCOUNT ON;

BEGIN


	SELECT dt.SourceLocation
	, dt.ArchiveLocation
	FROM(SELECT FilePath AS SourceLocation
		, FileDirectory + '\Archive\' + FileName AS ArchiveLocation
		FROM [dbo].[mtvf_GetFileInfo](@FileDir)
		) AS dt


END



GO
