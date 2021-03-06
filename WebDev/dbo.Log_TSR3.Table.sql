USE [WebDev]
GO
/****** Object:  Table [dbo].[Log_TSR3]    Script Date: 12/22/2020 8:08:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Log_TSR3](
	[login] [varchar](50) NULL,
	[PMID] [int] NULL,
	[dt_run] [datetime] NULL,
	[report] [varchar](50) NULL,
	[dt_start] [datetime] NULL,
	[dt_end] [datetime] NULL,
	[notes] [varchar](255) NULL,
	[isDemo] [varchar](5) NULL,
	[parameters] [varchar](255) NULL,
	[source] [varchar](50) NULL
) ON [PRIMARY]
GO
