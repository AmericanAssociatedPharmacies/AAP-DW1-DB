USE [PharmacyMaster]
GO
/****** Object:  Table [dbo].[Equipp_Affiliates]    Script Date: 12/22/2020 7:35:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Equipp_Affiliates](
	[Name] [nvarchar](255) NULL,
	[Affiliation] [nvarchar](255) NULL,
	[Title] [nvarchar](255) NULL,
	[Email] [nvarchar](255) NULL,
	[Address] [nvarchar](max) NULL,
	[Phone Number] [nvarchar](255) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
