USE [ReportServer2017]
GO
/****** Object:  Table [dbo].[AlertSubscribers]    Script Date: 12/22/2020 7:43:21 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AlertSubscribers](
	[AlertSubscriptionID] [bigint] IDENTITY(1,1) NOT NULL,
	[AlertType] [nvarchar](50) NOT NULL,
	[UserID] [uniqueidentifier] NOT NULL,
	[ItemID] [uniqueidentifier] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[AlertSubscribers]  WITH CHECK ADD  CONSTRAINT [FK_AlertSubscribers_Catalog] FOREIGN KEY([ItemID])
REFERENCES [dbo].[Catalog] ([ItemID])
GO
ALTER TABLE [dbo].[AlertSubscribers] CHECK CONSTRAINT [FK_AlertSubscribers_Catalog]
GO
ALTER TABLE [dbo].[AlertSubscribers]  WITH CHECK ADD  CONSTRAINT [FK_AlertSubscribers_Users] FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[AlertSubscribers] CHECK CONSTRAINT [FK_AlertSubscribers_Users]
GO
