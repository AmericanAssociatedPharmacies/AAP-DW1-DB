USE [API]
GO
/****** Object:  Table [dbo].[Order_SalesDetal_XRef_BK20190809]    Script Date: 12/22/2020 6:09:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Order_SalesDetal_XRef_BK20190809](
	[SalesDetailID] [int] NOT NULL,
	[OrderID] [int] NOT NULL,
	[RowCreatedDate] [datetime] NOT NULL
) ON [PRIMARY]
GO
