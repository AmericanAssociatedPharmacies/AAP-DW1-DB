USE [ODSIntake]
GO
/****** Object:  StoredProcedure [dbo].[usp_RX30_ZipFiles_ConfigInfo]    Script Date: 12/22/2020 7:30:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[usp_RX30_ZipFiles_ConfigInfo]

AS

SET NOCOUNT ON;

BEGIN

	DECLARE @FileDir VARCHAR(500)
	
	SET @FileDir = '\\fs1.aap.local\Server\IT Department\RX30\Archive'
	

	SELECT CONVERT(VARCHAR(1000), FilePath) AS SourceFile
	, CONVERT(VARCHAR(1000), REPLACE(FilePath, '.txt', '.gz')) AS DestinationFile
	FROM [dbo].[mtvf_GetFileInfo](@FileDir)
	WHERE FileName LIKE '%.txt'




END
GO
