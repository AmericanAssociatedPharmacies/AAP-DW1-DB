USE [PharmacyMaster]
GO
/****** Object:  Table [dbo].[tmp_PP_Affiliate]    Script Date: 12/22/2020 7:35:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmp_PP_Affiliate](
	[PMID] [int] NOT NULL,
	[VendorName] [varchar](150) NULL,
	[AccountName] [varchar](65) NULL,
	[Addr1] [varchar](100) NULL,
	[Addr2] [varchar](100) NULL,
	[City] [varchar](50) NULL,
	[State] [varchar](2) NULL,
	[Zip] [varchar](50) NULL,
	[Payment Amount] [numeric](38, 3) NULL,
	[NCPDP] [varchar](20) NULL
) ON [PRIMARY]
GO
