USE [ODSIntake]
GO
/****** Object:  StoredProcedure [dbo].[usp_GetRX30FileArchiveList]    Script Date: 12/22/2020 7:30:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_GetRX30FileArchiveList]

 AS

 SET NOCOUNT ON;

 DECLARE @FileProcessed TABLE (FileProcessed VARCHAR(1000))


 INSERT INTO @FileProcessed(FileProcessed)
 SELECT DISTINCT FileProcessed
 FROM ODSIntake.Archive.Rx30Claims
 WHERE RowCreatedDate < '2018'

 
 SELECT dt.FileProcessed, dt.FileName
 FROM (SELECT FileProcessed
			 , REPLACE(RIGHT(FileProcessed, CHARINDEX('\', REVERSE(FileProcessed)) - 1), '.csv', '') AS [FileName]
	   FROM @FileProcessed
		) AS dt
GO
