USE [Reports]
GO
/****** Object:  Table [dbo].[MACAnalysis]    Script Date: 12/22/2020 7:39:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MACAnalysis](
	[RowID] [int] IDENTITY(1,1) NOT NULL,
	[RX30ClaimFactDateKey] [int] NOT NULL,
	[PricingFactDateKey] [int] NULL,
	[BINNumber] [varchar](25) NULL,
	[PrescriptionNumber] [varchar](25) NULL,
	[PayerName] [varchar](255) NULL,
	[NDC] [varchar](11) NOT NULL,
	[DrugName] [varchar](100) NULL,
	[DrugForm] [varchar](25) NULL,
	[ProductDescription] [varchar](500) NULL,
	[QuantityDispensed] [decimal](10, 3) NULL,
	[RXDateFilled] [date] NULL,
	[PMID] [int] NOT NULL,
	[PharmacyName] [varchar](255) NULL,
	[RX30EventKey] [int] NOT NULL,
	[RX30TotalPrice] [money] NULL,
	[RX30ReimbursedPricePerUnit] [money] NULL,
	[APICustomerInvoicePrice] [money] NULL,
	[APIPackageSize] [numeric](8, 3) NULL,
	[TotalPharmacyPaid] [money] NULL,
	[ReimbursedPricePerUnit] [money] NULL,
	[APIPricePerUnit] [money] NULL,
	[APINetPricePerUnit] [money] NULL,
	[CardinalInvoicePrice] [money] NULL,
	[CardinalPackageSize] [numeric](8, 3) NULL,
	[CAHPricePerUnit] [money] NULL,
	[CAHNetPricePerUnit] [money] NULL,
	[RowCreatedDate] [datetime] NOT NULL,
 CONSTRAINT [CPK_MACAnalysis] PRIMARY KEY CLUSTERED 
(
	[RowID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[MACAnalysis] ADD  DEFAULT (getdate()) FOR [RowCreatedDate]
GO
