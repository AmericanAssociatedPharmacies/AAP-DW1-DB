USE [SalesDDS]
GO
/****** Object:  Table [dbo].[CR_20200701]    Script Date: 12/22/2020 7:55:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CR_20200701](
	[MonthDate] [date] NOT NULL,
	[PMID] [int] NOT NULL,
	[GPI] [varchar](25) NULL,
	[APIPurchasedAtIP] [decimal](18, 2) NULL,
	[APIGenericPurchasedAtIP] [decimal](18, 2) NULL,
	[APIBrandPurchasedAtIP] [decimal](18, 2) NULL,
	[APIPurchaseQty] [decimal](18, 2) NULL,
	[APIGenericPurchaseQty] [decimal](18, 2) NULL,
	[APIBrandPurchaseQty] [decimal](18, 2) NULL,
	[APIInvoicePerDose] [decimal](18, 2) NULL,
	[APIGenericInvoicePerDose] [decimal](18, 2) NULL,
	[APIBrandInvoicePerDose] [decimal](18, 2) NULL
) ON [PRIMARY]
GO
