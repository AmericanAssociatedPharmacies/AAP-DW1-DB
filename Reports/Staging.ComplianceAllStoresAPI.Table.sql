USE [Reports]
GO
/****** Object:  Table [Staging].[ComplianceAllStoresAPI]    Script Date: 12/22/2020 7:39:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Staging].[ComplianceAllStoresAPI](
	[RowID] [int] IDENTITY(1,1) NOT NULL,
	[MonthDate] [date] NOT NULL,
	[PMID] [int] NOT NULL,
	[GPI] [varchar](25) NOT NULL,
	[APIPurchasedAtIP] [decimal](18, 2) NULL,
	[APIGenericPurchasedAtIP] [decimal](18, 2) NULL,
	[APIBrandPurchasedAtIP] [decimal](18, 2) NULL,
	[APIPurchaseQty] [decimal](18, 2) NULL,
	[APIGenericPurchaseQty] [decimal](18, 2) NULL,
	[APIBrandPurchaseQty] [decimal](18, 2) NULL,
	[APIInvoicePerDose] [decimal](18, 2) NULL,
	[APIGenericInvoicePerDose] [decimal](18, 2) NULL,
	[APIBrandInvoicePerDose] [decimal](18, 2) NULL,
	[DateKey] [int] NOT NULL,
	[GPIKey] [int] NOT NULL,
	[PharmacyKey] [int] NOT NULL,
	[RowCreateDate] [datetime] NOT NULL,
 CONSTRAINT [CPK_Staging_ComplianceAllStoresAPI] PRIMARY KEY CLUSTERED 
(
	[RowID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [AK_Staging_ComplianceAllStoresAPI] UNIQUE NONCLUSTERED 
(
	[DateKey] ASC,
	[GPIKey] ASC,
	[PharmacyKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [Staging].[ComplianceAllStoresAPI] ADD  DEFAULT ((0.00)) FOR [APIPurchasedAtIP]
GO
ALTER TABLE [Staging].[ComplianceAllStoresAPI] ADD  DEFAULT ((0.00)) FOR [APIGenericPurchasedAtIP]
GO
ALTER TABLE [Staging].[ComplianceAllStoresAPI] ADD  DEFAULT ((0.00)) FOR [APIBrandPurchasedAtIP]
GO
ALTER TABLE [Staging].[ComplianceAllStoresAPI] ADD  DEFAULT ((0.00)) FOR [APIPurchaseQty]
GO
ALTER TABLE [Staging].[ComplianceAllStoresAPI] ADD  DEFAULT ((0.00)) FOR [APIGenericPurchaseQty]
GO
ALTER TABLE [Staging].[ComplianceAllStoresAPI] ADD  DEFAULT ((0.00)) FOR [APIBrandPurchaseQty]
GO
ALTER TABLE [Staging].[ComplianceAllStoresAPI] ADD  DEFAULT ((0.00)) FOR [APIInvoicePerDose]
GO
ALTER TABLE [Staging].[ComplianceAllStoresAPI] ADD  DEFAULT ((0.00)) FOR [APIGenericInvoicePerDose]
GO
ALTER TABLE [Staging].[ComplianceAllStoresAPI] ADD  DEFAULT ((0.00)) FOR [APIBrandInvoicePerDose]
GO
ALTER TABLE [Staging].[ComplianceAllStoresAPI] ADD  DEFAULT (getdate()) FOR [RowCreateDate]
GO
