USE [PharmacyMaster]
GO
/****** Object:  Table [dbo].[tmp_Conf2013f]    Script Date: 12/22/2020 7:35:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmp_Conf2013f](
	[PMID] [varchar](50) NULL,
	[Date Rec] [datetime] NULL,
	[Rec via] [varchar](255) NULL,
	[Registrant type] [varchar](255) NULL,
	[AccountName] [varchar](255) NULL,
	[ContactName] [varchar](255) NULL,
	[AAPAccountNo] [varchar](255) NULL,
	[AAPorGroupNo] [varchar](255) NULL,
	[APIAcctNo] [varchar](255) NULL,
	[Address] [varchar](255) NULL,
	[City] [varchar](255) NULL,
	[St] [varchar](255) NULL,
	[Zip] [varchar](50) NULL,
	[Phone] [varchar](255) NULL,
	[Ext] [varchar](255) NULL,
	[Fax] [varchar](255) NULL,
	[Email] [varchar](255) NULL,
	[Phcy Reps] [numeric](18, 0) NULL,
	[Attending] [numeric](18, 0) NULL,
	[TM] [varchar](255) NULL,
	[TM#] [varchar](255) NULL
) ON [PRIMARY]
GO
