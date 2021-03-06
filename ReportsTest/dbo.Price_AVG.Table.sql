USE [ReportsTest]
GO
/****** Object:  Table [dbo].[Price_AVG]    Script Date: 12/22/2020 7:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Price_AVG](
	[CAHItemNumber] [varchar](31) NULL,
	[NDC] [varchar](15) NULL,
	[AVG_NADAC] [float] NULL,
	[AVG_CAH] [float] NULL,
	[AVG_API] [float] NULL,
	[Delta] [float] NULL,
	[Mnth] [int] NULL,
	[YR] [int] NULL,
	[Flag] [int] NULL
) ON [PRIMARY]
GO
