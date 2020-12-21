USE [aapssrs01_ReportServer]
GO

/****** Object: SqlProcedure [dbo].[CleanEventRecords] Script Date: 12/21/2020 8:31:33 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[CleanEventRecords]
@MaxAgeMinutes int
AS
-- Reset all notifications which have been add over n minutes ago
Update [Event] set [ProcessStart] = NULL, [ProcessHeartbeat] = NULL
where [EventID] in
   ( SELECT [EventID]
     FROM [Event]
     WHERE [ProcessHeartbeat] < DATEADD(minute, -(@MaxAgeMinutes), GETUTCDATE()) )
