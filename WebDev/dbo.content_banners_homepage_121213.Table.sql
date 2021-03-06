USE [WebDev]
GO
/****** Object:  Table [dbo].[content_banners_homepage_121213]    Script Date: 12/22/2020 8:08:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[content_banners_homepage_121213](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[imageURL] [varchar](255) NOT NULL,
	[linkURL] [varchar](255) NOT NULL,
	[description] [varchar](255) NOT NULL,
	[externalLink] [tinyint] NULL,
	[dateAdded] [datetime] NULL,
	[dateExpires] [datetime] NULL,
	[sortorder] [int] NULL,
	[dateStartDisplay] [datetime] NULL
) ON [PRIMARY]
GO
