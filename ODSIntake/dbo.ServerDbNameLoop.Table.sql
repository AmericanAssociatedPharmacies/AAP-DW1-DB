USE [ODSIntake]
GO
/****** Object:  Table [dbo].[ServerDbNameLoop]    Script Date: 12/22/2020 7:30:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ServerDbNameLoop](
	[ServerName] [varchar](255) NULL,
	[DbName] [sysname] NOT NULL
) ON [PRIMARY]
GO
