USE [PharmacyMaster]
GO
/****** Object:  Table [dbo].[tmp_jeff_MLRebates2]    Script Date: 12/22/2020 7:35:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmp_jeff_MLRebates2](
	[fee] [numeric](38, 2) NULL,
	[pmid] [int] NOT NULL,
	[acct_no] [varchar](8) NULL
) ON [PRIMARY]
GO
