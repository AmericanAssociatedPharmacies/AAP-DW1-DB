USE [ODSIntake]
GO
/****** Object:  StoredProcedure [dbo].[usp_GetCAHFormularyConfigInfo_RawFileDataLoad]    Script Date: 12/22/2020 7:30:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[usp_GetCAHFormularyConfigInfo_RawFileDataLoad]

	@FileDir VARCHAR(500)

AS

SET NOCOUNT ON;

BEGIN


	SELECT dt.FilePath
	, dt.DateKey
	FROM(SELECT FilePath
		, CONVERT(INT, REPLACE(RIGHT(FileName, 12), '.csv', '')) AS DateKey
		FROM [dbo].[mtvf_GetFileInfo](@FileDir)
		) AS dt


END


GO
