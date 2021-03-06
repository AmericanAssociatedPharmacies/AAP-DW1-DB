USE [ODSIntake]
GO
/****** Object:  StoredProcedure [dbo].[usp_BenLarson_ExcelConfig_Export]    Script Date: 12/22/2020 7:30:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[usp_BenLarson_ExcelConfig_Export]


AS

SET NOCOUNT ON;

BEGIN

	DECLARE @FileDir VARCHAR(500)

	SET @FileDir = '\\fs1\Server\IT Department\BenLarson\'


	SELECT dt.Source
	FROM(SELECT CONVERT(VARCHAR(500), FilePath) AS Source
		FROM [dbo].[mtvf_GetFileInfo](@FileDir)
		WHERE FileName LIKE '%.XLS'
		) AS dt


END
GO
