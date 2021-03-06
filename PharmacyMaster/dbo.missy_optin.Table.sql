USE [PharmacyMaster]
GO
/****** Object:  Table [dbo].[missy_optin]    Script Date: 12/22/2020 7:35:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[missy_optin](
	[PMID] [float] NULL,
	[AAPAccountNo] [nvarchar](255) NULL,
	[NCPDP] [nvarchar](255) NULL,
	[AccountName] [nvarchar](255) NULL,
	[State] [nvarchar](255) NULL,
	[MCNews_EmailAddress] [nvarchar](255) NULL,
	[ContactFullName] [nvarchar](255) NULL
) ON [PRIMARY]
GO
