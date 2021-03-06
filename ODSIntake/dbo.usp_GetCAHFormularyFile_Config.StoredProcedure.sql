USE [ODSIntake]
GO
/****** Object:  StoredProcedure [dbo].[usp_GetCAHFormularyFile_Config]    Script Date: 12/22/2020 7:30:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[usp_GetCAHFormularyFile_Config]

	@FileDir VARCHAR(1000)
	, @FileName VARCHAR(250)

AS


SET NOCOUNT ON;


BEGIN

	SELECT dt.Source
	, dt.Destination
	FROM(SELECT FilePath AS Source
		, CONVERT(VARCHAR(500), FileDirectory + '\Archive\' + [FileName] ) AS Destination
		FROM [dbo].[mtvf_GetFileInfo](@FileDir)
		WHERE FileName LIKE '%' + @FileName + '%'
		) AS dt

END
GO
