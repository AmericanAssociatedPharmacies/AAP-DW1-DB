USE [aapssrs01_ReportServer]
GO

/****** Object: Table [dbo].[ReportSchedule] Script Date: 12/21/2020 8:08:12 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[ReportSchedule] (
    [ScheduleID]     UNIQUEIDENTIFIER NOT NULL,
    [ReportID]       UNIQUEIDENTIFIER NOT NULL,
    [SubscriptionID] UNIQUEIDENTIFIER NULL,
    [ReportAction]   INT              NOT NULL
);


GO
CREATE NONCLUSTERED INDEX [IX_ReportSchedule_ReportID]
    ON [dbo].[ReportSchedule]([ReportID] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_ReportSchedule_ScheduleID]
    ON [dbo].[ReportSchedule]([ScheduleID] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_ReportSchedule_SubscriptionID]
    ON [dbo].[ReportSchedule]([SubscriptionID] ASC);


GO
ALTER TABLE [dbo].[ReportSchedule]
    ADD CONSTRAINT [FK_ReportSchedule_Report] FOREIGN KEY ([ReportID]) REFERENCES [dbo].[Catalog] ([ItemID]) ON DELETE CASCADE;


GO
ALTER TABLE [dbo].[ReportSchedule]
    ADD CONSTRAINT [FK_ReportSchedule_Schedule] FOREIGN KEY ([ScheduleID]) REFERENCES [dbo].[Schedule] ([ScheduleID]) ON DELETE CASCADE;


GO
ALTER TABLE [dbo].[ReportSchedule]
    ADD CONSTRAINT [FK_ReportSchedule_Subscriptions] FOREIGN KEY ([SubscriptionID]) REFERENCES [dbo].[Subscriptions] ([SubscriptionID]) NOT FOR REPLICATION;


GO
ALTER TABLE [dbo].[ReportSchedule] NOCHECK CONSTRAINT [FK_ReportSchedule_Subscriptions];


