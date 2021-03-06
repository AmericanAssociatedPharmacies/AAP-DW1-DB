USE [PharmacyMaster]
GO
/****** Object:  Table [dbo].[NCPDPServicesInformation]    Script Date: 12/22/2020 7:35:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NCPDPServicesInformation](
	[NCPDP Provider ID] [nvarchar](7) NULL,
	[Accepts ePrescriptions Indicator] [nvarchar](1) NULL,
	[Accepts ePrescriptions Code] [nvarchar](2) NULL,
	[Delivery Service Indicator] [nvarchar](1) NULL,
	[Delivery Service Code] [nvarchar](2) NULL,
	[Compounding Service Indicator] [nvarchar](1) NULL,
	[Compounding Service Code] [nvarchar](2) NULL,
	[Drive-Up Window Indicator] [nvarchar](1) NULL,
	[Drive-Up Window Code] [nvarchar](2) NULL,
	[DME Indicator] [nvarchar](1) NULL,
	[DME Code] [nvarchar](2) NULL,
	[Walk-In Clinic Indicator] [nvarchar](1) NULL,
	[Walk-In Clinic Code] [nvarchar](2) NULL,
	[24-Hour Emergency Indicator] [nvarchar](1) NULL,
	[24-Hour Emergency Code] [nvarchar](2) NULL,
	[Multi-Dose Compliance Packaging Indicator] [nvarchar](1) NULL,
	[Multi-Dose Compliance Packaging Code] [nvarchar](2) NULL,
	[Immunizations Provided Indicator] [nvarchar](1) NULL,
	[Immunizations Provided Code] [nvarchar](2) NULL,
	[Handicapped Accessible Indicator] [nvarchar](1) NULL,
	[Handicapped Accessible Code] [nvarchar](2) NULL,
	[340B Status Indicator] [nvarchar](1) NULL,
	[340B Status Code] [nvarchar](2) NULL,
	[Closed Door Facility Indicator] [nvarchar](1) NULL,
	[Closed Door Facility Code] [nvarchar](2) NULL,
	[Filler] [nvarchar](107) NULL
) ON [PRIMARY]
GO
