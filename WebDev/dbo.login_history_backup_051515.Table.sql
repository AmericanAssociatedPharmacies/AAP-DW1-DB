USE [WebDev]
GO
/****** Object:  Table [dbo].[login_history_backup_051515]    Script Date: 12/22/2020 8:08:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[login_history_backup_051515](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[dt] [datetime] NOT NULL,
	[username] [varchar](255) NULL,
	[login_type] [varchar](25) NULL,
	[password] [varchar](255) NULL,
	[role] [varchar](50) NULL,
	[defaultpmid] [int] NULL,
	[ip] [varchar](20) NULL
) ON [PRIMARY]
GO
