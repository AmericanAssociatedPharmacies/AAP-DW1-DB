USE [SalesDDS]
GO
/****** Object:  Table [dbo].[APIPricing]    Script Date: 12/22/2020 7:55:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[APIPricing](
	[NDC] [varchar](11) NULL,
	[API_ItemNumber] [varchar](25) NULL,
	[DateKey] [int] NULL,
	[APINetPrice] [money] NULL,
	[APIManufacturerInvoicePrice] [money] NULL,
	[APICustomerInvoicePrice] [money] NULL,
	[APIPricePerUnit] [money] NULL,
	[APIRebate] [money] NULL,
	[APIRebatePercentage] [decimal](5, 2) NULL,
	[APIHoldBackAmount] [money] NULL,
	[APICustomerNetPrice] [money] NULL
) ON [PRIMARY]
GO
