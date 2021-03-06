USE [WebDev]
GO
/****** Object:  Table [dbo].[MACFileWeb]    Script Date: 12/22/2020 8:08:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MACFileWeb](
	[Client_Name] [varchar](10) NULL,
	[MAC_ID] [varchar](10) NULL,
	[GPI] [varchar](14) NULL,
	[GPPC] [varchar](8) NULL,
	[NDCMFG] [varchar](5) NULL,
	[NDCPDT] [varchar](4) NULL,
	[NDCPKG] [varchar](2) NULL,
	[STATUS] [varchar](1) NULL,
	[MACFROMDATE] [varchar](7) NULL,
	[MACTHRUDATE] [varchar](7) NULL,
	[UNITCOST] [varchar](13) NULL
) ON [PRIMARY]
GO
