USE [PharmacyMaster]
GO
/****** Object:  Table [dbo].[NCPDP_StateLicenseInformation]    Script Date: 12/22/2020 7:35:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NCPDP_StateLicenseInformation](
	[NCPDP Provider ID] [nvarchar](7) NULL,
	[License State Code] [nvarchar](2) NULL,
	[State License Number] [nvarchar](20) NULL,
	[State License Expiration Date] [nvarchar](8) NULL,
	[Delete Date] [nvarchar](8) NULL,
	[Filler] [nvarchar](140) NULL,
	[LoadDate] [datetime] NULL
) ON [PRIMARY]
GO
