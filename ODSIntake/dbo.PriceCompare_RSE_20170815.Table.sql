USE [ODSIntake]
GO
/****** Object:  Table [dbo].[PriceCompare_RSE_20170815]    Script Date: 12/22/2020 7:30:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PriceCompare_RSE_20170815](
	[GPI] [varchar](14) NOT NULL,
	[API_NDC] [varchar](11) NOT NULL,
	[CAH_NDC] [varchar](11) NULL,
	[ABC_NDC] [varchar](11) NULL,
	[DrugName] [varchar](100) NULL,
	[API_ItemNumber] [nvarchar](255) NULL,
	[API_PackageSize] [numeric](8, 3) NULL,
	[APICustomerInvoicePrice] [money] NULL,
	[APICustomerNetPrice] [money] NULL,
	[API_Manufacturer] [varchar](50) NULL,
	[CardinalInvoicePrice] [money] NULL,
	[CardinalPackageSize] [numeric](8, 3) NULL,
	[CAH_Manufacturer] [varchar](30) NULL,
	[ABCInvoicePrice] [money] NULL,
	[ABCPackageSize] [numeric](8, 3) NULL,
	[ABC_Manufacturer] [varchar](30) NULL,
	[RowCreatedDate] [datetime] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[PriceCompare_RSE_20170815] ADD  DEFAULT (getdate()) FOR [RowCreatedDate]
GO
