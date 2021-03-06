USE [PharmacyMaster]
GO
/****** Object:  Table [dbo].[tmp_PPVendorVolume2Q2014]    Script Date: 12/22/2020 7:35:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmp_PPVendorVolume2Q2014](
	[PMID] [int] NULL,
	[VendorName] [varchar](150) NULL,
	[Affiliate] [nvarchar](50) NULL,
	[Eligibility] [int] NULL,
	[Volume] [numeric](38, 2) NULL,
	[Rebate Amount] [numeric](38, 2) NULL,
	[AccountName] [varchar](65) NULL,
	[AAPPaymentMode] [varchar](255) NULL
) ON [PRIMARY]
GO
