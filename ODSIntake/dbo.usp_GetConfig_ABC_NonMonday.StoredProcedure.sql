USE [ODSIntake]
GO
/****** Object:  StoredProcedure [dbo].[usp_GetConfig_ABC_NonMonday]    Script Date: 12/22/2020 7:30:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_GetConfig_ABC_NonMonday]

AS

SET NOCOUNT ON;

BEGIN

	DECLARE @CurrentDate VARCHAR(8)

	SET @CurrentDate = REPLACE(CONVERT(DATE, GETDATE()), '-' , '')


	SELECT dt.Source
	, dt.Destination
	FROM(SELECT CONVERT(VARCHAR(500), FilePath) AS Source
		, CONVERT(VARCHAR(500), REPLACE(FileDirectory, 'Archive', '') + FileName) AS Destination
		, CONVERT(VARCHAR(8), REPLACE(RIGHT(FileName, 12), '.TXT', '')) AS DateKey
		FROM [dbo].[mtvf_GetFileInfo]('\\fs1\Server\IT Department\ABC\Archive')
		) AS dt
	WHERE dt.DateKey = @CurrentDate

END
GO
