USE [API]
GO
/****** Object:  Table [Staging].[API_Top100_Sales]    Script Date: 12/22/2020 6:09:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Staging].[API_Top100_Sales](
	[RowID] [int] IDENTITY(1,1) NOT NULL,
	[RankBySalesMonth_CurrentMonth] [int] NULL,
	[NDC_1] [varchar](13) NULL,
	[APIItemNbr_1] [varchar](25) NULL,
	[MonthName_1] [varchar](15) NULL,
	[Qty_1] [int] NULL,
	[Sales_1] [money] NULL,
	[APICustomerInvoiceAmount_1] [varchar](250) NULL,
	[RankBySalesMonth_2] [int] NULL,
	[NDC_2] [varchar](13) NULL,
	[APIItemNbr_2] [varchar](25) NULL,
	[MonthName_2] [varchar](15) NULL,
	[Qty_2] [int] NULL,
	[Sales_2] [money] NULL,
	[APICustomerInvoiceAmount_2] [varchar](250) NULL,
	[RankBySalesMonth_3] [int] NULL,
	[NDC_3] [varchar](13) NULL,
	[APIItemNbr_3] [varchar](25) NULL,
	[MonthName_3] [varchar](15) NULL,
	[Qty_3] [int] NULL,
	[Sales_3] [money] NULL,
	[APICustomerInvoiceAmount_3] [varchar](250) NULL,
	[Description] [varchar](500) NULL,
	[Manufacturer] [varchar](30) NULL,
	[PackageSize] [numeric](8, 3) NULL,
	[RowCreatedDate] [datetime] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [Staging].[API_Top100_Sales] ADD  DEFAULT (getdate()) FOR [RowCreatedDate]
GO
