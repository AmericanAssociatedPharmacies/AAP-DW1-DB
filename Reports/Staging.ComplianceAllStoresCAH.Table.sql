USE [Reports]
GO
/****** Object:  Table [Staging].[ComplianceAllStoresCAH]    Script Date: 12/22/2020 7:39:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Staging].[ComplianceAllStoresCAH](
	[RowID] [int] IDENTITY(1,1) NOT NULL,
	[MonthDate] [date] NOT NULL,
	[PMID] [int] NOT NULL,
	[GPI] [varchar](25) NOT NULL,
	[CAHPurchasedAtIP] [decimal](18, 2) NULL,
	[CAHGenericPurchasedAtIP] [decimal](18, 2) NULL,
	[CAHBrandPurchasedAtIP] [decimal](18, 2) NULL,
	[CAHPurchaseQty] [decimal](18, 2) NULL,
	[CAHGenericPurchaseQty] [decimal](18, 2) NULL,
	[CAHBrandPurchaseQty] [decimal](18, 2) NULL,
	[CAHInvoicePerDose] [decimal](18, 2) NULL,
	[CAHGenericInvoicePerDose] [decimal](18, 2) NULL,
	[CAHBrandInvoicePerDose] [decimal](18, 2) NULL,
	[DateKey] [int] NOT NULL,
	[GPIKey] [int] NOT NULL,
	[PharmacyKey] [int] NOT NULL,
	[RowCreateDate] [datetime] NOT NULL,
 CONSTRAINT [CPK_Staging_ComplianceAllStoresCAH] PRIMARY KEY CLUSTERED 
(
	[RowID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [AK_Staging_ComplianceAllStoresCAH] UNIQUE NONCLUSTERED 
(
	[DateKey] ASC,
	[GPIKey] ASC,
	[PharmacyKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [Staging].[ComplianceAllStoresCAH] ADD  DEFAULT ((0.00)) FOR [CAHPurchasedAtIP]
GO
ALTER TABLE [Staging].[ComplianceAllStoresCAH] ADD  DEFAULT ((0.00)) FOR [CAHGenericPurchasedAtIP]
GO
ALTER TABLE [Staging].[ComplianceAllStoresCAH] ADD  DEFAULT ((0.00)) FOR [CAHBrandPurchasedAtIP]
GO
ALTER TABLE [Staging].[ComplianceAllStoresCAH] ADD  DEFAULT ((0.00)) FOR [CAHPurchaseQty]
GO
ALTER TABLE [Staging].[ComplianceAllStoresCAH] ADD  DEFAULT ((0.00)) FOR [CAHGenericPurchaseQty]
GO
ALTER TABLE [Staging].[ComplianceAllStoresCAH] ADD  DEFAULT ((0.00)) FOR [CAHBrandPurchaseQty]
GO
ALTER TABLE [Staging].[ComplianceAllStoresCAH] ADD  DEFAULT ((0.00)) FOR [CAHInvoicePerDose]
GO
ALTER TABLE [Staging].[ComplianceAllStoresCAH] ADD  DEFAULT ((0.00)) FOR [CAHGenericInvoicePerDose]
GO
ALTER TABLE [Staging].[ComplianceAllStoresCAH] ADD  DEFAULT ((0.00)) FOR [CAHBrandInvoicePerDose]
GO
ALTER TABLE [Staging].[ComplianceAllStoresCAH] ADD  DEFAULT (getdate()) FOR [RowCreateDate]
GO
