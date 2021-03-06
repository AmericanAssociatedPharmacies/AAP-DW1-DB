USE [SSRS]
GO
/****** Object:  Table [dbo].[SR1169_2]    Script Date: 12/22/2020 8:05:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SR1169_2](
	[TM] [int] NULL,
	[PMID] [int] NULL,
	[AAPAccountNumber] [nvarchar](100) NULL,
	[AAPParent] [nvarchar](20) NULL,
	[GroupID] [nvarchar](100) NULL,
	[AAPEffectiveDate] [date] NULL,
	[AAPQuitDate] [date] NULL,
	[Description] [nvarchar](252) NULL,
	[Affiliate] [nvarchar](250) NULL,
	[PharmacyName] [nvarchar](255) NULL,
	[City] [nvarchar](255) NULL,
	[State] [nvarchar](255) NULL,
	[Contact] [nvarchar](100) NULL,
	[TotalBRx] [money] NULL,
	[TotalGRx] [money] NULL,
	[NetSourceGenerics] [money] NULL,
	[OtherRx] [money] NULL,
	[NonRx] [money] NULL,
	[Excluded] [money] NULL,
	[AVGTotal] [money] NULL,
	[APIBrand] [money] NULL,
	[APIGen] [money] NULL,
	[APIOTC] [money] NULL,
	[APIGenericSalesTier1] [money] NULL,
	[APIGenericSalesTier2] [money] NULL
) ON [PRIMARY]
GO
