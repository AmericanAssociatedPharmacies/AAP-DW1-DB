USE [PharmacyMaster]
GO
/****** Object:  Table [dbo].[AplicorPMIDMapping]    Script Date: 12/22/2020 7:35:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AplicorPMIDMapping](
	[Account Name] [nvarchar](255) NULL,
	[Account Code] [nvarchar](50) NULL,
	[SL Account No ] [nvarchar](50) NULL,
	[PMID] [nvarchar](50) NULL
) ON [PRIMARY]
GO
