USE [SSRS]
GO
/****** Object:  Table [dbo].[TerritoryManagers]    Script Date: 12/22/2020 8:05:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TerritoryManagers](
	[Territory] [int] NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Director] [nvarchar](50) NOT NULL
) ON [PRIMARY]
GO
