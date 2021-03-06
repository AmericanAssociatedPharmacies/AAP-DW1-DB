USE [PharmacyMaster]
GO
/****** Object:  Table [dbo].[tmp_Conf2013b]    Script Date: 12/22/2020 7:35:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmp_Conf2013b](
	[PMID] [int] NULL,
	[Date Rec] [datetime] NULL,
	[Rec via] [nvarchar](255) NULL,
	[AAP#] [nvarchar](255) NULL,
	[API#] [nvarchar](255) NULL,
	[Pharmacy or Company Name] [nvarchar](255) NULL,
	[Primary Contact Name] [nvarchar](255) NULL,
	[City] [nvarchar](255) NULL,
	[St] [nvarchar](255) NULL,
	[# Phcy Rep] [float] NULL,
	[# Attd] [float] NULL,
	[TM] [nvarchar](255) NULL,
	[TM#] [nvarchar](255) NULL
) ON [PRIMARY]
GO
