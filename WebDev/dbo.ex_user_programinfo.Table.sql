USE [WebDev]
GO
/****** Object:  Table [dbo].[ex_user_programinfo]    Script Date: 12/22/2020 8:08:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ex_user_programinfo](
	[pmid] [int] NOT NULL,
	[programid] [int] NOT NULL,
	[description] [varchar](50) NULL,
	[isInProgram] [int] NOT NULL
) ON [PRIMARY]
GO
