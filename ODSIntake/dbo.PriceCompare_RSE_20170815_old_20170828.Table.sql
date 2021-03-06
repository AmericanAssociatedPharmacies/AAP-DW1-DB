USE [ODSIntake]
GO
/****** Object:  Table [dbo].[PriceCompare_RSE_20170815_old_20170828]    Script Date: 12/22/2020 7:30:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PriceCompare_RSE_20170815_old_20170828](
	[GPI] [varchar](14) NOT NULL,
	[API_NDC] [varchar](11) NOT NULL,
	[CAH_NDC] [varchar](11) NULL,
	[ABC_NDC] [varchar](12) NULL,
	[DrugName] [varchar](100) NULL,
	[API_PackageSize] [numeric](8, 3) NULL,
	[APICustomerInvoicePrice] [money] NULL,
	[APICustomerNetPrice] [money] NULL,
	[CardinalInvoicePrice] [money] NULL,
	[CardinalPackageSize] [numeric](8, 3) NULL,
	[ABCInvoicePrice] [money] NULL,
	[ABCPackageSize] [numeric](8, 3) NULL
) ON [PRIMARY]
GO
