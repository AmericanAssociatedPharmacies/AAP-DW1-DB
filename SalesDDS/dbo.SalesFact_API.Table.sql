USE [SalesDDS]
GO
/****** Object:  Table [dbo].[SalesFact_API]    Script Date: 12/22/2020 7:55:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SalesFact_API](
	[PharmacyKey] [int] NOT NULL,
	[DateKey] [int] NOT NULL,
	[DrugKey] [int] NOT NULL,
	[APIEventKey] [int] NOT NULL,
	[APIEventDateKey] [int] NOT NULL,
	[APIInvoiceQuantity] [int] NULL,
	[APIUnitAmount] [money] NULL,
	[APILineItemAmount] [money] NULL,
	[APIExtendedAmount] [money] NULL,
	[TransactionCount] [tinyint] NOT NULL,
	[RowCreatedDate] [datetime] NOT NULL,
	[RowUpdatedDate] [datetime] NULL,
	[APIHoldBackPercent] [decimal](18, 4) NOT NULL,
	[APIHoldBackAmount] [money] NOT NULL,
	[RebateAfterAPIHoldbackAmount] [money] NOT NULL,
	[AffiliateHoldbackPercent] [decimal](18, 4) NOT NULL,
	[AffiliateHoldbackAmount] [money] NOT NULL,
	[FinalRebateAmount] [money] NOT NULL,
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
	[IsCredit] [bit] NOT NULL,
	[GPIKey] [int] NOT NULL,
 CONSTRAINT [CPK_SalesFact_API] PRIMARY KEY CLUSTERED 
(
	[PharmacyKey] ASC,
	[DateKey] ASC,
	[DrugKey] ASC,
	[APIEventKey] ASC,
	[APIEventDateKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [psSalesFact_RangeLeft]([DateKey])
) ON [psSalesFact_RangeLeft]([DateKey])
GO
ALTER TABLE [dbo].[SalesFact_API] ADD  DEFAULT ((1)) FOR [TransactionCount]
GO
ALTER TABLE [dbo].[SalesFact_API] ADD  DEFAULT (getdate()) FOR [RowCreatedDate]
GO
ALTER TABLE [dbo].[SalesFact_API] ADD  DEFAULT ((0.00)) FOR [APIHoldBackPercent]
GO
ALTER TABLE [dbo].[SalesFact_API] ADD  DEFAULT ((0.00)) FOR [APIHoldBackAmount]
GO
ALTER TABLE [dbo].[SalesFact_API] ADD  DEFAULT ((0.00)) FOR [RebateAfterAPIHoldbackAmount]
GO
ALTER TABLE [dbo].[SalesFact_API] ADD  DEFAULT ((0.00)) FOR [AffiliateHoldbackPercent]
GO
ALTER TABLE [dbo].[SalesFact_API] ADD  DEFAULT ((0.00)) FOR [AffiliateHoldbackAmount]
GO
ALTER TABLE [dbo].[SalesFact_API] ADD  DEFAULT ((0.00)) FOR [FinalRebateAmount]
GO
ALTER TABLE [dbo].[SalesFact_API] ADD  DEFAULT ((0.00)) FOR [PurchaseAtIP]
GO
ALTER TABLE [dbo].[SalesFact_API] ADD  DEFAULT ((0.00)) FOR [GenericPurchaseAtIP]
GO
ALTER TABLE [dbo].[SalesFact_API] ADD  DEFAULT ((0.00)) FOR [BrandPurchaseAtIP]
GO
ALTER TABLE [dbo].[SalesFact_API] ADD  DEFAULT ((0.00)) FOR [PurchaseQty]
GO
ALTER TABLE [dbo].[SalesFact_API] ADD  DEFAULT ((0.00)) FOR [GenericPurchaseQty]
GO
ALTER TABLE [dbo].[SalesFact_API] ADD  DEFAULT ((0.00)) FOR [BrandPurchaseQty]
GO
ALTER TABLE [dbo].[SalesFact_API] ADD  DEFAULT ((0.00)) FOR [InvoicePerDose]
GO
ALTER TABLE [dbo].[SalesFact_API] ADD  DEFAULT ((0.00)) FOR [GenericInvoicePerDose]
GO
ALTER TABLE [dbo].[SalesFact_API] ADD  DEFAULT ((0.00)) FOR [BrandInvoicePerDose]
GO
ALTER TABLE [dbo].[SalesFact_API] ADD  DEFAULT ((0.00)) FOR [Doses]
GO
ALTER TABLE [dbo].[SalesFact_API] ADD  DEFAULT ((0.00)) FOR [GenericDoses]
GO
ALTER TABLE [dbo].[SalesFact_API] ADD  DEFAULT ((0.00)) FOR [BrandDoses]
GO
ALTER TABLE [dbo].[SalesFact_API] ADD  DEFAULT ((0.00)) FOR [PricePerUnit]
GO
ALTER TABLE [dbo].[SalesFact_API] ADD  DEFAULT ((0)) FOR [IsCredit]
GO
ALTER TABLE [dbo].[SalesFact_API] ADD  DEFAULT ((0)) FOR [GPIKey]
GO
ALTER TABLE [dbo].[SalesFact_API]  WITH NOCHECK ADD  CONSTRAINT [FK_SalesFact_API_DateKey] FOREIGN KEY([DateKey])
REFERENCES [dbo].[DateDim] ([DateKey])
GO
ALTER TABLE [dbo].[SalesFact_API] CHECK CONSTRAINT [FK_SalesFact_API_DateKey]
GO
ALTER TABLE [dbo].[SalesFact_API]  WITH NOCHECK ADD  CONSTRAINT [FK_SalesFact_API_DrugKey] FOREIGN KEY([DrugKey])
REFERENCES [dbo].[DrugDim] ([DrugKey])
GO
ALTER TABLE [dbo].[SalesFact_API] CHECK CONSTRAINT [FK_SalesFact_API_DrugKey]
GO
ALTER TABLE [dbo].[SalesFact_API]  WITH NOCHECK ADD  CONSTRAINT [FK_SalesFact_API_EventDimAPI] FOREIGN KEY([APIEventKey], [DateKey])
REFERENCES [dbo].[EventDimAPI] ([EventKey], [DateKey])
GO
ALTER TABLE [dbo].[SalesFact_API] CHECK CONSTRAINT [FK_SalesFact_API_EventDimAPI]
GO
ALTER TABLE [dbo].[SalesFact_API]  WITH NOCHECK ADD  CONSTRAINT [FK_SalesFact_API_PharmacyKey] FOREIGN KEY([PharmacyKey])
REFERENCES [dbo].[PharmacyDim] ([PharmacyKey])
GO
ALTER TABLE [dbo].[SalesFact_API] CHECK CONSTRAINT [FK_SalesFact_API_PharmacyKey]
GO
