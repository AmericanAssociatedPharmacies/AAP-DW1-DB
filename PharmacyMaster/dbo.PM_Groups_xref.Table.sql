USE [PharmacyMaster]
GO
/****** Object:  Table [dbo].[PM_Groups_xref]    Script Date: 12/22/2020 7:35:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PM_Groups_xref](
	[Grpxref_ID] [int] NOT NULL,
	[PMID] [int] NOT NULL,
	[Group_ID] [int] NOT NULL,
	[Source] [varchar](5) NULL,
	[Created] [datetime] NOT NULL,
	[Modified] [datetime] NOT NULL,
	[RowVersion] [int] NOT NULL
) ON [PRIMARY]
GO
