USE [SalesDDS]
GO
/****** Object:  Table [dbo].[CAHPartitionsToReload]    Script Date: 12/22/2020 7:55:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CAHPartitionsToReload](
	[RN] [int] NOT NULL,
	[DateKey] [int] NULL
) ON [PRIMARY]
GO
