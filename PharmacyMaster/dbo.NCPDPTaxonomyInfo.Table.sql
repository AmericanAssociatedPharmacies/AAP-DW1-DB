USE [PharmacyMaster]
GO
/****** Object:  Table [dbo].[NCPDPTaxonomyInfo]    Script Date: 12/22/2020 7:35:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NCPDPTaxonomyInfo](
	[NCPDP] [nvarchar](7) NULL,
	[Taxonomy Code] [nvarchar](10) NULL,
	[Dispenser Type Code] [nvarchar](2) NULL,
	[Delete Date] [nvarchar](8) NULL
) ON [PRIMARY]
GO
