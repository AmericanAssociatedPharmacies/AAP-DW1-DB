USE [RXMaster]
GO
/****** Object:  StoredProcedure [Archive].[usp_PharmacyDim_Load]    Script Date: 12/22/2020 7:53:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE PROCEDURE [Archive].[usp_PharmacyDim_Load]

AS

SET NOCOUNT ON;

BEGIN


	--Archive all data before any DML operation begins
	INSERT INTO [Archive].[PharmacyDim](PharmacyKey, Classification, AccountClassificationCodename, AccountID, Createdbyname, CreatedOn, CreditLimit, CreditLimitBase, CreditHold, Creditonholdname, DonotallowBulkEmails
	, DonotallowBulkMails, DonotallowEmails, DonotallowFaxes, DonotallowPhoneCalls, DonotallowMails, SendMarketingMaterials, GeneralEmail, FinancialEmail, ExecutiveEmail, Fax, ModifiedBy
	, modifiedbyname, ModifiedOn, ModifiedByDelegate, modifiedonbehalfbyname, PharmacyName, AAPNumber, AAPEffectiveDate, ResignationReason, AAPResignationReasonname, AAPMembershipType, AAPMembershipTypeName
	, AAPParent, AAPParentText, AAPQuitDate, AAPStatus, AAPStatusName, AAPTermNotice, AccountSubType, AccountSubtypename, Affiliate, AffiliateActive, AffiliateEnd, AffiliateGroup, Affiliategroupname, Affiliatename
	, APINumber, ApplicationtoCredit, APIApplicationStatus, APIAppStatusname, ApplicationApproved, CSOSApproved, CSOSDeclined, CSOSInstalled, CSOSQuestionniareReceived, APIOrderCutOff, APICutoffname, APIPrimaryOrderMethod
	, APIOrderMethodname, PhotosReceived, APIPaymentTerms, APITermsName, APIAccountActivation, APIAlert, APIAlertName, APIBrands, APICreditAlert, APICreditAlertName, APICreditLimit, CSOSAlert, APICSOSAlertName, CSOSStatus
	, APICSOSStatusName, APIDefaultShipping, APIDefaultShippingName, APIFreight, APIFreightName, APIGenerics, APIMOT, APImotname, APIOTCs, APIPaymentMethod, APIPaymentMethodName, APIQuestionniare, APIQuestionniareName
	, APIRefrigerated, APIRefrigeratedName, APIStatus, APIStatusName, APITotals, APIWarehouse, APIWarehouseName, AplicorNumber, ApplicationFeeDate, APIAppReceived, AtRisk, AtRiskName, IATV, AuthorizedSignature, Automation, AutomationName
	, AverageVolume, BusinessClass, BusinessClassName, CAHPrimaryAccount, CAHAvgMonthlyVolume, CAHCostofGoods, CAHContractedDSO, CAHPotentialMonthlyVolume, CAHPaymentTerms, CAHTermsName, CAHContractDate, CAHEffDateNewAgreement
	, CAHLastReview, CAHMatrix, cahpvamatrixname, CAHReviewType, CAH_PVA_ReviewTypeName, CAHStatus, CAH_PVA_Statusname, CAHTermCode, CAH_PVA_TermCodeName, CAHTermComments, CAHTermDate, Category, CategoryName, CombinedVolume
	, Conference2015, Conference2015name, Conference2016, Conference2016name, Conference2017, Conference2017name, Conference2018, Conference2018name, CopytoFinancial, CopyPhysicaltoFinancialName, CopytoMailing, CopyPhysicaltoMailingName
	, CopytoMarketingEmail, CopytoMarketingeMailName, CorporateName, County, DEA_HIN, DEA_HINExpiration, DiversionCE, DocuSignSender, DocuSignSenderEmail, DocusignSenderEmailName, DocusignSenderName, DunBradstreetNo, EDIFTPActivation
	, EDIFTPApplicationReceived, EDIFTPApproved, FederalTaxID, ApplicationFeePaid, FeePaidName, CAHAverageGCR, GeneralEmail2, GroupNumber, GroupAlliance, GroupAllianceName, SaturdaysClose, SaturdaysOpen, SundaysClose, SundaysOpen, WeekdaysClose
	, WeekdaysOpen, IATVTitle, IncorporationState, IndustrySupportFund, IndustrySupportFundName, LastSalesCall, ManagedCareAffiliation, ManagedCareNetworkName, MarketingEmail, ManagedCareAffiliationOld, MCAffiliationName, AreteEffective
	, AreteNetwork, MCNetworkName, AreteTermination, AAPAppReceived, NCPAID, NCPDP, NPI, OrderingContactText, OrderingContact, OderingContactLookupName, OrganizationType, OrgTypeName, OwnerType, OwnerTypeName, PharmacistName, PharmacistLicense
	, PharmacistLicenseExpiration, PharmacyOwnerText, PharmacyOwnerEmail, PharmacyOwnerFax, PharmacyOwner, PharmacyOwnerLookupName, PharmacyOwnerPhone, PharmacyOwnerTitle, PharmacySystem, pharmacysystemname, Planogram, PlanogramName
	, PMID, PreviousMemberRecord, PreviousAAPMemberName, PrimaryWholesaler, PrimaryWholesalerNewName, ScanTossActivation, ScanTossApplicationReceived, ScanTossEligible, ScanTossStatus, ScanTossStatusName, ScanTossVersion, ScanTossVersionName
	, SendApplicationEmail, SendApplicationName, SoftwareLiabilityWaiver, StartUp, StartUpName, StateLicense, StateLicenseExpiration, StateTaxID, SandTBrandSmartPlus, SandTCloud, SandTCloudName, SandTCloudWorkstations, Territory, TerritoriesName
	, TerritoryManager, TerritoryManagerEmail, TerritoryManagerEmailName, TerritoryManagerName, TerritoryName, Owner, OwnerIDName, owneridtype, AAPParentID, parentaccountidname, PrimaryContact, primarycontactidname, StatusCodeType, statuscodename
	, MainPhone, OtherPhone, Telephone3, VersionNumber, Website, APIPMID, GroupNo, WholesalerName, IsCurrent, StartDateKey, EndDateKey, RowCreatedDate,  RowVersionID, IsHistoricalRecord
	, [ProfitAmpActivation], [ProfitAmpLevel], [ProfitAmpLevelName], [ProfitAmpApplicationReceived], [ProfitAmpSenderEmail], [ProfitAmpSignerName], [ProfitAmpSignerTitle]
	, [ProfitAmpSenderEmailName], [ProfitAmpSent], [ProfitAmpTermination], [ProfitAmpBilling], [ProfitAmpFee])
	SELECT PharmacyKey, Classification, AccountClassificationCodename, AccountID, Createdbyname, CreatedOn, CreditLimit, CreditLimitBase, CreditHold, Creditonholdname, DonotallowBulkEmails
	, DonotallowBulkMails, DonotallowEmails, DonotallowFaxes, DonotallowPhoneCalls, DonotallowMails, SendMarketingMaterials, GeneralEmail, FinancialEmail, ExecutiveEmail, Fax, ModifiedBy
	, modifiedbyname, ModifiedOn, ModifiedByDelegate, modifiedonbehalfbyname, PharmacyName, AAPNumber, AAPEffectiveDate, ResignationReason, AAPResignationReasonname, AAPMembershipType, AAPMembershipTypeName
	, AAPParent, AAPParentText, AAPQuitDate, AAPStatus, AAPStatusName, AAPTermNotice, AccountSubType, AccountSubtypename, Affiliate, AffiliateActive, AffiliateEnd, AffiliateGroup, Affiliategroupname, Affiliatename
	, APINumber, ApplicationtoCredit, APIApplicationStatus, APIAppStatusname, ApplicationApproved, CSOSApproved, CSOSDeclined, CSOSInstalled, CSOSQuestionniareReceived, APIOrderCutOff, APICutoffname, APIPrimaryOrderMethod
	, APIOrderMethodname, PhotosReceived, APIPaymentTerms, APITermsName, APIAccountActivation, APIAlert, APIAlertName, APIBrands, APICreditAlert, APICreditAlertName, APICreditLimit, CSOSAlert, APICSOSAlertName, CSOSStatus
	, APICSOSStatusName, APIDefaultShipping, APIDefaultShippingName, APIFreight, APIFreightName, APIGenerics, APIMOT, APImotname, APIOTCs, APIPaymentMethod, APIPaymentMethodName, APIQuestionniare, APIQuestionniareName
	, APIRefrigerated, APIRefrigeratedName, APIStatus, APIStatusName, APITotals, APIWarehouse, APIWarehouseName, AplicorNumber, ApplicationFeeDate, APIAppReceived, AtRisk, AtRiskName, IATV, AuthorizedSignature, Automation, AutomationName
	, AverageVolume, BusinessClass, BusinessClassName, CAHPrimaryAccount, CAHAvgMonthlyVolume, CAHCostofGoods, CAHContractedDSO, CAHPotentialMonthlyVolume, CAHPaymentTerms, CAHTermsName, CAHContractDate, CAHEffDateNewAgreement
	, CAHLastReview, CAHMatrix, cahpvamatrixname, CAHReviewType, CAH_PVA_ReviewTypeName, CAHStatus, CAH_PVA_Statusname, CAHTermCode, CAH_PVA_TermCodeName, CAHTermComments, CAHTermDate, Category, CategoryName, CombinedVolume
	, Conference2015, Conference2015name, Conference2016, Conference2016name, Conference2017, Conference2017name, Conference2018, Conference2018name, CopytoFinancial, CopyPhysicaltoFinancialName, CopytoMailing, CopyPhysicaltoMailingName
	, CopytoMarketingEmail, CopytoMarketingeMailName, CorporateName, County, DEA_HIN, DEA_HINExpiration, DiversionCE, DocuSignSender, DocuSignSenderEmail, DocusignSenderEmailName, DocusignSenderName, DunBradstreetNo, EDIFTPActivation
	, EDIFTPApplicationReceived, EDIFTPApproved, FederalTaxID, ApplicationFeePaid, FeePaidName, CAHAverageGCR, GeneralEmail2, GroupNumber, GroupAlliance, GroupAllianceName, SaturdaysClose, SaturdaysOpen, SundaysClose, SundaysOpen, WeekdaysClose
	, WeekdaysOpen, IATVTitle, IncorporationState, IndustrySupportFund, IndustrySupportFundName, LastSalesCall, ManagedCareAffiliation, ManagedCareNetworkName, MarketingEmail, ManagedCareAffiliationOld, MCAffiliationName, AreteEffective
	, AreteNetwork, MCNetworkName, AreteTermination, AAPAppReceived, NCPAID, NCPDP, NPI, OrderingContactText, OrderingContact, OderingContactLookupName, OrganizationType, OrgTypeName, OwnerType, OwnerTypeName, PharmacistName, PharmacistLicense
	, PharmacistLicenseExpiration, PharmacyOwnerText, PharmacyOwnerEmail, PharmacyOwnerFax, PharmacyOwner, PharmacyOwnerLookupName, PharmacyOwnerPhone, PharmacyOwnerTitle, PharmacySystem, pharmacysystemname, Planogram, PlanogramName
	, PMID, PreviousMemberRecord, PreviousAAPMemberName, PrimaryWholesaler, PrimaryWholesalerNewName, ScanTossActivation, ScanTossApplicationReceived, ScanTossEligible, ScanTossStatus, ScanTossStatusName, ScanTossVersion, ScanTossVersionName
	, SendApplicationEmail, SendApplicationName, SoftwareLiabilityWaiver, StartUp, StartUpName, StateLicense, StateLicenseExpiration, StateTaxID, SandTBrandSmartPlus, SandTCloud, SandTCloudName, SandTCloudWorkstations, Territory, TerritoriesName
	, TerritoryManager, TerritoryManagerEmail, TerritoryManagerEmailName, TerritoryManagerName, TerritoryName, Owner, OwnerIDName, owneridtype, AAPParentID, parentaccountidname, PrimaryContact, primarycontactidname, StatusCodeType, statuscodename
	, MainPhone, OtherPhone, Telephone3, VersionNumber, Website, APIPMID, GroupNo, WholesalerName, IsCurrent, StartDateKey, EndDateKey, RowCreatedDate, RowVersionID, IsHistoricalRecord
	, [ProfitAmpActivation], [ProfitAmpLevel], [ProfitAmpLevelName], [ProfitAmpApplicationReceived], [ProfitAmpSenderEmail], [ProfitAmpSignerName], [ProfitAmpSignerTitle]
	, [ProfitAmpSenderEmailName], [ProfitAmpSent], [ProfitAmpTermination], [ProfitAmpBilling], [ProfitAmpFee]
	FROM [dbo].[PharmacyDim]







END




GO
