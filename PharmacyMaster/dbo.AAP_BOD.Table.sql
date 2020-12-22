USE [PharmacyMaster]
GO
/****** Object:  Table [dbo].[AAP_BOD]    Script Date: 12/22/2020 7:35:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AAP_BOD](
	[Name] [nvarchar](255) NULL,
	[Title] [nvarchar](255) NULL,
	[Phone] [nvarchar](255) NULL,
	[Email] [nvarchar](255) NULL,
	[PMID] [int] NULL
) ON [PRIMARY]
GO
