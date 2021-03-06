USE [NCPDPODS]
GO
/****** Object:  View [Staging].[vw_NCPDP_ProviderInformation]    Script Date: 12/22/2020 7:25:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [Staging].[vw_NCPDP_ProviderInformation]

AS

SELECT SUBSTRING(C1,1,7) AS NCPDPProviderID
	, SUBSTRING(C1,8,60) AS LegalBusinessName
	, NULLIF(SUBSTRING(C1,68,60), '') AS Name
	, NULLIF(SUBSTRING(C1,128,60), '') AS DoctorsName
	, NULLIF(SUBSTRING(C1,188,10), '') AS StoreNumber
	, NULLIF(SUBSTRING(C1,198,55), '') AS PhysicalLocationAddress1
	, NULLIF(SUBSTRING(C1,253,55), '') AS PhysicalLocationAddress2
	, NULLIF(SUBSTRING(C1,308,30), '') AS PhysicalLocationCity
	, NULLIF(SUBSTRING(C1,338,2), '') AS PhysicalLocationStateCode
	, NULLIF(SUBSTRING(C1,340,9), '') AS PhysicalLocationZipCode
	, NULLIF(SUBSTRING(C1,349,10), '') AS PhysicalLocationPhoneNumber
	, NULLIF(SUBSTRING(C1,359,5), '') AS PhysicalLocationExtension
	, NULLIF(SUBSTRING(C1,364,10), '') AS PhysicalLocationFAX
	, NULLIF(SUBSTRING(C1,374,50), '') AS PhysicalLocationEmailAddress 
	, NULLIF(SUBSTRING(C1,424,50), '') AS PhysicalLocationCrossStreetorDirections
	, NULLIF(SUBSTRING(C1,474,5), '') AS PhysicalLocationCountyParish
	, NULLIF(SUBSTRING(C1,479,4), '') AS PhysicalLocationMSA
	, NULLIF(SUBSTRING(C1,483,4), '') AS PhysicalLocationPMSA
	, NULLIF(SUBSTRING(C1,487,1), '') AS PhysicalLocation24HourOperatingFlag
	, NULLIF(SUBSTRING(C1,488,35), '') AS PhysicalLocationProviderHours
	, NULLIF(SUBSTRING(C1,523,4), '') AS PhysicalLocationCongressionalVotingDistrict
	, NULLIF(SUBSTRING(C1,527,2), '') AS PhysicalLocationLanguageCode1
	, NULLIF(SUBSTRING(C1,529,2), '') AS PhysicalLocationLanguageCode2
	, NULLIF(SUBSTRING(C1,531,2), '') AS PhysicalLocationLanguageCode3
	, NULLIF(SUBSTRING(C1,533,2), '') AS PhysicalLocationLanguageCode4
	, NULLIF(SUBSTRING(C1,535,2), '') AS PhysicalLocationLanguageCode5
	, NULLIF(SUBSTRING(C1,537,8), '') AS PhysicalLocationStoreOpenDate
	, NULLIF(SUBSTRING(C1,545,8), '') AS PhysicalLocationStoreClosureDate
	, NULLIF(SUBSTRING(C1,553,55), '') AS MailingAddress1
	, NULLIF(SUBSTRING(C1,608,55), '') AS MailingAddress2
	, NULLIF(SUBSTRING(C1,663,30), '') AS MailingAddressCity
	, NULLIF(SUBSTRING(C1,693,2), '') AS MailingAddressStateCode
	, NULLIF(SUBSTRING(C1,695,9), '') AS MailingAddressZIPCode
	, NULLIF(SUBSTRING(C1,704,20), '') AS ContactLastName 
	, NULLIF(SUBSTRING(C1,724,20), '') AS ContactFirstName 
	, NULLIF(SUBSTRING(C1,744,1), '') AS ContactMiddleInitial 
	, NULLIF(SUBSTRING(C1,745,30), '') AS ContactTitle 
	, NULLIF(SUBSTRING(C1,775,10), '') AS ContactPhoneNumber
	, NULLIF(SUBSTRING(C1,785,5), '') AS ContactExtension
	, NULLIF(SUBSTRING(C1,790,50), '') AS ContactEmailAddress
	, NULLIF(SUBSTRING(C1,840,2), '') AS DispenserClassCode 
	, NULLIF(SUBSTRING(C1,842,2), '') AS PrimaryProviderTypeCode
	, NULLIF(SUBSTRING(C1,844,2), '') AS SecondaryProviderTypeCode 
	, NULLIF(SUBSTRING(C1,846,2), '') AS TertiaryProviderTypeCode
	, NULLIF(SUBSTRING(C1,848,10), '') AS MedicareProviderSupplierId
	, NULLIF(SUBSTRING(C1,858,10), '') AS NationalProviderIDNPI 
	, NULLIF(SUBSTRING(C1,868,12), '') AS DEARegistrationID
	, NULLIF(SUBSTRING(C1,880,8), '') AS DEAExpirationDate
	, NULLIF(SUBSTRING(C1,888,15), '') AS FedralTaxIDNumber
	, NULLIF(SUBSTRING(C1,903,15), '') AS StateIncomeTaxIDNumber 
	, NULLIF(SUBSTRING(C1,918,2), '') AS DeactivationCode
	, NULLIF(SUBSTRING(C1,920,2), '') AS ReinstatementCode
	, NULLIF(SUBSTRING(C1,922,8), '') AS ReinstatementDate
	, NULLIF(SUBSTRING(C1,930,1), '') AS TransactionCode
	, NULLIF(SUBSTRING(C1,931,8), '') AS TransactionDate
FROM (SELECT MIN(RowID) AS MinRowID
	  , MAX(RowID) AS MaxRowID
	 FROM [ODSIntake].[Staging].[NCPDP_ProviderInformation]
	 ) AS dt
INNER JOIN [ODSIntake].[Staging].[NCPDP_ProviderInformation] AS s ON s.RowID > dt.MinRowID
													AND s.RowID < dt.MaxRowID

GO
