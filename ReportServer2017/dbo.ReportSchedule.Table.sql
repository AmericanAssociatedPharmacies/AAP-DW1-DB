USE [ReportServer2017]
GO
/****** Object:  Table [dbo].[ReportSchedule]    Script Date: 12/22/2020 7:43:21 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ReportSchedule](
	[ScheduleID] [uniqueidentifier] NOT NULL,
	[ReportID] [uniqueidentifier] NOT NULL,
	[SubscriptionID] [uniqueidentifier] NULL,
	[ReportAction] [int] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ReportSchedule]  WITH CHECK ADD  CONSTRAINT [FK_ReportSchedule_Report] FOREIGN KEY([ReportID])
REFERENCES [dbo].[Catalog] ([ItemID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ReportSchedule] CHECK CONSTRAINT [FK_ReportSchedule_Report]
GO
ALTER TABLE [dbo].[ReportSchedule]  WITH CHECK ADD  CONSTRAINT [FK_ReportSchedule_Schedule] FOREIGN KEY([ScheduleID])
REFERENCES [dbo].[Schedule] ([ScheduleID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ReportSchedule] CHECK CONSTRAINT [FK_ReportSchedule_Schedule]
GO
ALTER TABLE [dbo].[ReportSchedule]  WITH NOCHECK ADD  CONSTRAINT [FK_ReportSchedule_Subscriptions] FOREIGN KEY([SubscriptionID])
REFERENCES [dbo].[Subscriptions] ([SubscriptionID])
NOT FOR REPLICATION 
GO
ALTER TABLE [dbo].[ReportSchedule] NOCHECK CONSTRAINT [FK_ReportSchedule_Subscriptions]
GO
