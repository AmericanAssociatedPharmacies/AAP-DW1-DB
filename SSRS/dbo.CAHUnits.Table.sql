USE [SSRS]
GO
/****** Object:  Table [dbo].[CAHUnits]    Script Date: 12/22/2020 8:05:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CAHUnits](
	[PMID] [int] NOT NULL,
	[Month] [int] NOT NULL,
	[Year] [int] NOT NULL,
	[Units] [int] NOT NULL
) ON [PRIMARY]
GO
