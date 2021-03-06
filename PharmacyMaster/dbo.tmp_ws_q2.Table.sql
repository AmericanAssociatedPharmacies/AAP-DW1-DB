USE [PharmacyMaster]
GO
/****** Object:  Table [dbo].[tmp_ws_q2]    Script Date: 12/22/2020 7:35:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmp_ws_q2](
	[PMID] [int] NULL,
	[TM #] [varchar](4) NULL,
	[AAP#] [varchar](20) NULL,
	[AAP Parent #] [varchar](20) NULL,
	[API #] [varchar](32) NOT NULL,
	[AccountName] [varchar](65) NULL,
	[City] [varchar](50) NULL,
	[ST] [varchar](2) NULL,
	[Date Opened] [datetime] NULL,
	[Apr Brand] [numeric](18, 2) NULL,
	[Apr Generic] [numeric](18, 2) NULL,
	[Apr OTC] [numeric](18, 2) NULL,
	[Apr Total] [numeric](20, 2) NULL,
	[May Brand] [numeric](18, 2) NULL,
	[May Generic] [numeric](18, 2) NULL,
	[May OTC] [numeric](18, 2) NULL,
	[May Total] [numeric](20, 2) NULL,
	[Jun Brand] [numeric](18, 2) NULL,
	[Jun Generic] [numeric](18, 2) NULL,
	[Jun OTC] [numeric](18, 2) NULL,
	[Jun Total] [numeric](20, 2) NULL,
	[Grand Total Brand] [numeric](20, 2) NULL,
	[Grand Total Generic] [numeric](20, 2) NULL,
	[Grand Total OTC] [numeric](20, 2) NULL,
	[Grand Total Sales] [numeric](26, 2) NULL
) ON [PRIMARY]
GO
