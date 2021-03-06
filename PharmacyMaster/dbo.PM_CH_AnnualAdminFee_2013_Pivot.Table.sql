USE [PharmacyMaster]
GO
/****** Object:  Table [dbo].[PM_CH_AnnualAdminFee_2013_Pivot]    Script Date: 12/22/2020 7:35:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PM_CH_AnnualAdminFee_2013_Pivot](
	[PMID] [varchar](255) NULL,
	[AccountNo] [varchar](255) NULL,
	[AccountName] [varchar](255) NULL,
	[Jan] [money] NULL,
	[Feb] [money] NULL,
	[Mar] [money] NULL,
	[Apr] [money] NULL,
	[May] [money] NULL,
	[Jun] [money] NULL,
	[Jul] [money] NULL,
	[Aug] [money] NULL,
	[Sep] [money] NULL,
	[Oct] [money] NULL,
	[Nov] [money] NULL,
	[Dec] [money] NULL,
	[ExtSalesTotal] [money] NULL,
	[AnnualAdminFee] [money] NULL
) ON [PRIMARY]
GO
