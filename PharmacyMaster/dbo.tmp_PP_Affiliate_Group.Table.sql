USE [PharmacyMaster]
GO
/****** Object:  Table [dbo].[tmp_PP_Affiliate_Group]    Script Date: 12/22/2020 7:35:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmp_PP_Affiliate_Group](
	[PMID] [int] NOT NULL,
	[Payment] [numeric](38, 3) NULL
) ON [PRIMARY]
GO
