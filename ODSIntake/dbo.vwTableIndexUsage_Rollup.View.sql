USE [ODSIntake]
GO
/****** Object:  View [dbo].[vwTableIndexUsage_Rollup]    Script Date: 12/22/2020 7:30:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vwTableIndexUsage_Rollup]

AS

SELECT dt.*
FROM(SELECT ServerName
	, DbName
	, SchemaName
	, ObjectName
	, SUM(IndexSizeKB) AS Size
	, SUM(ISNULL(user_seeks,0)) AS UserSeeks
	, SUM(ISNULL(user_scans,0)) AS UserScans
	, SUM(ISNULL(user_lookups,0)) AS UserLookUps
	, SUM(ISNULL(user_updates,0)) AS UserUpdates
	, MAX(last_user_seek) AS LastUserSeek
	, MAX(last_user_scan) AS LastUserScan
	, MAX(last_user_lookup) AS LastUserLookup
	, MAX(last_user_update) AS LastUserUpdate
	FROM [dbo].[TableIndexUsage]
	GROUP BY ServerName
	, DbName
	, SchemaName
	, ObjectName
	) AS dt


--SELECT *
--FROM [dbo].[TableIndexUsage]
--	WHERE ServerName = 'DB1'
GO
