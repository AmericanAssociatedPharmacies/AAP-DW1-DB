USE [PharmacyMaster]
GO
/****** Object:  Table [dbo].[tmp_ConfCompare]    Script Date: 12/22/2020 7:35:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmp_ConfCompare](
	[PMID] [nvarchar](255) NULL,
	[Date Rec] [datetime] NULL,
	[Rec via] [nvarchar](255) NULL,
	[Registrant type] [nvarchar](255) NULL,
	[Pharmacy or Company Name] [nvarchar](255) NULL,
	[Primary Contact Name] [nvarchar](255) NULL,
	[Affiliate] [nvarchar](255) NULL,
	[AAP  Acct #] [nvarchar](255) NULL,
	[AAP Parent or Group#] [nvarchar](255) NULL,
	[API   Acct #] [nvarchar](255) NULL,
	[Address] [nvarchar](255) NULL,
	[City] [nvarchar](255) NULL,
	[St] [nvarchar](255) NULL,
	[Zip] [float] NULL,
	[Phone] [nvarchar](255) NULL,
	[Ext] [nvarchar](255) NULL,
	[Fax] [nvarchar](255) NULL,
	[Email] [nvarchar](255) NULL,
	[# Phcy Rep] [float] NULL,
	[# Attd] [float] NULL,
	[TM] [nvarchar](255) NULL,
	[TM#] [nvarchar](255) NULL
) ON [PRIMARY]
GO
