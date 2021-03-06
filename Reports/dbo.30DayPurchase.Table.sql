USE [Reports]
GO
/****** Object:  Table [dbo].[30DayPurchase]    Script Date: 12/22/2020 7:39:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[30DayPurchase](
	[RowID] [int] IDENTITY(1,1) NOT NULL,
	[PMID] [int] NOT NULL,
	[AccountName] [varchar](500) NULL,
	[Territory] [varchar](4) NULL,
	[LastPurchaseDate] [date] NULL,
	[SalesYTD] [varchar](100) NULL,
	[DaysSinceLastPurchase] [int] NULL,
	[Email] [varchar](255) NULL,
	[Status] [varchar](25) NULL,
	[RowCreatedDate] [datetime] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[30DayPurchase] ADD  DEFAULT (getdate()) FOR [RowCreatedDate]
GO
