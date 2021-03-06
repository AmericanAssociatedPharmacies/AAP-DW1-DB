USE [ODSIntake]
GO
/****** Object:  Table [dbo].[Db1Cleanup_LoadCHPH]    Script Date: 12/22/2020 7:30:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Db1Cleanup_LoadCHPH](
	[Application] [nvarchar](255) NULL,
	[Process] [nvarchar](255) NULL,
	[Excel Files Associated] [nvarchar](255) NULL,
	[Received From] [nvarchar](255) NULL,
	[File Location] [nvarchar](255) NULL,
	[Purpose] [nvarchar](255) NULL,
	[Database] [nvarchar](255) NULL,
	[Table/View/Stored/Procedure/Function] [nvarchar](255) NULL,
	[Name] [nvarchar](255) NULL,
	[Comments] [nvarchar](255) NULL
) ON [PRIMARY]
GO
