USE [PharmacyMaster]
GO
/****** Object:  Table [dbo].[NCPDPRelationshipDemographic]    Script Date: 12/22/2020 7:35:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NCPDPRelationshipDemographic](
	[Relationship ID] [nvarchar](3) NULL,
	[Relationship Type] [nvarchar](2) NULL,
	[Name] [nvarchar](35) NULL,
	[Address 1] [nvarchar](55) NULL,
	[Address 2] [nvarchar](55) NULL,
	[City] [nvarchar](30) NULL,
	[State Code] [nvarchar](2) NULL,
	[Zip Code] [nvarchar](9) NULL,
	[Phone Number] [nvarchar](10) NULL,
	[Extension] [nvarchar](5) NULL,
	[FAX Number] [nvarchar](10) NULL,
	[Contact Name] [nvarchar](30) NULL,
	[Contact Title] [nvarchar](30) NULL,
	[E-mail Address] [nvarchar](50) NULL,
	[Parent Organization ID] [nvarchar](6) NULL,
	[Delete Date] [nvarchar](8) NULL
) ON [PRIMARY]
GO
