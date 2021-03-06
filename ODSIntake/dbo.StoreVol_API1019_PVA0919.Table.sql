USE [ODSIntake]
GO
/****** Object:  Table [dbo].[StoreVol_API1019_PVA0919]    Script Date: 12/22/2020 7:30:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StoreVol_API1019_PVA0919](
	[F1] [nvarchar](255) NULL,
	[TM] [nvarchar](255) NULL,
	[PMID] [float] NULL,
	[AAP#] [nvarchar](255) NULL,
	[Parent#] [nvarchar](255) NULL,
	[Group#] [nvarchar](255) NULL,
	[API#] [nvarchar](255) NULL,
	[AAP Eff] [nvarchar](255) NULL,
	[AAP Quit] [nvarchar](255) NULL,
	[Description] [nvarchar](255) NULL,
	[Affiliate] [nvarchar](255) NULL,
	[ChainCode] [nvarchar](255) NULL,
	[Account DBA Name] [nvarchar](255) NULL,
	[Account Corporate Name] [nvarchar](255) NULL,
	[Software] [nvarchar](255) NULL,
	[Address] [nvarchar](255) NULL,
	[City] [nvarchar](255) NULL,
	[ST] [nvarchar](255) NULL,
	[Contact] [nvarchar](255) NULL,
	[Whse Acct Date Opened] [nvarchar](255) NULL,
	[Status] [nvarchar](255) NULL,
	[API Oct 19 Brand] [money] NULL,
	[API Oct 19 OTC] [money] NULL,
	[API Oct 19 Tier 1] [money] NULL,
	[API Oct 19 Tier 2] [money] NULL,
	[API Oct 19 Total Whse] [money] NULL
) ON [PRIMARY]
GO
