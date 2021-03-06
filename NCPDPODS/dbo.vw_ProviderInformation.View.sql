USE [NCPDPODS]
GO
/****** Object:  View [dbo].[vw_ProviderInformation]    Script Date: 12/22/2020 7:25:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vw_ProviderInformation]

AS


SELECT ProviderInformationKey, NCPDPProviderID, LegalBusinessName, Name, DoctorsName, StoreNumber
, PhysicalLocationAddress1, PhysicalLocationAddress2, PhysicalLocationCity, PhysicalLocationStateCode
, PhysicalLocationZipCode, PhysicalLocationPhoneNumber, PhysicalLocationExtension, PhysicalLocationFAX
, PhysicalLocationEmailAddress, PhysicalLocationCrossStreetorDirections, PhysicalLocationCountyParish
, PhysicalLocationMSA, PhysicalLocationPMSA, PhysicalLocation24HourOperatingFlag, PhysicalLocationProviderHours
, PhysicalLocationCongressionalVotingDistrict, PhysicalLocationLanguageCode1, PhysicalLocationLanguageCode2
, PhysicalLocationLanguageCode3, PhysicalLocationLanguageCode4, PhysicalLocationLanguageCode5
, CONVERT(DATE, CASE	
			WHEN PhysicalLocationStoreOpenDate = '00000000' THEN '29991231'
			ELSE RIGHT(PhysicalLocationStoreOpenDate, 4) + LEFT(PhysicalLocationStoreOpenDate, 2) +  SUBSTRING(PhysicalLocationStoreOpenDate,3,2)
			END
			) AS PhysicalLocationStoreOpenDate
, CONVERT(DATE, CASE	
			WHEN PhysicalLocationStoreClosureDate = '00000000' THEN '29991231'
			ELSE RIGHT(PhysicalLocationStoreClosureDate, 4) + LEFT(PhysicalLocationStoreClosureDate, 2) +  SUBSTRING(PhysicalLocationStoreClosureDate,3,2)
			END
			) AS PhysicalLocationStoreClosureDate
, MailingAddress1, MailingAddress2
, MailingAddressCity, MailingAddressStateCode, MailingAddressZIPCode, ContactLastName, ContactFirstName
, ContactMiddleInitial, ContactTitle, ContactPhoneNumber, ContactExtension, ContactEmailAddress, DispenserClassCode
, PrimaryProviderTypeCode, SecondaryProviderTypeCode, TertiaryProviderTypeCode, MedicareProviderSupplierId
, NationalProviderIDNPI AS NPI, DEARegistrationID
, CONVERT(DATE, CASE	
			WHEN DEAExpirationDate = '00000000' THEN '29991231'
			ELSE RIGHT(DEAExpirationDate, 4) + LEFT(DEAExpirationDate, 2) +  SUBSTRING(DEAExpirationDate,3,2)
			END
			) AS DEAExpirationDate
, FedralTaxIDNumber, StateIncomeTaxIDNumber, DeactivationCode
, ReinstatementCode, ReinstatementDate, TransactionCode
, CONVERT(DATE, CASE	
			WHEN TransactionDate = '00000000' THEN '29991231'
			ELSE RIGHT(TransactionDate, 4) + LEFT(TransactionDate, 2) +  SUBSTRING(TransactionDate,3,2)
			END
			) AS TransactionDate
, RowCreatedDate
FROM [dbo].[ProviderInformation]
GO
