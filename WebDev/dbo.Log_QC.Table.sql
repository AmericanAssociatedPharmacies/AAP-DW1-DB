USE [WebDev]
GO
/****** Object:  Table [dbo].[Log_QC]    Script Date: 12/22/2020 8:08:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Log_QC](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[tabname] [varchar](50) NULL,
	[login] [varchar](50) NULL,
	[PMID] [int] NULL,
	[date_accessed] [datetime] NULL,
	[userrole] [varchar](15) NULL,
	[IP] [varchar](25) NULL
) ON [PRIMARY]
GO
