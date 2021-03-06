USE [Pricing]
GO
/****** Object:  Table [dbo].[APIPricing]    Script Date: 12/22/2020 7:32:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[APIPricing](
	[RowID] [int] IDENTITY(1,1) NOT NULL,
	[NDC] [varchar](11) NOT NULL,
	[API_ItemNumber] [varchar](25) NULL,
	[DateKey] [int] NOT NULL,
	[APINetPrice] [money] NULL,
	[APIManufacturerInvoicePrice] [money] NULL,
	[APICustomerInvoicePrice] [money] NULL,
	[APIPricePerUnit] [money] NULL,
	[APIRebate] [money] NULL,
	[APIRebatePercentage] [decimal](5, 2) NULL,
	[APIHoldBackPrice] [money] NULL,
	[APICustomerNetPrice] [money] NULL,
	[RowCreatedDate] [datetime] NOT NULL,
 CONSTRAINT [CPK_APIPricing_RowID] PRIMARY KEY CLUSTERED 
(
	[RowID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[APIPricing] ADD  DEFAULT (getdate()) FOR [RowCreatedDate]
GO
