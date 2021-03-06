USE [ReportServer]
GO
/****** Object:  Table [dbo].[SubscriptionResults]    Script Date: 12/22/2020 7:41:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SubscriptionResults](
	[SubscriptionResultID] [uniqueidentifier] NOT NULL,
	[SubscriptionID] [uniqueidentifier] NOT NULL,
	[ExtensionSettingsHash] [int] NOT NULL,
	[ExtensionSettings] [nvarchar](max) NOT NULL,
	[SubscriptionResult] [nvarchar](260) NULL,
 CONSTRAINT [PK_SubscriptionResults] PRIMARY KEY CLUSTERED 
(
	[SubscriptionResultID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[SubscriptionResults]  WITH NOCHECK ADD  CONSTRAINT [FK_SubscriptionResults_Subscriptions] FOREIGN KEY([SubscriptionID])
REFERENCES [dbo].[Subscriptions] ([SubscriptionID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[SubscriptionResults] CHECK CONSTRAINT [FK_SubscriptionResults_Subscriptions]
GO
