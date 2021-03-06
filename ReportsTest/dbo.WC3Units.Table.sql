USE [ReportsTest]
GO
/****** Object:  Table [dbo].[WC3Units]    Script Date: 12/22/2020 7:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WC3Units](
	[APIAccountNum] [varchar](50) NULL,
	[WoY] [int] NULL,
	[Yr] [int] NULL,
	[RunningTotal] [float] NULL,
	[PreviousWeek] [float] NULL,
	[Delta] [float] NULL,
	[PreviousDelta] [float] NULL,
	[PercentReturn] [float] NULL,
	[ReturnFlag] [float] NULL,
	[Score] [float] NULL
) ON [PRIMARY]
GO
