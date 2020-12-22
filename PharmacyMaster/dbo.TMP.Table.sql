USE [PharmacyMaster]
GO
/****** Object:  Table [dbo].[TMP]    Script Date: 12/22/2020 7:35:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TMP](
	[PMID] [int] IDENTITY(100000,1) NOT NULL,
	[dea] [varchar](50) NULL,
	[CHECKDIGIT] [varchar](1) NULL,
	[CALCDIGIT] [int] NULL
) ON [PRIMARY]
GO
