USE [SalesDDS]
GO
/****** Object:  View [Staging].[vwPharmacyDim]    Script Date: 12/22/2020 7:55:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [Staging].[vwPharmacyDim]


AS


SELECT PMID
, [PMParentID]
, NULLIF(LTRIM(RTRIM(AAPAccountNo)), '') AS AAP_AccountNumber
, NULLIF(LTRIM(RTRIM(AAPParentNo)), '') AS AAP_ParentNumber
, [AAPEffectiveDate] AS AAP_StartDate
, [AAPQuitDate] AS AAP_EndDate
, NULLIF(LTRIM(RTRIM([AccountDescription])), '') AS [AccountDescription]
, NULLIF(LTRIM(RTRIM([AccountName])), '') AS AccountName
, [AllowDupDEA] AS IsAllowedDuplicateDEA
, NULLIF(LTRIM(RTRIM([APIAccountNo])), '') AS API_AccountNumber
, NULLIF(LTRIM(RTRIM([DEA])), '') AS API_DEA
, NULLIF(LTRIM(RTRIM([APIMemberNo])), '') AS API_MemberNumber
, NULLIF(LTRIM(RTRIM([APIStatus])), '') AS API_Status
, NULLIF(LTRIM(RTRIM([BusinessClass])), '') AS BusinessClass
, NULLIF(LTRIM(RTRIM([CAHStatus])), '') AS Cardinal_Status
, NULLIF(LTRIM(RTRIM([CardinalDC])), '') AS Cardinal_DistributionCenter
, NULLIF(LTRIM(RTRIM([ComputerSoftware])), '') AS ComputerSoftware
, [ContractDate] AS ContractEffectiveDate
, NULLIF(LTRIM(RTRIM([CorporateName])), '') AS CorporateName
, NULLIF(LTRIM(RTRIM([CustPayTermsAPI])), '') AS API_CustomerPayTerms
, [DateOpened] AS API_EffectiveDate
, NULLIF(LTRIM(RTRIM(DBA)), '') AS DBA
, NULLIF(LTRIM(RTRIM(DEA)), '') AS DEA
, CONVERT(DATE, [DEAEXP]) AS DEAExpiration
, NULLIF(LTRIM(RTRIM([Email])), '') AS Email
, NULLIF(LTRIM(RTRIM([EmergencyPhone])), '') AS EmergencyPhone
, NULLIF(LTRIM(RTRIM([FedID])), '') AS FederalTIN
, NULLIF(LTRIM(RTRIM([GroupNo])), '') AS GroupNumber
, NULLIF(LTRIM(RTRIM(IsHighVolume)), '') AS IsHighVolume
, NULLIF(LTRIM(RTRIM([NCPDP])), '') AS NCPDP
, NULLIF(LTRIM(RTRIM([NPI])), '') AS NPI
, NULLIF(LTRIM(RTRIM([OwnerName])), '') AS OwnerName
, [Payee_id] AS PayeeID
, [PrimaryCAAccountNo] AS [Primary_CA_AccountNumber]
, NULL AS PrimaryWholesaler
, NULLIF(LTRIM(RTRIM([Territory])), '') AS Territory
, NULLIF(LTRIM(RTRIM([UDAccountNo])), '') AS [Arete_AccountNumber]
, NULLIF(LTRIM(RTRIM([UDNonPharmacy])), '') AS [Arete_NonPharmacy]
, NULLIF(LTRIM(RTRIM([UDParentNo])), '') AS [Arete_ParentNumber]
, UDQuitDate AS Arete_InactiveDate
, NULLIF(LTRIM(RTRIM([UDStatus])), '') AS [Arete_Status]
, NULLIF(LTRIM(RTRIM([Website])), '') AS Website
, NULLIF(LTRIM(RTRIM([Wholesaler])), '') AS Wholesaler
, NULLIF(LTRIM(RTRIM([WholesalerAccountNo])), '') AS [WholesalerAccountNumber]
, NULLIF(LTRIM(RTRIM([WhyResigned])), '') AS [ResignedReason]
, [IsPva]
, NULLIF(LTRIM(RTRIM([ACHEmail])), '') AS ACH_Email
, [Created] AS OriginalDateCreated
, NULLIF([AuthorizedVoter], '') AS AuthorizedVoter
, NULLIF(LTRIM(RTRIM([MembershipOwner])), '') AS MembershipOwner
, NULLIF(LTRIM(RTRIM(API_WarehouseNumber)), '') AS API_WarehouseNumber
, NULLIF(LTRIM(RTRIM([DoNotFax])), '') AS DoNotFax
, NULLIF(LTRIM(RTRIM([CommunicationPreference])), '') AS CommunicationPreference
, NULLIF(LTRIM(RTRIM([Addr1])), '') AS Physical_Address1
, NULLIF(LTRIM(RTRIM(Addr2)), '') AS Physical_Address2
, NULLIF(LTRIM(RTRIM([City])), '') AS Physical_City
, NULLIF(LTRIM(RTRIM([State])), '') AS Physical_State
, NULLIF(LTRIM(RTRIM(Zip)), '') AS Physical_Zip
, NULLIF(LTRIM(RTRIM([Phone])), '') AS Physical_PhoneNumber
, NULLIF(LTRIM(RTRIM(Fax)), '') AS Physical_Fax
, NULLIF(LTRIM(RTRIM([FinAddr1])), '') AS Finance_Address1
, NULLIF(LTRIM(RTRIM([FinAddr2])), '') AS Finance_Address2
, NULLIF(LTRIM(RTRIM([FinCity])), '') AS Finance_City
, NULLIF(LTRIM(RTRIM([FinState])), '') AS Finance_State
, NULLIF(LTRIM(RTRIM([FinZip])), '') AS Finance_Zip
, NULLIF(LTRIM(RTRIM([MailAddr1])), '') AS Mailing_Address1
, NULLIF(LTRIM(RTRIM([MailAddr2])), '') AS Mailing_Address2
, NULLIF(LTRIM(RTRIM([MailCity])), '') AS Mailing_City
, NULLIF(LTRIM(RTRIM([MailState])), '') AS Mailing_State
, NULLIF(LTRIM(RTRIM([MailZip])), '') AS Mailing_Zip
, NULLIF(LTRIM(RTRIM([DateOpened])), '') AS DateOpened
FROM PharmacyMaster.[dbo].[v_PM_AllWithAffiliates]

GO
