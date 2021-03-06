USE [API]
GO
/****** Object:  StoredProcedure [Staging].[usp_BenLarson_UpdateFileSource]    Script Date: 12/22/2020 6:09:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [Staging].[usp_BenLarson_UpdateFileSource]

AS

SET NOCOUNT ON;

BEGIN

	DECLARE @FileDir VARCHAR(1000)
	, @File VARCHAR(1000)

	SET @FileDir = '\\fs1\g\IT Department\BenLarson'

	UPDATE x
	SET [FileSource] = cj.FileName
	FROM [Staging].[BenLarson] AS x
	CROSS JOIN(SELECT dt.FileName
				FROM(SELECT FileName
					FROM ODSIntake.[dbo].[mtvf_GetFileInfo](@FileDir)
					WHERE FileName LIKE '%zip'
					) AS dt
				) as cj


END
GO
