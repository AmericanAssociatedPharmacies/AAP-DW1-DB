USE [PharmacyMaster]
GO
/****** Object:  Table [dbo].[tmp_deleteme]    Script Date: 12/22/2020 7:35:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmp_deleteme](
	[PMID] [int] NOT NULL,
	[AAPAccountNo] [varchar](20) NULL,
	[AAPQuitDate] [datetime] NULL,
	[AAPStatus] [varchar](32) NULL,
	[APIAccountNo] [varchar](20) NULL,
	[APIStatus] [varchar](32) NULL,
	[Accountname] [varchar](65) NULL,
	[City] [varchar](50) NULL,
	[State] [varchar](2) NULL,
	[API Generic Sales] [money] NULL,
	[ExtendedSales] [money] NULL,
	[AdjustedExtSales] [money] NULL,
	[API Month] [datetime] NULL,
	[CH Month] [datetime] NULL
) ON [PRIMARY]
GO
