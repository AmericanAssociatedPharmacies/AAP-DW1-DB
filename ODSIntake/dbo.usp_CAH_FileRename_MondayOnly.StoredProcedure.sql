USE [ODSIntake]
GO
/****** Object:  StoredProcedure [dbo].[usp_CAH_FileRename_MondayOnly]    Script Date: 12/22/2020 7:30:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[usp_CAH_FileRename_MondayOnly]

AS

SET NOCOUNT ON;

BEGIN

DECLARE @FileDir VARCHAR(1000)
, @Monday DATETIME
, @Saturday DATETIME
 
SET @FileDir = '\\fs1.aap.local\Server\IT Department\Cardinal\ForumlaryFiles'

SELECT @Monday = dt.StartDate
, @Saturday = DATEADD(day, 5, dt.StartDate) 
FROM(SELECT CONVERT(DATETIME, REPLACE(RIGHT(FileName, 13), '.xlsx' , '')) AS StartDate
	FROM dbo.mtvf_GetFileInfo(@FileDir)
	) AS dt


DECLARE @T TABLE(DateKey INT)

INSERT INTO @T(DateKey)
SELECT DateKey
FROM Pricing.dbo.DateDim
WHERE TheDate >=  @Monday
AND TheDate < @Saturday



SELECT dt.Source
, dt.Destination
FROM(SELECT dt.Source
	, dt.Destination
	FROM(SELECT CONVERT(VARCHAR(1000), FilePath) AS Source
		, CONVERT(VARCHAR(1000), FileDirectory + '\Archive\' + FileName) AS Destination 
		FROM dbo.mtvf_GetFileInfo(@FileDir)
		) AS dt


	UNION ALL


	SELECT dt.Source
	, ca.Destination
	FROM(SELECT CONVERT(VARCHAR(1000), FilePath) AS Source
		, CONVERT(VARCHAR(1000), FileDirectory + '\Archive\' + FileName) AS Destination 
		FROM dbo.mtvf_GetFileInfo(@FileDir)
		) AS dt
	CROSS APPLY(SELECT CONVERT(VARCHAR(1000), REPLACE(dt.Destination, RIGHT(dt.Destination, 13), CONVERT(VARCHAR, t.DateKey) + '.xlsx')) AS Destination
				FROM @T AS t
				) AS ca
	) AS dt

END

GO
