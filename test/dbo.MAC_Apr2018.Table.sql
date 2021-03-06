USE [test]
GO
/****** Object:  Table [dbo].[MAC_Apr2018]    Script Date: 12/22/2020 8:07:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MAC_Apr2018](
	[BINNumber] [float] NULL,
	[PrescriptionNumber] [float] NULL,
	[PayerName] [nvarchar](255) NULL,
	[NDC] [float] NULL,
	[DrugName] [nvarchar](255) NULL,
	[DrugForm] [nvarchar](255) NULL,
	[ProductDescription] [nvarchar](255) NULL,
	[QuantityDispensed] [float] NULL,
	[RXDateFilled] [datetime] NULL,
	[PMID] [float] NULL,
	[CAHContractType] [nvarchar](255) NULL,
	[PharmacyName] [nvarchar](255) NULL,
	[UsualandCustomaryCharge] [float] NULL,
	[RX30TotalPrice] [float] NULL,
	[RX30ReimbursedPricePerUnit] [float] NULL,
	[APICustomerNetPrice] [float] NULL,
	[PackageSize] [float] NULL,
	[CaseSize] [float] NULL,
	[Unit] [nvarchar](255) NULL,
	[TotalPharmacyPaid] [float] NULL,
	[APIPricePerUnit] [float] NULL,
	[APILossGainPerUnit] [float] NULL,
	[APILossGainPerDispensed] [float] NULL,
	[CardinalCustomerNetPrice] [float] NULL,
	[CAHPricePerUnit] [float] NULL,
	[CAHLossGainPerUnit] [float] NULL,
	[CAHLossGainPerDispensed] [float] NULL
) ON [PRIMARY]
GO
