USE [AdventureWorksDW2012]
GO
/****** Object:  Table [dbo].[AdventureWorksDWBuildVersion]    Script Date: 12/22/2020 6:01:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AdventureWorksDWBuildVersion](
	[DBVersion] [nvarchar](50) NULL,
	[VersionDate] [datetime] NULL
) ON [PRIMARY]
GO
