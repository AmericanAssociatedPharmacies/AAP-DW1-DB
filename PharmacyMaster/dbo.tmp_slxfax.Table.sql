USE [PharmacyMaster]
GO
/****** Object:  Table [dbo].[tmp_slxfax]    Script Date: 12/22/2020 7:35:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmp_slxfax](
	[PMID] [int] NOT NULL,
	[AccountName] [varchar](65) NULL,
	[Fax] [varchar](50) NULL
) ON [PRIMARY]
GO
