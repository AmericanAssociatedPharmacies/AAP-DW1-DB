USE [SalesDDS]
GO
/****** Object:  Table [dbo].[SalesFact_CAH_old_RSE_20200727]    Script Date: 12/22/2020 7:55:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SalesFact_CAH_old_RSE_20200727](
	[PharmacyKey] [int] NOT NULL,
	[DateKey] [int] NOT NULL,
	[DrugKey] [int] NOT NULL,
	[CAHEventKey] [int] NOT NULL,
	[CAHEventDateKey] [int] NOT NULL,
	[CAHInvoiceQuantity] [int] NULL,
	[CAHUnitAmount] [money] NULL,
	[CAHExtendedSales] [money] NULL,
	[CAH_AWP] [money] NULL,
	[CAH_WAC] [money] NULL,
	[TransactionCount] [tinyint] NOT NULL,
	[RowCreatedDate] [datetime] NOT NULL,
	[RowUpdatedDate] [datetime] NULL,
	[PurchaseAtIP] [decimal](18, 2) NOT NULL,
	[GenericPurchaseAtIP] [decimal](18, 2) NOT NULL,
	[BrandPurchaseAtIP] [decimal](18, 2) NOT NULL,
	[PurchaseQty] [decimal](18, 2) NOT NULL,
	[GenericPurchaseQty] [decimal](18, 2) NOT NULL,
	[BrandPurchaseQty] [decimal](18, 2) NOT NULL,
	[InvoicePerDose] [decimal](18, 2) NOT NULL,
	[GenericInvoicePerDose] [decimal](18, 2) NOT NULL,
	[BrandInvoicePerDose] [decimal](18, 2) NOT NULL,
	[Doses] [decimal](18, 2) NOT NULL,
	[GenericDoses] [decimal](18, 2) NOT NULL,
	[BrandDoses] [decimal](18, 2) NOT NULL,
	[PricePerUnit] [decimal](18, 2) NOT NULL,
 CONSTRAINT [CPK_SalesFact_CAH_2] PRIMARY KEY CLUSTERED 
(
	[PharmacyKey] ASC,
	[DateKey] ASC,
	[DrugKey] ASC,
	[CAHEventKey] ASC,
	[CAHEventDateKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [psSalesFact_RangeLeft]([DateKey])
) ON [psSalesFact_RangeLeft]([DateKey])
GO
ALTER TABLE [dbo].[SalesFact_CAH_old_RSE_20200727] ADD  DEFAULT ((0)) FOR [CAHEventKey]
GO
ALTER TABLE [dbo].[SalesFact_CAH_old_RSE_20200727] ADD  DEFAULT ((1)) FOR [TransactionCount]
GO
ALTER TABLE [dbo].[SalesFact_CAH_old_RSE_20200727] ADD  DEFAULT (getdate()) FOR [RowCreatedDate]
GO
ALTER TABLE [dbo].[SalesFact_CAH_old_RSE_20200727] ADD  DEFAULT ((0.00)) FOR [PurchaseAtIP]
GO
ALTER TABLE [dbo].[SalesFact_CAH_old_RSE_20200727] ADD  DEFAULT ((0.00)) FOR [GenericPurchaseAtIP]
GO
ALTER TABLE [dbo].[SalesFact_CAH_old_RSE_20200727] ADD  DEFAULT ((0.00)) FOR [BrandPurchaseAtIP]
GO
ALTER TABLE [dbo].[SalesFact_CAH_old_RSE_20200727] ADD  DEFAULT ((0.00)) FOR [PurchaseQty]
GO
ALTER TABLE [dbo].[SalesFact_CAH_old_RSE_20200727] ADD  DEFAULT ((0.00)) FOR [GenericPurchaseQty]
GO
ALTER TABLE [dbo].[SalesFact_CAH_old_RSE_20200727] ADD  DEFAULT ((0.00)) FOR [BrandPurchaseQty]
GO
ALTER TABLE [dbo].[SalesFact_CAH_old_RSE_20200727] ADD  DEFAULT ((0.00)) FOR [InvoicePerDose]
GO
ALTER TABLE [dbo].[SalesFact_CAH_old_RSE_20200727] ADD  DEFAULT ((0.00)) FOR [GenericInvoicePerDose]
GO
ALTER TABLE [dbo].[SalesFact_CAH_old_RSE_20200727] ADD  DEFAULT ((0.00)) FOR [BrandInvoicePerDose]
GO
ALTER TABLE [dbo].[SalesFact_CAH_old_RSE_20200727] ADD  DEFAULT ((0.00)) FOR [Doses]
GO
ALTER TABLE [dbo].[SalesFact_CAH_old_RSE_20200727] ADD  DEFAULT ((0.00)) FOR [GenericDoses]
GO
ALTER TABLE [dbo].[SalesFact_CAH_old_RSE_20200727] ADD  DEFAULT ((0.00)) FOR [BrandDoses]
GO
ALTER TABLE [dbo].[SalesFact_CAH_old_RSE_20200727] ADD  DEFAULT ((0.00)) FOR [PricePerUnit]
GO
