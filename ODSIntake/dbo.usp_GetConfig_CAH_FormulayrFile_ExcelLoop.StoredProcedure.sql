USE [ODSIntake]
GO
/****** Object:  StoredProcedure [dbo].[usp_GetConfig_CAH_FormulayrFile_ExcelLoop]    Script Date: 12/22/2020 7:30:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_GetConfig_CAH_FormulayrFile_ExcelLoop]

AS

SET NOCOUNT ON;

BEGIN


	DECLARE @FileDir VARCHAR(1000)

	SET @FileDir = '\\fs1.aap.local\Server\IT Department\Cardinal\FormularyFiles'

	SELECT dt.FileSource
	, dt.DateKey
	FROM(SELECT dt.FileSource
			, CONVERT(INT, CASE
							WHEN ISDATE(dt.DateKey) = 1 THEN CONVERT(varchar(20),CONVERT(DATETIME, DATEADD(wk, DATEDIFF(wk,0,dt.DateKey), 0)),112)
							ELSE CONVERT(varchar(20),dt.DateKey2,112)
							END) AS DateKey
			FROM(SELECT CONVERT(VARCHAR(1000), FilePath) AS FileSource
				, REPLACE(RIGHT(FileName, 13), '.xlsx', '') AS DateKey
				, DATEADD(wk, DATEDIFF(wk,0,FileCreateTime), 0) AS DateKey2 
				FROM [dbo].[mtvf_GetFileInfo](@FileDir)
				WHERE FileName LIKE '%.xlsx'
				) AS dt
	) AS dt
	ORDER BY dt.DateKey ASC

END




GO
