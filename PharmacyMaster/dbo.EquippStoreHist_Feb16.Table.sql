USE [PharmacyMaster]
GO
/****** Object:  Table [dbo].[EquippStoreHist_Feb16]    Script Date: 12/22/2020 7:35:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EquippStoreHist_Feb16](
	[StoreID] [int] NOT NULL,
	[StoreName] [varchar](65) NULL,
	[Grouping1] [varchar](200) NULL,
	[Grouping2] [int] NULL
) ON [PRIMARY]
GO
