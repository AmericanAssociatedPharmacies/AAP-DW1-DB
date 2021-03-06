USE [NCPDPODS]
GO
/****** Object:  Table [dbo].[ProviderInformation]    Script Date: 12/22/2020 7:25:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProviderInformation](
	[ProviderInformationKey] [int] IDENTITY(1,1) NOT NULL,
	[NCPDPProviderID] [varchar](7) NULL,
	[LegalBusinessName] [varchar](60) NULL,
	[Name] [varchar](60) NULL,
	[DoctorsName] [varchar](60) NULL,
	[StoreNumber] [varchar](10) NULL,
	[PhysicalLocationAddress1] [varchar](55) NULL,
	[PhysicalLocationAddress2] [varchar](55) NULL,
	[PhysicalLocationCity] [varchar](30) NULL,
	[PhysicalLocationStateCode] [varchar](2) NULL,
	[PhysicalLocationZipCode] [varchar](9) NULL,
	[PhysicalLocationPhoneNumber] [varchar](10) NULL,
	[PhysicalLocationExtension] [varchar](5) NULL,
	[PhysicalLocationFAX] [varchar](10) NULL,
	[PhysicalLocationEmailAddress] [varchar](50) NULL,
	[PhysicalLocationCrossStreetorDirections] [varchar](50) NULL,
	[PhysicalLocationCountyParish] [varchar](5) NULL,
	[PhysicalLocationMSA] [varchar](4) NULL,
	[PhysicalLocationPMSA] [varchar](4) NULL,
	[PhysicalLocation24HourOperatingFlag] [varchar](1) NULL,
	[PhysicalLocationProviderHours] [varchar](35) NULL,
	[PhysicalLocationCongressionalVotingDistrict] [varchar](4) NULL,
	[PhysicalLocationLanguageCode1] [varchar](2) NULL,
	[PhysicalLocationLanguageCode2] [varchar](2) NULL,
	[PhysicalLocationLanguageCode3] [varchar](2) NULL,
	[PhysicalLocationLanguageCode4] [varchar](2) NULL,
	[PhysicalLocationLanguageCode5] [varchar](2) NULL,
	[PhysicalLocationStoreOpenDate] [varchar](8) NULL,
	[PhysicalLocationStoreClosureDate] [varchar](8) NULL,
	[MailingAddress1] [varchar](55) NULL,
	[MailingAddress2] [varchar](55) NULL,
	[MailingAddressCity] [varchar](30) NULL,
	[MailingAddressStateCode] [varchar](2) NULL,
	[MailingAddressZIPCode] [varchar](9) NULL,
	[ContactLastName] [varchar](20) NULL,
	[ContactFirstName] [varchar](20) NULL,
	[ContactMiddleInitial] [varchar](1) NULL,
	[ContactTitle] [varchar](30) NULL,
	[ContactPhoneNumber] [varchar](10) NULL,
	[ContactExtension] [varchar](5) NULL,
	[ContactEmailAddress] [varchar](50) NULL,
	[DispenserClassCode] [varchar](2) NULL,
	[PrimaryProviderTypeCode] [varchar](2) NULL,
	[SecondaryProviderTypeCode] [varchar](2) NULL,
	[TertiaryProviderTypeCode] [varchar](2) NULL,
	[MedicareProviderSupplierId] [varchar](10) NULL,
	[NationalProviderIDNPI] [varchar](10) NULL,
	[DEARegistrationID] [varchar](12) NULL,
	[DEAExpirationDate] [varchar](8) NULL,
	[FedralTaxIDNumber] [varchar](15) NULL,
	[StateIncomeTaxIDNumber] [varchar](15) NULL,
	[DeactivationCode] [varchar](2) NULL,
	[ReinstatementCode] [varchar](2) NULL,
	[ReinstatementDate] [varchar](8) NULL,
	[TransactionCode] [varchar](1) NULL,
	[TransactionDate] [varchar](8) NULL,
	[RowCreatedDate] [datetime] NOT NULL,
 CONSTRAINT [CPK_ProviderInformation] PRIMARY KEY CLUSTERED 
(
	[ProviderInformationKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ProviderInformation] ADD  DEFAULT (getdate()) FOR [RowCreatedDate]
GO
