USE [SSRS]
GO
/****** Object:  Table [dbo].[CR_BetaBeta_RSE_20200622]    Script Date: 12/22/2020 8:05:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CR_BetaBeta_RSE_20200622](
	[GPI] [varchar](14) NULL,
	[Description] [varchar](500) NULL,
	[Purchase Qty] [numeric](38, 3) NULL,
	[Purchases @ IP] [decimal](38, 2) NULL,
	[Dispense Qty] [decimal](18, 2) NULL,
	[Dispense @ IP] [decimal](18, 2) NULL,
	[Leakage Quantity] [numeric](38, 3) NULL,
	[Leakage @ IP] [decimal](38, 2) NULL
) ON [PRIMARY]
GO
