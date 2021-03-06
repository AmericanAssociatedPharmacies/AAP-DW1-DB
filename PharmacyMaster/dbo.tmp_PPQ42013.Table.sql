USE [PharmacyMaster]
GO
/****** Object:  Table [dbo].[tmp_PPQ42013]    Script Date: 12/22/2020 7:35:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmp_PPQ42013](
	[PMID] [nvarchar](255) NULL,
	[VendorName] [nvarchar](255) NULL,
	[AccountName] [nvarchar](255) NULL,
	[Addr1] [nvarchar](255) NULL,
	[Addr2] [nvarchar](255) NULL,
	[City] [nvarchar](255) NULL,
	[State] [nvarchar](255) NULL,
	[Zip] [nvarchar](255) NULL,
	[Payment Amount] [float] NULL,
	[NCPDP] [nvarchar](255) NULL
) ON [PRIMARY]
GO
