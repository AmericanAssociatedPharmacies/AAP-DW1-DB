USE [ODSIntake]
GO
/****** Object:  Table [dbo].[Account]    Script Date: 12/22/2020 7:30:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Account](
	[AccountID] [uniqueidentifier] NULL,
	[Name] [nvarchar](200) NULL
) ON [PRIMARY]
GO
