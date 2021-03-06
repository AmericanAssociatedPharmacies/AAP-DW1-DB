USE [PharmacyMaster]
GO
/****** Object:  Table [dbo].[tmp_globalreport_Q2]    Script Date: 12/22/2020 7:35:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmp_globalreport_Q2](
	[PMID] [int] NULL,
	[AAP #] [varchar](20) NULL,
	[Parent #] [varchar](20) NULL,
	[Account Name] [varchar](65) NULL,
	[City] [varchar](50) NULL,
	[St] [varchar](2) NULL,
	[TM] [varchar](4) NULL,
	[DEA] [varchar](50) NULL,
	[Affiliate] [varchar](125) NULL,
	[BC] [varchar](4) NULL,
	[Period] [varchar](20) NULL,
	[Gen Src] [float] NOT NULL,
	[Gen Exc] [float] NOT NULL,
	[Gen Total] [float] NOT NULL,
	[CH Br] [float] NOT NULL,
	[CH Oth] [float] NOT NULL,
	[UD No Category*] [float] NOT NULL,
	[CH Total] [float] NOT NULL,
	[API Gen] [numeric](38, 2) NOT NULL,
	[API Br] [numeric](38, 2) NOT NULL,
	[API OTC] [numeric](38, 2) NOT NULL,
	[API Total] [numeric](38, 2) NOT NULL,
	[ML Total] [numeric](38, 2) NOT NULL,
	[Anda Total] [numeric](38, 2) NOT NULL,
	[All Total] [float] NOT NULL
) ON [PRIMARY]
GO
