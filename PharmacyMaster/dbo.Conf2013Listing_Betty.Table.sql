USE [PharmacyMaster]
GO
/****** Object:  Table [dbo].[Conf2013Listing_Betty]    Script Date: 12/22/2020 7:35:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Conf2013Listing_Betty](
	[PMID] [int] NOT NULL,
	[Individual Authorized to Vote] [nvarchar](50) NULL,
	[Account DBA] [varchar](65) NULL,
	[AAP Effective Date] [datetime] NULL,
	[AAP Quit Date] [datetime] NULL,
	[AAP Store #] [varchar](20) NULL,
	[AAP Parent Store #] [varchar](20) NULL,
	[Mailing Address 1] [varchar](100) NULL,
	[Mailing Address 2] [varchar](100) NULL,
	[Mailing City] [varchar](50) NULL,
	[Mailing State] [varchar](2) NULL,
	[Mailing Zip] [varchar](50) NULL
) ON [PRIMARY]
GO
