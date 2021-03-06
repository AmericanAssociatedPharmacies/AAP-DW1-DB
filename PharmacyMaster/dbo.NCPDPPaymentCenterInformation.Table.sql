USE [PharmacyMaster]
GO
/****** Object:  Table [dbo].[NCPDPPaymentCenterInformation]    Script Date: 12/22/2020 7:35:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NCPDPPaymentCenterInformation](
	[Payment Center ID] [nvarchar](6) NULL,
	[Payment Center Name] [nvarchar](35) NULL,
	[Payment Center Address 1] [nvarchar](55) NULL,
	[Payment Center Address 2] [nvarchar](55) NULL,
	[Payment Center City] [nvarchar](30) NULL,
	[Payment Center State Code] [nvarchar](2) NULL,
	[Payment Center Zip Code] [nvarchar](9) NULL,
	[Payment Center Phone Number] [nvarchar](10) NULL,
	[Payment Center Extension] [nvarchar](5) NULL,
	[Payment Center FAX Number] [nvarchar](10) NULL,
	[Payment Center NPI] [nvarchar](10) NULL,
	[Payment Center Federal Tax ID] [nvarchar](15) NULL,
	[Payment Center  Name] [nvarchar](30) NULL,
	[Payment Center  Title] [nvarchar](30) NULL,
	[Payment Center  E-mail Address] [nvarchar](50) NULL,
	[Delete Date] [nvarchar](8) NULL,
	[Filler] [nvarchar](140) NULL
) ON [PRIMARY]
GO
