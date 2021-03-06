USE [ODSIntake]
GO
/****** Object:  Table [dbo].[PriceCompare_20170815_old]    Script Date: 12/22/2020 7:30:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PriceCompare_20170815_old](
	[RowID] [int] NOT NULL,
	[GPI] [varchar](14) NOT NULL,
	[API_NDC] [varchar](11) NOT NULL,
	[CAH_NDC] [varchar](11) NULL,
	[ABC_NDC] [varchar](max) NULL,
	[DrugName] [varchar](100) NULL,
	[Strength] [numeric](13, 5) NULL,
	[PackageSize] [numeric](8, 3) NULL,
	[APICustomerInvoicePrice] [money] NULL,
	[APICustomerNetPrice] [money] NULL,
	[CardinalInvoicePrice] [money] NULL,
	[ABCInvoicePrice] [money] NULL,
 CONSTRAINT [CPK_PriceCompare_20170815] PRIMARY KEY CLUSTERED 
(
	[RowID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
