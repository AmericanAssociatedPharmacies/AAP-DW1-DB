USE [ReportsTest]
GO
/****** Object:  Table [test].[CustomerTrend]    Script Date: 12/22/2020 7:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [test].[CustomerTrend](
	[PMID] [int] NULL,
	[WoY] [int] NULL,
	[YR] [int] NULL,
	[RunningTotal] [int] NULL,
	[PreviousWeek] [int] NULL,
	[Change] [int] NULL,
	[PreviousChange] [int] NULL,
	[PercentReturn] [float] NULL,
	[ReturnFlag] [int] NULL,
	[Score] [int] NULL
) ON [PRIMARY]
GO
