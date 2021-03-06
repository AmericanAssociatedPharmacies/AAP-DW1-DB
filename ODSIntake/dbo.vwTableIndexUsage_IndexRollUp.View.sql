USE [ODSIntake]
GO
/****** Object:  View [dbo].[vwTableIndexUsage_IndexRollUp]    Script Date: 12/22/2020 7:30:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vwTableIndexUsage_IndexRollUp]

AS



SELECT ServerName 
, DbName
, ObjectName
, SchemaName
, IndexName
, SUM(ISNULL([IndexSizeKB],0)) AS [IndexSizeKB]
, SUM(ISNULL([user_seeks],0)) AS TotalUserSeeks
, SUM(ISNULL([user_scans],0)) AS TotalUserScans
, SUM(ISNULL([user_lookups],0)) AS TotalUserLookUps
, SUM(ISNULL([user_updates],0)) AS TotalUserUpdates
, MAX([last_user_seek]) AS LastUserSeek
, MAX([last_user_scan]) AS LastUserScan
, MAX([last_user_lookup]) AS LastUserLookup
, MAX([last_user_update]) AS LastUserUpdate
FROM [dbo].[TableIndexUsage]
GROUP BY ServerName , DbName, ObjectName, SchemaName, IndexName

GO
