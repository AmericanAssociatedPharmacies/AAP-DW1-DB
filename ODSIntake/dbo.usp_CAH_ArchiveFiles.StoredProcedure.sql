USE [ODSIntake]
GO
/****** Object:  StoredProcedure [dbo].[usp_CAH_ArchiveFiles]    Script Date: 12/22/2020 7:30:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[usp_CAH_ArchiveFiles]

AS

SET NOCOUNT ON;

BEGIN

	
	SELECT dt.SourceLocation
	, dt.DestinationLocation
	FROM(SELECT FilePath AS SourceLocation
		, CONVERT(VARCHAR(500), ('\\fs1.aap.local\Server\IT Department\CardinalCatalog\Archive\' + FileName)) AS DestinationLocation
		FROM [dbo].[mtvf_GetFileInfo]('\\fs1.aap.local\Server\IT Department\CardinalCatalog')
		) AS dt

END
GO
