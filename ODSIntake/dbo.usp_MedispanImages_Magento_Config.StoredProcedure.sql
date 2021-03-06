USE [ODSIntake]
GO
/****** Object:  StoredProcedure [dbo].[usp_MedispanImages_Magento_Config]    Script Date: 12/22/2020 7:30:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[usp_MedispanImages_Magento_Config]

AS

SET NOCOUNT ON;

BEGIN

	DECLARE @T TABLE(RowID INT NOT NULL IDENTITY(1,1)
						, FilePath VARCHAR(500)
						, FileDirectory VARCHAR(500)
						, FileName VARCHAR(250)
						, FileSize INT
						, FileCreateTime DATETIME
						, FileInt INT
						)


	INSERT INTO @T(FilePath, FileDirectory, FileName, FileSize, FileCreateTime, FileInt)
	SELECT FilePath
	, FileDirectory
	, FileName
	, FileSize
	, FileCreateTime
	, CONVERT(INT, REPLACE(RIGHT(FileName, 12), '.zip', '')) AS FileInt
	FROM [dbo].[mtvf_GetFileInfo]('\\fs1\Server\IT Department\Medispan\FTPDownload\Archive\Images') AS a
	CROSS APPLY(SELECT MAX(FileCreateTime) AS MAXFileCreateTime
				FROM [dbo].[mtvf_GetFileInfo]('\\fs1\Server\IT Department\Medispan\FTPDownload\Archive\Images')
				) AS ca
	WHERE a.FileCreateTime = MAXFileCreateTime
	--('\\fs1\g\IT Department\Medispan\FTPDownload\Archive\Images')
	--\\fs1\Server\IT Department\Medispan\FTPDownload\Images
	--\\fs1\Server\IT Department\Medispan\FTPDownload\Archive\Images


	SELECT t.FilePath AS Source
	, CONVERT(VARCHAR(1000), ('\\fs1\Server\IT Department\Medispan\Magento\Images\' + FileName)) AS Destination
	FROM(SELECT RowID
			, MAX(FileInt) AS C1
			FROM @T
			GROUP BY RowID
		) AS dt
	INNER JOIN @T AS t ON dt.RowID = t.RowID 

END
GO
