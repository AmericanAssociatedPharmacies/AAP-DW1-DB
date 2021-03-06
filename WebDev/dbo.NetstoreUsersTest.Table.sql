USE [WebDev]
GO
/****** Object:  Table [dbo].[NetstoreUsersTest]    Script Date: 12/22/2020 8:08:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NetstoreUsersTest](
	[ClientID] [nvarchar](50) NULL,
	[Name] [nvarchar](50) NULL,
	[Password] [nvarchar](50) NULL,
	[Enabled] [nvarchar](50) NULL,
	[NABP] [nvarchar](50) NULL,
	[DEA#] [nvarchar](50) NULL,
	[PMID] [nvarchar](50) NULL
) ON [PRIMARY]
GO
