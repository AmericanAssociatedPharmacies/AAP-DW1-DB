USE [PharmacyMaster]
GO
/****** Object:  Table [dbo].[webpartners]    Script Date: 12/22/2020 7:35:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[webpartners](
	[PARTNER_ID] [int] NULL,
	[PARTNER_CATEGORY_ID] [int] NULL,
	[PARTNER_LEVEL_ID] [int] NULL,
	[NAME] [varchar](255) NULL,
	[DESCRIPTION] [varchar](max) NULL,
	[URI] [varchar](512) NULL,
	[PHONE_NUM] [varchar](18) NULL,
	[BANNER_FROM_DT] [datetime] NULL,
	[BANNER_TO_DT] [datetime] NULL,
	[BANNER_DISPLAYED] [int] NULL,
	[BANNER_HIT] [int] NULL,
	[NAME_PUBLIC] [varchar](50) NULL,
	[LOGO] [varchar](50) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
