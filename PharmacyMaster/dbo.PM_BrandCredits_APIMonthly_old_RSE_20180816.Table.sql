USE [PharmacyMaster]
GO
/****** Object:  Table [dbo].[PM_BrandCredits_APIMonthly_old_RSE_20180816]    Script Date: 12/22/2020 7:35:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PM_BrandCredits_APIMonthly_old_RSE_20180816](
	[Date] [varchar](10) NULL,
	[PMID] [varchar](50) NULL,
	[APIAccountNo] [varchar](255) NULL,
	[AccountName] [varchar](255) NULL,
	[BrandCredits] [money] NULL,
	[Territory] [varchar](255) NULL,
	[BrandSales] [money] NULL,
	[ACH] [bit] NULL,
	[PayTerms] [varchar](255) NULL
) ON [PRIMARY]
GO
