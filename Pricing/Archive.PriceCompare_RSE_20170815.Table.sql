USE [Pricing]
GO
/****** Object:  Table [Archive].[PriceCompare_RSE_20170815]    Script Date: 12/22/2020 7:32:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Archive].[PriceCompare_RSE_20170815](
	[RowID] [int] IDENTITY(1,1) NOT NULL,
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
	[IsCAHContract] [bit] NOT NULL,
	[RowCreatedDate] [datetime] NOT NULL,
 CONSTRAINT [CPK_Archive_PriceCompare_RSE_20170815] PRIMARY KEY CLUSTERED 
(
	[RowID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [Archive].[PriceCompare_RSE_20170815] ADD  DEFAULT ((0)) FOR [IsCAHContract]
GO
ALTER TABLE [Archive].[PriceCompare_RSE_20170815] ADD  DEFAULT (getdate()) FOR [RowCreatedDate]
GO
