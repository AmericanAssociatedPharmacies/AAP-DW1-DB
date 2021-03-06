USE [WebDev]
GO
/****** Object:  Table [dbo].[DIRDetails_Aetna]    Script Date: 12/22/2020 8:08:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DIRDetails_Aetna](
	[InvoiceNumber] [nvarchar](50) NULL,
	[InvoiceDate] [nvarchar](50) NULL,
	[NetworkName] [nvarchar](50) NULL,
	[PharmacyNABP] [nvarchar](50) NULL,
	[CMSContract] [nvarchar](50) NULL,
	[CMSPBP] [nvarchar](50) NULL,
	[CardholderId] [nvarchar](50) NULL,
	[RxNumber] [nvarchar](50) NULL,
	[RefillNumber] [nvarchar](50) NULL,
	[DateFilled] [nvarchar](50) NULL,
	[QuantityDispensed] [nvarchar](50) NULL,
	[NDC] [nvarchar](50) NULL,
	[ProviderNPI] [nvarchar](50) NULL,
	[DAWIndicator] [nvarchar](50) NULL,
	[PricingSourceCode] [nvarchar](50) NULL,
	[ClaimNumber] [nvarchar](50) NULL,
	[GenericBrandIndication] [nvarchar](50) NULL,
	[DaysSupply] [nvarchar](50) NULL,
	[AverageWholesalePrice] [nvarchar](50) NULL,
	[IngredientCost] [nvarchar](50) NULL,
	[DispensingFeeAmount] [nvarchar](50) NULL,
	[ClaimSourceSystem] [nvarchar](50) NULL,
	[DIRAmount] [nvarchar](50) NULL
) ON [PRIMARY]
GO
