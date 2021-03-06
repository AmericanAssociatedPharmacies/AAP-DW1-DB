USE [ODSIntake]
GO
/****** Object:  Table [dbo].[FairShare_20180627]    Script Date: 12/22/2020 7:30:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FairShare_20180627](
	[CustNum] [varchar](500) NULL,
	[ProdNum] [varchar](500) NULL,
	[ProdDesc] [varchar](500) NULL,
	[NDC] [varchar](500) NULL,
	[Count] [varchar](500) NULL,
	[Min Exp Date] [varchar](500) NULL,
	[Price] [varchar](500) NULL,
	[90 Day Qty] [varchar](500) NULL,
	[Requested Qty] [varchar](500) NULL,
	[Start Date] [varchar](500) NULL,
	[End Date] [varchar](500) NULL
) ON [PRIMARY]
GO
