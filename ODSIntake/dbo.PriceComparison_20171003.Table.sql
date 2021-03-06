USE [ODSIntake]
GO
/****** Object:  Table [dbo].[PriceComparison_20171003]    Script Date: 12/22/2020 7:30:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PriceComparison_20171003](
	[GPI] [varchar](14) NOT NULL,
	[API_NDC] [varchar](11) NOT NULL,
	[CAH_NDC] [varchar](12) NOT NULL,
	[ABC_NDC] [varchar](12) NOT NULL,
	[DrugName] [varchar](100) NULL,
	[API_ItemNumber] [varchar](25) NULL,
	[API_PackageSize] [numeric](8, 3) NULL,
	[APICustomerInvoicePrice] [money] NULL,
	[APICustomerNetPrice] [money] NULL,
	[API_Manufacturer] [varchar](50) NULL,
	[CardinalInvoicePrice] [money] NULL,
	[CardinalPackageSize] [numeric](8, 3) NULL,
	[CAH_Manufacturer] [varchar](50) NULL,
	[ABCInvoicePrice] [money] NULL,
	[ABCPackageSize] [numeric](8, 3) NULL,
	[ABC_Manufacturer] [varchar](50) NULL,
	[IsCAHContract] [bit] NULL
) ON [PRIMARY]
GO
