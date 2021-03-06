USE [ODSIntake]
GO
/****** Object:  StoredProcedure [dbo].[usp_BenLarson_Zip_GetConfig]    Script Date: 12/22/2020 7:30:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[usp_BenLarson_Zip_GetConfig]

AS

SET NOCOUNT ON;

BEGIN

	DECLARE @FileDir VARCHAR(1000)

	SET @FileDir = '\\fs1\Server\IT Department\BenLarson'

	SELECT dt.Source
	, dt.Destination
	, dt.Archive
	FROM(SELECT FilePath AS Source
		, REPLACE(FilePath, 'xls', 'zip') AS Destination
		, FileDirectory + '\Archive\' + REPLACE(FileName, 'xls', 'zip') AS Archive
		FROM ODSIntake.[dbo].[mtvf_GetFileInfo](@FileDir)
		WHERE FileName LIKE '%xls'
		) AS dt

END


GO
