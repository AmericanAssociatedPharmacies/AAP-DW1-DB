USE [WebDev]
GO
/****** Object:  Table [dbo].[DIRFees_AetnaTrueUp]    Script Date: 12/22/2020 8:08:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DIRFees_AetnaTrueUp](
	[NetworkName] [nvarchar](255) NULL,
	[PharmacyNABP] [nvarchar](50) NULL,
	[CMSContract] [nvarchar](50) NULL,
	[CMSPBP] [nvarchar](50) NULL,
	[CardholderId] [nvarchar](50) NULL,
	[RxNumber] [nvarchar](50) NULL,
	[Refill Number] [nvarchar](50) NULL,
	[Date Filled] [nvarchar](50) NULL,
	[Quantity Dispensed] [nvarchar](50) NULL,
	[NDC] [nvarchar](50) NULL,
	[Provider NPI] [nvarchar](50) NULL,
	[DAW Indicator] [nvarchar](50) NULL,
	[Pricing Source Code] [nvarchar](50) NULL,
	[Claim Number] [nvarchar](50) NULL,
	[Generic Brand Indication] [nvarchar](50) NULL,
	[Days Supply] [nvarchar](50) NULL,
	[AWP] [nvarchar](50) NULL,
	[Ingredient Cost] [nvarchar](50) NULL,
	[Dispensing Fee Amount] [nvarchar](50) NULL,
	[Claim Source System] [nvarchar](50) NULL,
	[DIR Amount] [nvarchar](50) NULL
) ON [PRIMARY]
GO
