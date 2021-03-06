USE [ODSIntake]
GO
/****** Object:  StoredProcedure [dbo].[usp_GetABCFileInfo]    Script Date: 12/22/2020 7:30:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_GetABCFileInfo]


AS


SET NOCOUNT ON;

BEGIN

	SELECT dt.FilePath
	, dt.DateKey
	FROM(SELECT FilePath
			, FileCreateTime
			, CAST(FORMAT(FileCreateTime, 'yyyyMMdd') AS INT) AS DateKey
			FROM [dbo].[mtvf_GetFileInfo]('\\apinetstore\shared\Denise\Sherrie\ABC')
			WHERE filename = 'ABC.TXT'
		) AS dt

END
GO
