USE [ODSIntake]
GO
/****** Object:  StoredProcedure [dbo].[usp_ShrinkFile_AllDatabases]    Script Date: 12/22/2020 7:30:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO








CREATE PROCEDURE [dbo].[usp_ShrinkFile_AllDatabases]

AS

SET NOCOUNT ON;

BEGIN


	DECLARE @p1 VARCHAR(1000)
	, @StartDate DATETIME
	, @EndDate DATETIME


	DECLARE C1 CURSOR FOR
	SELECT dt.C1
	FROM(SELECT ROW_NUMBER() OVER(PARTITION BY dbid, fileid ORDER BY dbid ASC, fileid ASC) AS RN
	, CONVERT(VARCHAR(1000), 'USE ' + DB_NAME(dbid) + '; DBCC SHRINKFILE (' + CONVERT(VARCHAR, fileid) + ',1);') AS C1
	FROM sys.sysaltfiles AS a
	WHERE dbid NOT IN(1,3,4,32767,7)
	AND EXISTS(SELECT 1
				FROM sys.databases AS d
				WHERE a.dbid = d.database_id
				AND d.state_desc = 'ONLINE'	
				)
	
	) AS dt
	ORDER BY dt.RN ASC

	OPEN C1

	FETCH NEXT
	FROM C1
	INTO @p1

	WHILE @@FETCH_STATUS = 0
	BEGIN

		SET @StartDate = GETDATE()

		INSERT INTO ODSIntake.dbo.DBA_ShrinkFile_Log(SQLCommand, StartDate)
		VALUES(@p1, @StartDate)
	
		EXEC(@p1)

		SET @EndDate = GETDATE()
	
		INSERT INTO ODSIntake.dbo.DBA_ShrinkFile_Log(SQLCommand, EndDate)
		VALUES(@p1, @EndDate)
	
		FETCH NEXT
		FROM C1
		INTO @p1

	

	END

	CLOSE C1
	DEALLOCATE C1


END







GO
