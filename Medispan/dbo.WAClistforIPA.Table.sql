USE [Medispan]
GO
/****** Object:  Table [dbo].[WAClistforIPA]    Script Date: 12/22/2020 7:12:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WAClistforIPA](
	[Drug Name ] [nvarchar](150) NULL,
	[Strength] [nvarchar](50) NULL,
	[Size] [nvarchar](50) NULL,
	[Form] [nvarchar](50) NULL,
	[CAH Price] [nvarchar](50) NULL,
	[WAC] [nvarchar](50) NULL,
	[WAC disc] [nvarchar](50) NULL,
	[NDC] [nvarchar](50) NULL,
	[Net Bill list] [nvarchar](50) NULL,
	[Notes] [nvarchar](50) NULL,
	[Column 10] [nvarchar](50) NULL
) ON [PRIMARY]
GO
