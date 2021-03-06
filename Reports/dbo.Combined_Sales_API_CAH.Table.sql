USE [Reports]
GO
/****** Object:  Table [dbo].[Combined_Sales_API_CAH]    Script Date: 12/22/2020 7:39:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Combined_Sales_API_CAH](
	[NDC] [varchar](15) NULL,
	[InvDate] [datetime2](3) NULL,
	[UnitPrice] [float] NULL,
	[ExtSales] [float] NULL,
	[Quantity] [decimal](38, 0) NULL,
	[SalesSource] [varchar](3) NOT NULL
) ON [PRIMARY]
GO
