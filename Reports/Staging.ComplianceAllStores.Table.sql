USE [Reports]
GO
/****** Object:  Table [Staging].[ComplianceAllStores]    Script Date: 12/22/2020 7:39:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Staging].[ComplianceAllStores](
	[RowID] [int] IDENTITY(1,1) NOT NULL,
	[MonthDate] [date] NOT NULL,
	[PMID] [int] NOT NULL,
	[GPI] [varchar](25) NOT NULL,
	[TotalQuantityDispensed] [decimal](18, 2) NULL,
	[GenericQuantityDispensed] [decimal](18, 2) NULL,
	[BrandQuantityDispensed] [decimal](18, 2) NULL,
	[APIPurchasedAtIP] [decimal](18, 2) NULL,
	[APIGenericPurchasedAtIP] [decimal](18, 2) NULL,
	[APIBrandPurchasedAtIP] [decimal](18, 2) NULL,
	[APIPurchaseQty] [decimal](18, 2) NULL,
	[APIGenericPurchaseQty] [decimal](18, 2) NULL,
	[APIBrandPurchaseQty] [decimal](18, 2) NULL,
	[APIInvoicePerDose] [decimal](18, 2) NULL,
	[APIGenericInvoicePerDose] [decimal](18, 2) NULL,
	[APIBrandInvoicePerDose] [decimal](18, 2) NULL,
	[CAHPurchasedAtIP] [decimal](18, 2) NULL,
	[CAHGenericPurchasedAtIP] [decimal](18, 2) NULL,
	[CAHBrandPurchasedAtIP] [decimal](18, 2) NULL,
	[CAHPurchaseQty] [decimal](18, 2) NULL,
	[CAHGenericPurchaseQty] [decimal](18, 2) NULL,
	[CAHBrandPurchaseQty] [decimal](18, 2) NULL,
	[CAHInvoicePerDose] [decimal](18, 2) NULL,
	[CAHGenericInvoicePerDose] [decimal](18, 2) NULL,
	[CAHBrandInvoicePerDose] [decimal](18, 2) NULL,
	[RowCreatedDate] [datetime] NOT NULL,
	[TotalDispensedIP] [decimal](18, 2) NOT NULL,
	[GenericDispensedIP] [decimal](18, 2) NOT NULL,
	[BrandDispensedIP] [decimal](18, 2) NOT NULL,
	[CompliancePercent] [decimal](6, 2) NOT NULL,
	[GenericCompliancePercent] [decimal](6, 2) NOT NULL,
	[BrandCompliancePercent] [decimal](6, 2) NOT NULL,
	[DateKey] [int] NOT NULL,
	[GPIKey] [int] NOT NULL,
	[PharmacyKey] [int] NOT NULL,
	[TotalPurchaseQty] [decimal](18, 2) NOT NULL,
	[GenericPurchaseQty] [decimal](18, 2) NOT NULL,
	[BrandPurchaseQty] [decimal](18, 2) NOT NULL,
	[TotalPurchaseIP] [decimal](18, 2) NOT NULL,
	[GenericPurchaseIP] [decimal](18, 2) NOT NULL,
	[BrandPurchaseIP] [decimal](18, 2) NOT NULL,
	[TotalLeakageQty] [decimal](18, 2) NOT NULL,
	[TotalLeakageIP] [decimal](18, 2) NOT NULL,
	[GenericLeakageQty] [decimal](18, 2) NOT NULL,
	[BrandLeakageQty] [decimal](18, 2) NOT NULL,
	[GenericLeakageIP] [decimal](18, 2) NOT NULL,
	[BrandLeakageIP] [decimal](18, 2) NOT NULL,
 CONSTRAINT [CPK_Staging_ComplianceAllStores] PRIMARY KEY CLUSTERED 
(
	[RowID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [AK_Staging_ComplianceAllStores] UNIQUE NONCLUSTERED 
(
	[DateKey] ASC,
	[GPIKey] ASC,
	[PharmacyKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [Staging].[ComplianceAllStores] ADD  DEFAULT ((0.00)) FOR [TotalQuantityDispensed]
GO
ALTER TABLE [Staging].[ComplianceAllStores] ADD  DEFAULT ((0.00)) FOR [GenericQuantityDispensed]
GO
ALTER TABLE [Staging].[ComplianceAllStores] ADD  DEFAULT ((0.00)) FOR [BrandQuantityDispensed]
GO
ALTER TABLE [Staging].[ComplianceAllStores] ADD  DEFAULT ((0.00)) FOR [APIPurchasedAtIP]
GO
ALTER TABLE [Staging].[ComplianceAllStores] ADD  DEFAULT ((0.00)) FOR [APIGenericPurchasedAtIP]
GO
ALTER TABLE [Staging].[ComplianceAllStores] ADD  DEFAULT ((0.00)) FOR [APIBrandPurchasedAtIP]
GO
ALTER TABLE [Staging].[ComplianceAllStores] ADD  DEFAULT ((0.00)) FOR [APIPurchaseQty]
GO
ALTER TABLE [Staging].[ComplianceAllStores] ADD  DEFAULT ((0.00)) FOR [APIGenericPurchaseQty]
GO
ALTER TABLE [Staging].[ComplianceAllStores] ADD  DEFAULT ((0.00)) FOR [APIBrandPurchaseQty]
GO
ALTER TABLE [Staging].[ComplianceAllStores] ADD  DEFAULT ((0.00)) FOR [APIInvoicePerDose]
GO
ALTER TABLE [Staging].[ComplianceAllStores] ADD  DEFAULT ((0.00)) FOR [APIGenericInvoicePerDose]
GO
ALTER TABLE [Staging].[ComplianceAllStores] ADD  DEFAULT ((0.00)) FOR [APIBrandInvoicePerDose]
GO
ALTER TABLE [Staging].[ComplianceAllStores] ADD  DEFAULT ((0.00)) FOR [CAHPurchasedAtIP]
GO
ALTER TABLE [Staging].[ComplianceAllStores] ADD  DEFAULT ((0.00)) FOR [CAHGenericPurchasedAtIP]
GO
ALTER TABLE [Staging].[ComplianceAllStores] ADD  DEFAULT ((0.00)) FOR [CAHBrandPurchasedAtIP]
GO
ALTER TABLE [Staging].[ComplianceAllStores] ADD  DEFAULT ((0.00)) FOR [CAHPurchaseQty]
GO
ALTER TABLE [Staging].[ComplianceAllStores] ADD  DEFAULT ((0.00)) FOR [CAHGenericPurchaseQty]
GO
ALTER TABLE [Staging].[ComplianceAllStores] ADD  DEFAULT ((0.00)) FOR [CAHBrandPurchaseQty]
GO
ALTER TABLE [Staging].[ComplianceAllStores] ADD  DEFAULT ((0.00)) FOR [CAHInvoicePerDose]
GO
ALTER TABLE [Staging].[ComplianceAllStores] ADD  DEFAULT ((0.00)) FOR [CAHGenericInvoicePerDose]
GO
ALTER TABLE [Staging].[ComplianceAllStores] ADD  DEFAULT ((0.00)) FOR [CAHBrandInvoicePerDose]
GO
ALTER TABLE [Staging].[ComplianceAllStores] ADD  DEFAULT (getdate()) FOR [RowCreatedDate]
GO
ALTER TABLE [Staging].[ComplianceAllStores] ADD  DEFAULT ((0.00)) FOR [TotalDispensedIP]
GO
ALTER TABLE [Staging].[ComplianceAllStores] ADD  DEFAULT ((0.00)) FOR [GenericDispensedIP]
GO
ALTER TABLE [Staging].[ComplianceAllStores] ADD  DEFAULT ((0.00)) FOR [BrandDispensedIP]
GO
ALTER TABLE [Staging].[ComplianceAllStores] ADD  DEFAULT ((0.00)) FOR [CompliancePercent]
GO
ALTER TABLE [Staging].[ComplianceAllStores] ADD  DEFAULT ((0.00)) FOR [GenericCompliancePercent]
GO
ALTER TABLE [Staging].[ComplianceAllStores] ADD  DEFAULT ((0.00)) FOR [BrandCompliancePercent]
GO
ALTER TABLE [Staging].[ComplianceAllStores] ADD  DEFAULT ((0.00)) FOR [TotalPurchaseQty]
GO
ALTER TABLE [Staging].[ComplianceAllStores] ADD  DEFAULT ((0.00)) FOR [GenericPurchaseQty]
GO
ALTER TABLE [Staging].[ComplianceAllStores] ADD  DEFAULT ((0.00)) FOR [BrandPurchaseQty]
GO
ALTER TABLE [Staging].[ComplianceAllStores] ADD  DEFAULT ((0.00)) FOR [TotalPurchaseIP]
GO
ALTER TABLE [Staging].[ComplianceAllStores] ADD  DEFAULT ((0.00)) FOR [GenericPurchaseIP]
GO
ALTER TABLE [Staging].[ComplianceAllStores] ADD  DEFAULT ((0.00)) FOR [BrandPurchaseIP]
GO
ALTER TABLE [Staging].[ComplianceAllStores] ADD  DEFAULT ((0.00)) FOR [TotalLeakageQty]
GO
ALTER TABLE [Staging].[ComplianceAllStores] ADD  DEFAULT ((0.00)) FOR [TotalLeakageIP]
GO
ALTER TABLE [Staging].[ComplianceAllStores] ADD  DEFAULT ((0.00)) FOR [GenericLeakageQty]
GO
ALTER TABLE [Staging].[ComplianceAllStores] ADD  DEFAULT ((0.00)) FOR [BrandLeakageQty]
GO
ALTER TABLE [Staging].[ComplianceAllStores] ADD  DEFAULT ((0.00)) FOR [GenericLeakageIP]
GO
ALTER TABLE [Staging].[ComplianceAllStores] ADD  DEFAULT ((0.00)) FOR [BrandLeakageIP]
GO
