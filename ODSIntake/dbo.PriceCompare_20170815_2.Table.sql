USE [ODSIntake]
GO
/****** Object:  Table [dbo].[PriceCompare_20170815_2]    Script Date: 12/22/2020 7:30:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PriceCompare_20170815_2](
	[GPI] [varchar](14) NOT NULL,
	[API_NDC] [varchar](11) NOT NULL,
	[CAH_NDC] [varchar](11) NULL,
	[ABC_NDC] [varchar](12) NULL,
	[DrugName] [varchar](100) NULL,
	[Strength] [numeric](13, 5) NULL,
	[PackageSize] [numeric](8, 3) NULL,
	[APICustomerInvoicePrice] [float] NULL,
	[APINetPrice] [money] NULL,
	[CardinalInvoicePrice] [money] NULL,
	[ABCInvoicePrice] [money] NULL
) ON [PRIMARY]
GO
