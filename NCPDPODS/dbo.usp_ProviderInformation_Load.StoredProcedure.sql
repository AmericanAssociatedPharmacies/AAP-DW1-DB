USE [NCPDPODS]
GO
/****** Object:  StoredProcedure [dbo].[usp_ProviderInformation_Load]    Script Date: 12/22/2020 7:25:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[usp_ProviderInformation_Load]

AS

SET NOCOUNT ON;

BEGIN

	MERGE [dbo].[ProviderInformation] AS T
	USING (SELECT [NCPDPProviderID], [LegalBusinessName], [Name], [DoctorsName], [StoreNumber], [PhysicalLocationAddress1], [PhysicalLocationAddress2], [PhysicalLocationCity], [PhysicalLocationStateCode]
				, [PhysicalLocationZipCode], [PhysicalLocationPhoneNumber], [PhysicalLocationExtension], [PhysicalLocationFAX], [PhysicalLocationEmailAddress], [PhysicalLocationCrossStreetorDirections]
				, [PhysicalLocationCountyParish], [PhysicalLocationMSA], [PhysicalLocationPMSA], [PhysicalLocation24HourOperatingFlag], [PhysicalLocationProviderHours]
				, [PhysicalLocationCongressionalVotingDistrict], [PhysicalLocationLanguageCode1], [PhysicalLocationLanguageCode2], [PhysicalLocationLanguageCode3], [PhysicalLocationLanguageCode4]
				, [PhysicalLocationLanguageCode5], [PhysicalLocationStoreOpenDate], [PhysicalLocationStoreClosureDate], [MailingAddress1], [MailingAddress2], [MailingAddressCity], [MailingAddressStateCode]
				, [MailingAddressZIPCode], [ContactLastName], [ContactFirstName], [ContactMiddleInitial], [ContactTitle], [ContactPhoneNumber], [ContactExtension], [ContactEmailAddress], [DispenserClassCode]
				, [PrimaryProviderTypeCode], [SecondaryProviderTypeCode], [TertiaryProviderTypeCode], [MedicareProviderSupplierId], [NationalProviderIDNPI], [DEARegistrationID], [DEAExpirationDate]
				, [FedralTaxIDNumber], [StateIncomeTaxIDNumber], [DeactivationCode], [ReinstatementCode], [ReinstatementDate], [TransactionCode], [TransactionDate]
		   FROM [Staging].[vw_NCPDP_ProviderInformation]) AS S
				([NCPDPProviderID], [LegalBusinessName], [Name], [DoctorsName], [StoreNumber], [PhysicalLocationAddress1], [PhysicalLocationAddress2], [PhysicalLocationCity], [PhysicalLocationStateCode]
				, [PhysicalLocationZipCode], [PhysicalLocationPhoneNumber], [PhysicalLocationExtension], [PhysicalLocationFAX], [PhysicalLocationEmailAddress], [PhysicalLocationCrossStreetorDirections]
				, [PhysicalLocationCountyParish], [PhysicalLocationMSA], [PhysicalLocationPMSA], [PhysicalLocation24HourOperatingFlag], [PhysicalLocationProviderHours]
				, [PhysicalLocationCongressionalVotingDistrict], [PhysicalLocationLanguageCode1], [PhysicalLocationLanguageCode2], [PhysicalLocationLanguageCode3], [PhysicalLocationLanguageCode4]
				, [PhysicalLocationLanguageCode5], [PhysicalLocationStoreOpenDate], [PhysicalLocationStoreClosureDate], [MailingAddress1], [MailingAddress2], [MailingAddressCity], [MailingAddressStateCode]
				, [MailingAddressZIPCode], [ContactLastName], [ContactFirstName], [ContactMiddleInitial], [ContactTitle], [ContactPhoneNumber], [ContactExtension], [ContactEmailAddress], [DispenserClassCode]
				, [PrimaryProviderTypeCode], [SecondaryProviderTypeCode], [TertiaryProviderTypeCode], [MedicareProviderSupplierId], [NationalProviderIDNPI], [DEARegistrationID], [DEAExpirationDate]
				, [FedralTaxIDNumber], [StateIncomeTaxIDNumber], [DeactivationCode], [ReinstatementCode], [ReinstatementDate], [TransactionCode], [TransactionDate])
		  ON T.[NCPDPProviderID] = S.[NCPDPProviderID]

WHEN MATCHED THEN

UPDATE SET   [LegalBusinessName] = S.[LegalBusinessName]
		   , [Name] = S.[Name]
		   , [DoctorsName] = S.[DoctorsName]
		   , [StoreNumber] = S.[StoreNumber]
		   , [PhysicalLocationAddress1] = S.[PhysicalLocationAddress1]
		   , [PhysicalLocationAddress2] = S.[PhysicalLocationAddress2]
		   , [PhysicalLocationCity] = S.[PhysicalLocationCity]
		   , [PhysicalLocationStateCode] = S.[PhysicalLocationStateCode]
		   , [PhysicalLocationZipCode] = S.[PhysicalLocationZipCode]
		   , [PhysicalLocationPhoneNumber] = S.[PhysicalLocationPhoneNumber]
		   , [PhysicalLocationExtension] = S.[PhysicalLocationExtension]
		   , [PhysicalLocationFAX] = S.[PhysicalLocationFAX]
		   , [PhysicalLocationEmailAddress] = S.[PhysicalLocationEmailAddress]
		   , [PhysicalLocationCrossStreetorDirections] = S.[PhysicalLocationCrossStreetorDirections]
		   , [PhysicalLocationCountyParish] = S.[PhysicalLocationCountyParish]
		   , [PhysicalLocationMSA] = S.[PhysicalLocationMSA]
		   , [PhysicalLocationPMSA] = S.[PhysicalLocationPMSA]
		   , [PhysicalLocation24HourOperatingFlag] = S.[PhysicalLocation24HourOperatingFlag]
		   , [PhysicalLocationProviderHours] = S.[PhysicalLocationProviderHours]
		   , [PhysicalLocationCongressionalVotingDistrict] = S.[PhysicalLocationCongressionalVotingDistrict]
		   , [PhysicalLocationLanguageCode1] = S.[PhysicalLocationLanguageCode1]
		   , [PhysicalLocationLanguageCode2] = S.[PhysicalLocationLanguageCode2]
		   , [PhysicalLocationLanguageCode3] = S.[PhysicalLocationLanguageCode3]
		   , [PhysicalLocationLanguageCode4] = S.[PhysicalLocationLanguageCode4]
		   , [PhysicalLocationLanguageCode5] = S.[PhysicalLocationLanguageCode5]
		   , [PhysicalLocationStoreOpenDate] = S.[PhysicalLocationStoreOpenDate]
		   , [PhysicalLocationStoreClosureDate] = S.[PhysicalLocationStoreClosureDate]
		   , [MailingAddress1] = S.[MailingAddress1]
		   , [MailingAddress2] = S.[MailingAddress2]
		   , [MailingAddressCity] = S.[MailingAddressCity]
		   , [MailingAddressStateCode] = S.[MailingAddressStateCode]
		   , [MailingAddressZIPCode] = S.[MailingAddressZIPCode]
		   , [ContactLastName] = S.[ContactLastName]
		   , [ContactFirstName] = S.[ContactFirstName]
		   , [ContactMiddleInitial] = S.[ContactMiddleInitial]
		   , [ContactTitle] = S.[ContactTitle]
		   , [ContactPhoneNumber] = S.[ContactPhoneNumber]
		   , [ContactExtension] = S.[ContactExtension]
		   , [ContactEmailAddress] = S.[ContactEmailAddress]
		   , [DispenserClassCode] = S.[DispenserClassCode]
		   , [PrimaryProviderTypeCode] = S.[PrimaryProviderTypeCode]
		   , [SecondaryProviderTypeCode] = S.[SecondaryProviderTypeCode]
		   , [TertiaryProviderTypeCode] = S.[TertiaryProviderTypeCode]
		   , [MedicareProviderSupplierId] = S.[MedicareProviderSupplierId]
		   , [NationalProviderIDNPI] = S.[NationalProviderIDNPI]
		   , [DEARegistrationID] = S.[DEARegistrationID]
		   , [DEAExpirationDate] = S.[DEAExpirationDate]
		   , [FedralTaxIDNumber] = S.[FedralTaxIDNumber]
		   , [StateIncomeTaxIDNumber] = S.[StateIncomeTaxIDNumber]
		   , [DeactivationCode] = S.[DeactivationCode]
		   , [ReinstatementCode] = S.[ReinstatementCode]
		   , [ReinstatementDate] = S.[ReinstatementDate]
		   , [TransactionCode] = S.[TransactionCode]
		   , [TransactionDate] = S.[TransactionDate]
		 

WHEN NOT MATCHED THEN
		INSERT ([NCPDPProviderID] , [LegalBusinessName], [Name], [DoctorsName], [StoreNumber], [PhysicalLocationAddress1], [PhysicalLocationAddress2], [PhysicalLocationCity], [PhysicalLocationStateCode]
				, [PhysicalLocationZipCode], [PhysicalLocationPhoneNumber], [PhysicalLocationExtension], [PhysicalLocationFAX], [PhysicalLocationEmailAddress], [PhysicalLocationCrossStreetorDirections]
				, [PhysicalLocationCountyParish], [PhysicalLocationMSA], [PhysicalLocationPMSA], [PhysicalLocation24HourOperatingFlag], [PhysicalLocationProviderHours]
				, [PhysicalLocationCongressionalVotingDistrict], [PhysicalLocationLanguageCode1], [PhysicalLocationLanguageCode2], [PhysicalLocationLanguageCode3], [PhysicalLocationLanguageCode4]
				, [PhysicalLocationLanguageCode5], [PhysicalLocationStoreOpenDate], [PhysicalLocationStoreClosureDate], [MailingAddress1], [MailingAddress2], [MailingAddressCity], [MailingAddressStateCode]
				, [MailingAddressZIPCode], [ContactLastName], [ContactFirstName], [ContactMiddleInitial], [ContactTitle], [ContactPhoneNumber], [ContactExtension], [ContactEmailAddress], [DispenserClassCode]
				, [PrimaryProviderTypeCode], [SecondaryProviderTypeCode], [TertiaryProviderTypeCode], [MedicareProviderSupplierId], [NationalProviderIDNPI], [DEARegistrationID], [DEAExpirationDate]
				, [FedralTaxIDNumber], [StateIncomeTaxIDNumber], [DeactivationCode], [ReinstatementCode], [ReinstatementDate], [TransactionCode], [TransactionDate])
		VALUES (S.[NCPDPProviderID], S.[LegalBusinessName], S.[Name], S.[DoctorsName], S.[StoreNumber], S.[PhysicalLocationAddress1], S.[PhysicalLocationAddress2], S.[PhysicalLocationCity], S.[PhysicalLocationStateCode]
				, S.[PhysicalLocationZipCode], S.[PhysicalLocationPhoneNumber], S.[PhysicalLocationExtension], S.[PhysicalLocationFAX], S.[PhysicalLocationEmailAddress], S.[PhysicalLocationCrossStreetorDirections]
				, S.[PhysicalLocationCountyParish], S.[PhysicalLocationMSA], S.[PhysicalLocationPMSA], S.[PhysicalLocation24HourOperatingFlag], S.[PhysicalLocationProviderHours]
				, S.[PhysicalLocationCongressionalVotingDistrict], S.[PhysicalLocationLanguageCode1], S.[PhysicalLocationLanguageCode2], S.[PhysicalLocationLanguageCode3], S.[PhysicalLocationLanguageCode4]
				, S.[PhysicalLocationLanguageCode5], S.[PhysicalLocationStoreOpenDate], S.[PhysicalLocationStoreClosureDate], S.[MailingAddress1], S.[MailingAddress2], S.[MailingAddressCity], S.[MailingAddressStateCode]
				, S.[MailingAddressZIPCode], S.[ContactLastName], S.[ContactFirstName], S.[ContactMiddleInitial], S.[ContactTitle], S.[ContactPhoneNumber], S.[ContactExtension], S.[ContactEmailAddress], S.[DispenserClassCode]
				, S.[PrimaryProviderTypeCode], S.[SecondaryProviderTypeCode], S.[TertiaryProviderTypeCode], S.[MedicareProviderSupplierId], S.[NationalProviderIDNPI], S.[DEARegistrationID], S.[DEAExpirationDate]
				, S.[FedralTaxIDNumber], S.[StateIncomeTaxIDNumber], S.[DeactivationCode], S.[ReinstatementCode], S.[ReinstatementDate], S.[TransactionCode], S.[TransactionDate]);
END


GO
