USE [PharmacyMaster]
GO
/****** Object:  Table [dbo].[NCPDP_ePrescribingInformation]    Script Date: 12/22/2020 7:35:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NCPDP_ePrescribingInformation](
	[NCPDP Provider ID] [nvarchar](7) NULL,
	[ePrescribing Network Identifier] [nvarchar](3) NULL,
	[ePrescribing Service Level Codes] [nvarchar](100) NULL,
	[Effective From Date] [nvarchar](8) NULL,
	[Effective Through Date] [nvarchar](8) NULL,
	[Filler] [nvarchar](24) NULL,
	[LoadDate] [datetime] NULL
) ON [PRIMARY]
GO
