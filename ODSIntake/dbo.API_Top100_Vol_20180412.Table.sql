USE [ODSIntake]
GO
/****** Object:  Table [dbo].[API_Top100_Vol_20180412]    Script Date: 12/22/2020 7:30:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[API_Top100_Vol_20180412](
	[RankByVolMonth_CurrentMonth] [int] NULL,
	[NDC_1] [varchar](13) NULL,
	[APIItemNbr_1] [varchar](25) NULL,
	[MonthName_1] [varchar](15) NULL,
	[Qty_1] [int] NULL,
	[Sales_1] [money] NULL,
	[APICustomerInvoiceAmount_1] [varchar](250) NULL,
	[RankByVolMonth_2] [int] NULL,
	[NDC_2] [varchar](13) NULL,
	[APIItemNbr_2] [varchar](25) NULL,
	[MonthName_2] [varchar](15) NULL,
	[Qty_2] [int] NULL,
	[Sales_2] [money] NULL,
	[APICustomerInvoiceAmount_2] [varchar](250) NULL,
	[RankByVolMonth_3] [int] NULL,
	[NDC_3] [varchar](13) NULL,
	[APIItemNbr_3] [varchar](25) NULL,
	[MonthName_3] [varchar](15) NULL,
	[Qty_3] [int] NULL,
	[Sales_3] [money] NULL,
	[APICustomerInvoiceAmount_3] [varchar](250) NULL,
	[Description] [varchar](500) NULL,
	[Manufacturer] [varchar](30) NULL,
	[PackageSize] [numeric](8, 3) NULL
) ON [PRIMARY]
GO
