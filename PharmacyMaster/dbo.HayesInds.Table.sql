USE [PharmacyMaster]
GO
/****** Object:  Table [dbo].[HayesInds]    Script Date: 12/22/2020 7:35:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HayesInds](
	[NAME] [nvarchar](200) NULL,
	[ADDRESS] [nvarchar](200) NULL,
	[MAIL] [nvarchar](200) NULL,
	[CITY] [nvarchar](50) NULL,
	[STATE] [nvarchar](50) NULL,
	[ZIP] [nvarchar](50) NULL,
	[PHONE] [nvarchar](50) NULL,
	[FAX] [nvarchar](50) NULL,
	[COUNTY] [nvarchar](50) NULL,
	[POP] [nvarchar](50) NULL,
	[CHAIN] [nvarchar](50) NULL,
	[CHQ] [nvarchar](50) NULL,
	[STORENUM] [nvarchar](50) NULL,
	[BRANCH] [nvarchar](50) NULL,
	[OTHER] [nvarchar](200) NULL,
	[FULLSTATE] [nvarchar](50) NULL
) ON [PRIMARY]
GO
