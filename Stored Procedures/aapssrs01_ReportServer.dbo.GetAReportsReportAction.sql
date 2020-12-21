USE [aapssrs01_ReportServer]
GO

/****** Object: SqlProcedure [dbo].[GetAReportsReportAction] Script Date: 12/21/2020 8:59:50 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetAReportsReportAction]
@ReportID uniqueidentifier,
@ReportAction int
AS
select
        RS.[ReportAction],
        RS.[ScheduleID],
        RS.[ReportID],
        RS.[SubscriptionID],
        C.[Path],
        C.[Type]
from
    [ReportSchedule] RS Inner join [Catalog] C on RS.[ReportID] = C.[ItemID]
where
    C.ItemID = @ReportID and RS.[ReportAction] = @ReportAction
