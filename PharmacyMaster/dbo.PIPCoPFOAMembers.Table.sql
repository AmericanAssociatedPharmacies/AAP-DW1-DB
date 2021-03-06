USE [PharmacyMaster]
GO
/****** Object:  Table [dbo].[PIPCoPFOAMembers]    Script Date: 12/22/2020 7:35:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PIPCoPFOAMembers](
	[PMID] [varchar](50) NULL,
	[Group] [varchar](50) NULL,
	[Parent] [varchar](255) NULL,
	[PIPCoNo] [varchar](50) NULL,
	[CardinalNo] [varchar](50) NULL,
	[AAPAccountNo] [varchar](50) NULL,
	[AccountName] [varchar](255) NULL,
	[Address] [varchar](255) NULL,
	[City] [varchar](255) NULL,
	[ST] [varchar](255) NULL,
	[Zip] [varchar](50) NULL
) ON [PRIMARY]
GO
