USE [Pricing]
GO
/****** Object:  Table [Staging].[McKesson]    Script Date: 12/22/2020 7:32:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Staging].[McKesson](
	[RowID] [int] IDENTITY(1,1) NOT NULL,
	[DateKey] [int] NOT NULL,
	[ItemNumber] [varchar](50) NULL,
	[NDC] [varchar](12) NULL,
	[Price] [money] NULL,
	[RowCreatedDate] [datetime] NOT NULL,
	[RowversionID] [timestamp] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [Staging].[McKesson] ADD  DEFAULT (getdate()) FOR [RowCreatedDate]
GO
