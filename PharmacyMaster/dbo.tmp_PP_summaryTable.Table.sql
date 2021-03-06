USE [PharmacyMaster]
GO
/****** Object:  Table [dbo].[tmp_PP_summaryTable]    Script Date: 12/22/2020 7:35:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmp_PP_summaryTable](
	[AAPAccountNo] [nvarchar](6) NULL,
	[aapparentno] [nvarchar](255) NULL,
	[AccountName] [nvarchar](255) NULL,
	[Address] [nvarchar](255) NULL,
	[Address2] [nvarchar](255) NULL,
	[City] [nvarchar](255) NULL,
	[State] [nvarchar](255) NULL,
	[Zip] [nvarchar](12) NULL,
	[PMID] [nvarchar](7) NULL,
	[volumeamt] [nvarchar](50) NULL,
	[rebateamt] [nvarchar](50) NULL,
	[paymentamt] [nvarchar](50) NULL,
	[NCPDP] [nvarchar](10) NULL,
	[AAPQuitDate] [nvarchar](50) NULL,
	[Affiliate] [nvarchar](50) NULL,
	[eligible] [nvarchar](50) NULL,
	[Payto] [nvarchar](50) NULL,
	[ChangeofOwner] [nvarchar](50) NULL
) ON [PRIMARY]
GO
