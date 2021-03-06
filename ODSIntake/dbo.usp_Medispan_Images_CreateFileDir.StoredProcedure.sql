USE [ODSIntake]
GO
/****** Object:  StoredProcedure [dbo].[usp_Medispan_Images_CreateFileDir]    Script Date: 12/22/2020 7:30:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_Medispan_Images_CreateFileDir]

AS

SET NOCOUNT ON;

BEGIN

	DECLARE @DBName sysname
	, @DataPath nvarchar(500)
	, @LogPath nvarchar(500)
	, @FileDir VARCHAR(500)

	DECLARE @DirTree TABLE (subdirectory nvarchar(255), depth INT)

	SET @DBName = 'Images'
	SET @FileDir = '\\AAPDW1\c$\Medispan\Staging\Images\'
	SET @DataPath = '\\AAPDW1\c$\Medispan\Staging\Images\' + @DBName
	
	--Get file directory list
	INSERT INTO @DirTree(subdirectory, depth)
	EXEC master.sys.xp_dirtree @FileDir

	--Create the @DataPath directory
	IF NOT EXISTS (SELECT 1 FROM @DirTree WHERE subdirectory = @DBName)
	EXEC master.dbo.xp_create_subdir @DataPath

END
GO
