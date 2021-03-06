USE [PharmacyMaster]
GO
/****** Object:  Table [dbo].[NCPDP_ProviderRelationship]    Script Date: 12/22/2020 7:35:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NCPDP_ProviderRelationship](
	[NCPDP Provider ID] [nvarchar](7) NULL,
	[Relationship ID] [nvarchar](3) NULL,
	[Payment Center ID] [nvarchar](6) NULL,
	[Remit and Reconciliation ID] [nvarchar](6) NULL,
	[Provider Type] [nvarchar](2) NULL,
	[Is Primary] [nvarchar](1) NULL,
	[Effective From Date] [nvarchar](8) NULL,
	[Effective Through Date] [nvarchar](8) NULL,
	[Filler] [nvarchar](109) NULL,
	[LoadDate] [datetime] NULL
) ON [PRIMARY]
GO
