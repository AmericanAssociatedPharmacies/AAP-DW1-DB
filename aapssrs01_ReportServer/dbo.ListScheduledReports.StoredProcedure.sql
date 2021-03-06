USE [aapssrs01_ReportServer]
GO
/****** Object:  StoredProcedure [dbo].[ListScheduledReports]    Script Date: 12/22/2020 5:44:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ListScheduledReports]
@ScheduleID uniqueidentifier
AS
-- List all reports for a schedule
select
        RS.[ReportAction],
        RS.[ScheduleID],
        RS.[ReportID],
        RS.[SubscriptionID],
        C.[Path],
        C.[Type],
        C.[Name],
        C.[Description],
        C.[ModifiedDate],
        U.[UserName],
        U.[UserName],
        DATALENGTH( C.Content ),
        C.ExecutionTime,
        S.[Type],
        SD.[NtSecDescPrimary],
        SU.[ReportZone]

from
    [ReportSchedule] RS Inner join [Catalog] C on RS.[ReportID] = C.[ItemID]
    Inner join [Schedule] S on RS.[ScheduleID] = S.[ScheduleID]
    Inner join [Users] U on C.[ModifiedByID] = U.UserID
    left outer join [SecData] SD on SD.[PolicyID] = C.[PolicyID] AND SD.AuthType = U.AuthType
    left outer join [Subscriptions] SU on SU.[SubscriptionID] = RS.[SubscriptionID]
where
    RS.[ScheduleID] = @ScheduleID
GO
