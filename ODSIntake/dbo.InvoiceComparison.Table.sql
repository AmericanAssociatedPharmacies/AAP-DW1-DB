USE [ODSIntake]
GO
/****** Object:  Table [dbo].[InvoiceComparison]    Script Date: 12/22/2020 7:30:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[InvoiceComparison](
	[RowID] [int] IDENTITY(1,1) NOT NULL,
	[Date] [datetime] NULL,
	[Type] [varchar](15) NULL,
	[CIN] [varchar](25) NULL,
	[DESCRIPTION] [varchar](255) NULL,
	[SIZE] [varchar](50) NULL,
	[AAPPrice] [money] NULL,
	[Supplier] [varchar](50) NULL,
	[BrandName] [varchar](50) NULL,
	[Form] [varchar](100) NULL,
	[NDC_UPC] [varchar](15) NULL,
	[GPI_ID] [varchar](25) NULL,
	[AWP] [money] NULL,
	[Select] [varchar](10) NULL,
	[Quantity] [int] NULL,
	[CompPrice] [varchar](50) NULL,
	[Invoice#] [varchar](50) NULL,
	[Invoicedate] [datetime] NULL,
	[AAPExt] [varchar](50) NULL,
	[CompExt] [varchar](50) NULL,
	[Sizediff] [varchar](50) NULL,
	[CompNDC] [varchar](50) NULL,
	[Notes] [varchar](255) NULL,
	[RowCreatedDate] [datetime] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[InvoiceComparison] ADD  DEFAULT (getdate()) FOR [RowCreatedDate]
GO
