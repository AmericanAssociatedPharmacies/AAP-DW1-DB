USE [WebDev]
GO
/****** Object:  Table [dbo].[CVSMissingInfoAll]    Script Date: 12/22/2020 8:08:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CVSMissingInfoAll](
	[pmid] [int] NULL,
	[Note] [varchar](120) NOT NULL,
	[Section] [varchar](8) NOT NULL
) ON [PRIMARY]
GO
