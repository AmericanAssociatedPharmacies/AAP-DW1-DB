USE [PharmacyMaster]
GO
/****** Object:  Table [dbo].[States]    Script Date: 12/22/2020 7:35:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[States](
	[STATECODE] [varchar](2) NOT NULL,
	[STATENAME] [varchar](40) NULL
) ON [PRIMARY]
GO
