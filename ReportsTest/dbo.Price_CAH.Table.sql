USE [ReportsTest]
GO
/****** Object:  Table [dbo].[Price_CAH]    Script Date: 12/22/2020 7:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Price_CAH](
	[ITEM_NO] [varchar](31) NULL,
	[NDC] [varchar](15) NULL,
	[TotalSales] [float] NULL,
	[TotalUnits] [numeric](18, 0) NULL,
	[Mnth] [int] NULL,
	[YR] [int] NULL
) ON [PRIMARY]
GO
