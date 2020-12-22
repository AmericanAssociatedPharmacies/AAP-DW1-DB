USE [ReportServer2017]
GO
/****** Object:  StoredProcedure [dbo].[GetCacheSchedule]    Script Date: 12/22/2020 7:43:21 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetCacheSchedule]
@ReportID uniqueidentifier
AS
SELECT
    S.[ScheduleID],
    S.[Name],
    S.[StartDate],
    S.[Flags],
    S.[NextRunTime],
    S.[LastRunTime],
    S.[EndDate],
    S.[RecurrenceType],
    S.[MinutesInterval],
    S.[DaysInterval],
    S.[WeeksInterval],
    S.[DaysOfWeek],
    S.[DaysOfMonth],
    S.[Month],
    S.[MonthlyWeek],
    S.[State],
    S.[LastRunStatus],
    S.[ScheduledRunTimeout],
    S.[EventType],
    S.[EventData],
    S.[Type],
    S.[Path],
    Owner.[UserName],
    Owner.[UserName],
    Owner.[AuthType],
    RS.ReportAction
FROM
    Schedule S with (XLOCK) inner join ReportSchedule RS on S.ScheduleID = RS.ScheduleID
    inner join [Users] Owner on S.[CreatedById] = Owner.[UserID]
WHERE
    (RS.ReportAction = 1 or RS.ReportAction = 3) and -- 1 == UpdateCache, 3 == Invalidate cache
    RS.[ReportID] = @ReportID
GO
