USE [ODSIntake]
GO
/****** Object:  Table [dbo].[CAH_Top100_Vol]    Script Date: 12/22/2020 7:30:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CAH_Top100_Vol](
	[RankByVolMonth_CurrentMonth] [int] NULL,
	[NDC_1] [varchar](13) NULL,
	[CIN_1] [varchar](25) NULL,
	[MonthName_1] [varchar](15) NULL,
	[Qty_1] [int] NULL,
	[Sales_1] [money] NULL,
	[CAHCustomerInvoiceAmount_1] [varchar](250) NULL,
	[CAHContractType_1] [varchar](50) NULL,
	[RankByVolMonth_2] [int] NULL,
	[NDC_2] [varchar](13) NULL,
	[CIN_2] [varchar](25) NULL,
	[MonthName_2] [varchar](15) NULL,
	[Qty_2] [int] NULL,
	[Sales_2] [money] NULL,
	[CAHCustomerInvoiceAmount_2] [varchar](250) NULL,
	[CAHContractType_2] [varchar](50) NULL,
	[RankByVolMonth_3] [int] NULL,
	[NDC_3] [varchar](13) NULL,
	[CIN_3] [varchar](25) NULL,
	[MonthName_3] [varchar](15) NULL,
	[Qty_3] [int] NULL,
	[Sales_3] [money] NULL,
	[CAHCustomerInvoiceAmount_3] [varchar](250) NULL,
	[CAHContractType_3] [varchar](50) NULL,
	[Description] [varchar](500) NULL,
	[Vendor] [varchar](250) NULL,
	[PackageSize] [numeric](8, 3) NULL,
	[GPPC] [varchar](25) NULL,
	[GPI] [varchar](14) NULL,
	[RowCreatedDate] [datetime] NOT NULL
) ON [PRIMARY]
GO
