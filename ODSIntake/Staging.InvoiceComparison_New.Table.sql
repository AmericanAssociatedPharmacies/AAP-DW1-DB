USE [ODSIntake]
GO
/****** Object:  Table [Staging].[InvoiceComparison_New]    Script Date: 12/22/2020 7:30:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Staging].[InvoiceComparison_New](
	[RowID] [int] IDENTITY(1,1) NOT NULL,
	[Date] [varchar](500) NULL,
	[Type] [varchar](500) NULL,
	[CIN] [varchar](500) NULL,
	[DESCRIPTION] [varchar](500) NULL,
	[SIZE] [varchar](500) NULL,
	[AAPPrice] [varchar](500) NULL,
	[Supplier] [varchar](500) NULL,
	[BrandName] [varchar](500) NULL,
	[Form] [varchar](500) NULL,
	[NDC_UPC] [varchar](500) NULL,
	[GPI_ID] [varchar](500) NULL,
	[AWP] [varchar](500) NULL,
	[Select] [varchar](500) NULL,
	[Quantity] [varchar](500) NULL,
	[Comp Price] [varchar](500) NULL,
	[Invoice#] [varchar](500) NULL,
	[Invoicedate] [varchar](500) NULL,
	[AAPExt] [varchar](500) NULL,
	[Comp_Ext] [varchar](500) NULL,
	[Size_Diff] [varchar](500) NULL,
	[Comp_NDC] [varchar](500) NULL,
	[Notes] [varchar](500) NULL,
	[RowCreatedDate] [datetime] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [Staging].[InvoiceComparison_New] ADD  DEFAULT (getdate()) FOR [RowCreatedDate]
GO
