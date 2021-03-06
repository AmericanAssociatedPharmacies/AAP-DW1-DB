USE [PharmacyMaster]
GO
/****** Object:  Table [dbo].[tmp_ALLPVA_SLX]    Script Date: 12/22/2020 7:35:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmp_ALLPVA_SLX](
	[pmid] [int] NOT NULL,
	[accountname] [varchar](65) NULL,
	[dea] [varchar](50) NULL,
	[apiaccountno] [varchar](20) NULL,
	[m1] [float] NULL,
	[m2] [float] NULL,
	[m3] [float] NULL,
	[mo3Avg] [numeric](38, 2) NULL,
	[Anda1] [numeric](38, 2) NULL,
	[Anda2] [numeric](38, 2) NULL,
	[Anda3] [numeric](38, 2) NULL,
	[AndaTotal] [numeric](38, 2) NULL,
	[WHM1] [numeric](38, 2) NULL,
	[WHM2] [numeric](38, 2) NULL,
	[WHM3] [numeric](38, 2) NULL,
	[whPVAAvg3mo] [numeric](38, 2) NULL
) ON [PRIMARY]
GO
