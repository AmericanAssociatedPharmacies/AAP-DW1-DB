USE [ReportServer2017]
GO
/****** Object:  Table [dbo].[SubscriptionsBeingDeleted]    Script Date: 12/22/2020 7:43:21 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SubscriptionsBeingDeleted](
	[SubscriptionID] [uniqueidentifier] NOT NULL,
	[CreationDate] [datetime] NOT NULL,
 CONSTRAINT [PK_SubscriptionsBeingDeleted] PRIMARY KEY CLUSTERED 
(
	[SubscriptionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
