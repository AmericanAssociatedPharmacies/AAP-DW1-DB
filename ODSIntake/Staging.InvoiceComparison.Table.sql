USE [ODSIntake]
GO
/****** Object:  Table [Staging].[InvoiceComparison]    Script Date: 12/22/2020 7:30:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Staging].[InvoiceComparison](
	[Date] [varchar](500) NULL,
	[Type] [varchar](500) NULL,
	[CIN] [varchar](500) NULL,
	[DESCRIPTION] [varchar](500) NULL,
	[SIZE] [varchar](500) NULL,
	[AAP Price] [varchar](500) NULL,
	[Supplier] [varchar](500) NULL,
	[Brand Name] [varchar](500) NULL,
	[Form] [varchar](500) NULL,
	[NDC/UPC] [varchar](500) NULL,
	[GPI_ID] [varchar](500) NULL,
	[AWP] [varchar](500) NULL,
	[Select] [varchar](500) NULL,
	[Quantity] [varchar](500) NULL,
	[Comp Price] [varchar](500) NULL,
	[Invoice#] [varchar](500) NULL,
	[Invoice date] [varchar](500) NULL,
	[AAP Ext] [varchar](500) NULL,
	[Comp_Ext] [varchar](500) NULL,
	[Size_Diff] [varchar](500) NULL,
	[Comp_NDC] [varchar](500) NULL,
	[Notes] [varchar](500) NULL
) ON [PRIMARY]
GO
