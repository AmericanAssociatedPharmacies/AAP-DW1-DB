USE [PharmacyMaster]
GO
/****** Object:  Table [dbo].[PM_Modifications]    Script Date: 12/22/2020 7:35:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PM_Modifications](
	[PMID] [int] NOT NULL,
	[ModDate] [datetime] NOT NULL,
	[ModType] [varchar](10) NULL,
	[Reason] [varchar](100) NULL,
	[Created] [datetime] NOT NULL,
	[Modified] [datetime] NOT NULL,
	[RowVersion] [int] NOT NULL
) ON [PRIMARY]
GO
