USE [ODSIntake]
GO
/****** Object:  Table [dbo].[TotalPriceCompare_2_20171102]    Script Date: 12/22/2020 7:30:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TotalPriceCompare_2_20171102](
	[GPPC] [varchar](8) NULL,
	[GPI] [varchar](14) NOT NULL,
	[Description] [varchar](1000) NULL,
	[Size] [decimal](8, 3) NULL,
	[CAHContractType] [varchar](50) NULL,
	[CAHItemNumber] [varchar](25) NULL,
	[CardinalInvoicePrice] [money] NULL,
	[API_ItemNumber] [varchar](25) NULL,
	[APICustomerInvoicePrice] [money] NULL,
	[ABCItemNumber] [varchar](25) NULL,
	[ABCInvoicePrice] [money] NULL,
	[APIQty] [decimal](38, 2) NULL,
	[CAHQty] [decimal](38, 0) NULL
) ON [PRIMARY]
GO
