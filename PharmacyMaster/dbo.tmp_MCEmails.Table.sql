USE [PharmacyMaster]
GO
/****** Object:  Table [dbo].[tmp_MCEmails]    Script Date: 12/22/2020 7:35:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmp_MCEmails](
	[NCPDP] [float] NULL,
	[PMID] [float] NULL,
	[Company Name] [nvarchar](255) NULL,
	[Contact Name] [nvarchar](255) NULL,
	[Contact Email] [nvarchar](255) NULL,
	[Address 1] [nvarchar](255) NULL,
	[City] [nvarchar](255) NULL,
	[State] [nvarchar](255) NULL,
	[Zip] [float] NULL,
	[Phone] [nvarchar](255) NULL,
	[Fax] [nvarchar](255) NULL,
	[NPI] [float] NULL
) ON [PRIMARY]
GO
