USE [PharmacyMaster]
GO
/****** Object:  Table [dbo].[CH_ALLPVA_SALES]    Script Date: 12/22/2020 7:35:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CH_ALLPVA_SALES](
	[Date] [datetime] NULL,
	[PMID] [int] NULL,
	[CHAccountNo] [float] NULL,
	[DCNum] [int] NULL,
	[DCCity] [varchar](255) NULL,
	[AccountName] [varchar](255) NULL,
	[Address] [varchar](255) NULL,
	[City] [varchar](255) NULL,
	[State] [varchar](50) NULL,
	[ZIP] [varchar](50) NULL,
	[APIAccountNo] [varchar](20) NULL,
	[AAPAccountNo] [varchar](20) NULL,
	[UDAccountNo] [varchar](20) NULL,
	[DEA] [varchar](50) NULL,
	[APICOGAppliedSales] [float] NULL,
	[APINetSales] [float] NULL,
	[APIGENRx] [float] NULL,
	[APIGENTotalSrc] [float] NULL,
	[APIGENTotalP2P3] [float] NULL,
	[APIGENTotal] [float] NULL,
	[APIBrand] [float] NULL,
	[APIOTC] [float] NULL,
	[APIOther] [float] NULL,
	[APIGBRPerc] [decimal](18, 4) NULL,
	[AAPCOGAppliedSales] [float] NULL,
	[AAPNetSales] [float] NULL,
	[AAPBrand] [float] NULL,
	[AAPGENTotal] [float] NULL,
	[AAPGENTotalSrc] [float] NULL,
	[AAPGENExcl] [float] NULL,
	[AAPOTC] [float] NULL,
	[AAPOther] [float] NULL,
	[UDNetSales] [float] NULL,
	[UDBrand] [float] NULL,
	[UDGENTotalSrc] [float] NULL,
	[UDGENTotal] [float] NULL,
	[UDOTC] [float] NULL,
	[UDOther] [float] NULL,
	[UDAdminOnly] [float] NULL,
	[CombNetSales] [float] NULL,
	[CombBrands] [float] NULL,
	[CombOTC] [float] NULL,
	[CombGENTotal] [float] NULL,
	[CombGENTotalSrc] [float] NULL,
	[CombOther] [float] NULL,
	[CombAdminOnly] [float] NULL,
	[AAPTotalRX] [money] NULL,
	[AAPExcludedFromTotalRX] [money] NULL,
	[AAPNonRXOTCandHH] [money] NULL,
	[AAPSourceCompliance] [decimal](18, 4) NULL,
	[COGEligibleSales] [money] NULL,
	[NonContractGenericSales] [money] NULL,
	[NetSourceGenerics] [money] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CH_ALLPVA_SALES] ADD  DEFAULT ((0.00)) FOR [NetSourceGenerics]
GO
