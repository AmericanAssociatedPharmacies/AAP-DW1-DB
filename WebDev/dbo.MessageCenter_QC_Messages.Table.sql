USE [WebDev]
GO
/****** Object:  Table [dbo].[MessageCenter_QC_Messages]    Script Date: 12/22/2020 8:08:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MessageCenter_QC_Messages](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[date_posted] [datetime] NULL,
	[date_expires] [datetime] NULL,
	[title] [varchar](255) NOT NULL,
	[link] [varchar](255) NOT NULL,
	[description] [varchar](max) NULL,
	[access_codes] [varchar](255) NULL,
	[PMIDs] [varchar](255) NULL,
	[query_ID] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
