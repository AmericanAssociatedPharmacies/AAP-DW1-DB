USE [ODSIntake]
GO
/****** Object:  Table [dbo].[SPXList]    Script Date: 12/22/2020 7:30:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SPXList](
	[NDC_CDE] [nvarchar](11) NULL,
	[CORP_ITEM_NUM] [float] NULL,
	[CORP_DESC] [nvarchar](255) NULL,
	[THERAPY_CLASS] [nvarchar](255) NULL,
	[GEN_NAM] [nvarchar](255) NULL,
	[TRADE_NAME] [nvarchar](255) NULL,
	[CARD_AHFS_ID] [nvarchar](255) NULL,
	[AHFS_DESC] [nvarchar](255) NULL
) ON [PRIMARY]
GO
