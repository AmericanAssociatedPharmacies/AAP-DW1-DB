USE [RXMaster]
GO
/****** Object:  StoredProcedure [dbo].[usp_PharmacyDim_Load]    Script Date: 12/22/2020 7:53:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







CREATE PROCEDURE [dbo].[usp_PharmacyDim_Load]

AS

SET NOCOUNT ON;

BEGIN

	
	--Load default row, if it doesn't exist. This row must exist. Otherwise, the DW loads will break.
	SET IDENTITY_INSERT [dbo].[PharmacyDim] ON

	INSERT INTO [dbo].[PharmacyDim]([PharmacyKey], PMID, AAPNumber, APINumber)
	SELECT dt.PharmacyKey, dt.PMID, dt.AAPNumber, dt.APINumber
	FROM(SELECT 0 AS PharmacyKey
			, 0 AS PMID
			, '0' AS AAPNumber
			, '0' AS APINumber	
			) AS dt
	WHERE NOT EXISTS(SELECT 1
						FROM dbo.PharmacyDim AS p
						WHERE dt.PharmacyKey = p.PharmacyKey	
					)

	SET IDENTITY_INSERT [dbo].[PharmacyDim] OFF
	
	
	--Merge data
	MERGE [dbo].[PharmacyDim] AS t
	USING [Staging].[PharmacyDim] AS s ON t.PMID = s.PMID

	WHEN MATCHED THEN
	UPDATE SET Classification = s.Classification
	, AccountClassificationCodename = s.AccountClassificationCodename
	, AccountID = s.AccountID
	, Createdbyname = s.Createdbyname
	, CreatedOn = s.CreatedOn
	, CreditLimit = s.CreditLimit
	, CreditLimitBase = s.CreditLimitBase
	, CreditHold = s.CreditHold
	, Creditonholdname = s.Creditonholdname
	, DonotallowBulkEmails = s.DonotallowBulkEmails
	, DonotallowBulkMails = s.DonotallowBulkMails
	, DonotallowEmails = s.DonotallowEmails
	, DonotallowFaxes = s.DonotallowFaxes
	, DonotallowPhoneCalls = s.DonotallowPhoneCalls
	, DonotallowMails = s.DonotallowMails
	, SendMarketingMaterials = s.SendMarketingMaterials
	, GeneralEmail = s.GeneralEmail
	, FinancialEmail = s.FinancialEmail
	, ExecutiveEmail = s.ExecutiveEmail
	, Fax = s.Fax
	, ModifiedBy = s.ModifiedBy
	, modifiedbyname = s.modifiedbyname
	, ModifiedOn = s.ModifiedOn
	, ModifiedByDelegate = s.ModifiedByDelegate
	, modifiedonbehalfbyname = s.modifiedonbehalfbyname
	, PharmacyName = s.PharmacyName
	, AAPNumber = s.AAPNumber
	, AAPEffectiveDate = s.AAPEffectiveDate
	, ResignationReason = s.ResignationReason
	, AAPResignationReasonname = s.AAPResignationReasonname
	, AAPMembershipType = s.AAPMembershipType
	, AAPMembershipTypeName = s.AAPMembershipTypeName
	, AAPParent = s.AAPParent
	, AAPParentText = s.AAPParentText
	, AAPQuitDate = s.AAPQuitDate
	, AAPStatus = s.AAPStatus
	, AAPStatusName = s.AAPStatusName
	, AAPTermNotice = s.AAPTermNotice
	, AccountSubType = s.AccountSubType
	, AccountSubtypename = s.AccountSubtypename
	, Affiliate = s.Affiliate
	, AffiliateActive = s.AffiliateActive
	, AffiliateEnd = s.AffiliateEnd
	, AffiliateGroup = s.AffiliateGroup
	, Affiliategroupname = s.Affiliategroupname
	, Affiliatename = s.Affiliatename
	, APINumber = s.APINumber
	, ApplicationtoCredit = s.ApplicationtoCredit
	, APIApplicationStatus = s.APIApplicationStatus
	, APIAppStatusname = s.APIAppStatusname
	, ApplicationApproved = s.ApplicationApproved
	, CSOSApproved = s.CSOSApproved
	, CSOSDeclined = s.CSOSDeclined
	, CSOSInstalled = s.CSOSInstalled
	, CSOSQuestionniareReceived = s.CSOSQuestionniareReceived
	, APIOrderCutOff = s.APIOrderCutOff
	, APICutoffname = s.APICutoffname
	, APIPrimaryOrderMethod = s.APIPrimaryOrderMethod
	, APIOrderMethodname = s.APIOrderMethodname
	, PhotosReceived = s.PhotosReceived
	, APIPaymentTerms = s.APIPaymentTerms
	, APITermsName = s.APITermsName
	, APIAccountActivation = s.APIAccountActivation
	, APIAlert = s.APIAlert
	, APIAlertName = s.APIAlertName
	, APIBrands = s.APIBrands
	, APICreditAlert = s.APICreditAlert
	, APICreditAlertName = s.APICreditAlertName
	, APICreditLimit = s.APICreditLimit
	, CSOSAlert = s.CSOSAlert
	, APICSOSAlertName = s.APICSOSAlertName
	, CSOSStatus = s.CSOSStatus
	, APICSOSStatusName = s.APICSOSStatusName
	, APIDefaultShipping = s.APIDefaultShipping
	, APIDefaultShippingName = s.APIDefaultShippingName
	, APIFreight = s.APIFreight
	, APIFreightName = s.APIFreightName
	, APIGenerics = s.APIGenerics
	, APIMOT = s.APIMOT
	, APImotname = s.APImotname
	, APIOTCs = s.APIOTCs
	, APIPaymentMethod = s.APIPaymentMethod
	, APIPaymentMethodName = s.APIPaymentMethodName
	, APIQuestionniare = s.APIQuestionniare
	, APIQuestionniareName = s.APIQuestionniareName
	, APIRefrigerated = s.APIRefrigerated
	, APIRefrigeratedName = s.APIRefrigeratedName
	, APIStatus = s.APIStatus
	, APIStatusName = s.APIStatusName
	, APITotals = s.APITotals
	, APIWarehouse = s.APIWarehouse
	, APIWarehouseName = s.APIWarehouseName
	, AplicorNumber = s.AplicorNumber
	, ApplicationFeeDate = s.ApplicationFeeDate
	, APIAppReceived = s.APIAppReceived
	, AtRisk = s.AtRisk
	, AtRiskName = s.AtRiskName
	, IATV = s.IATV
	, AuthorizedSignature = s.AuthorizedSignature
	, Automation = s.Automation
	, AutomationName = s.AutomationName
	, AverageVolume = s.AverageVolume
	, BusinessClass = s.BusinessClass
	, BusinessClassName = s.BusinessClassName
	, CAHPrimaryAccount = s.CAHPrimaryAccount
	, CAHAvgMonthlyVolume = s.CAHAvgMonthlyVolume
	, CAHCostofGoods = s.CAHCostofGoods
	, CAHContractedDSO = s.CAHContractedDSO
	, CAHPotentialMonthlyVolume = s.CAHPotentialMonthlyVolume
	, CAHPaymentTerms = s.CAHPaymentTerms
	, CAHTermsName = s.CAHTermsName
	, CAHContractDate = s.CAHContractDate
	, CAHEffDateNewAgreement = s.CAHEffDateNewAgreement
	, CAHLastReview = s.CAHLastReview
	, CAHMatrix = s.CAHMatrix
	, CAHPVAMatrixName = s.CAHPVAMatrixName
	, CAHReviewType = s.CAHReviewType
	, CAH_PVA_ReviewTypeName = s.CAH_PVA_ReviewTypeName
	, CAHStatus = s.CAHStatus
	, CAH_PVA_Statusname = s.CAH_PVA_Statusname
	, CAHTermCode = s.CAHTermCode
	, CAH_PVA_TermCodeName = s.CAH_PVA_TermCodeName
	, CAHTermComments = s.CAHTermComments
	, CAHTermDate = s.CAHTermDate
	, Category = s.Category
	, CategoryName = s.CategoryName
	, CombinedVolume = s.CombinedVolume
	, Conference2015 = s.Conference2015
	, Conference2015name = s.Conference2015name
	, Conference2016 = s.Conference2016
	, Conference2016name = s.Conference2016name
	, Conference2017 = s.Conference2017
	, Conference2017name = s.Conference2017name
	, Conference2018 = s.Conference2018
	, Conference2018name = s.Conference2018name
	, CopytoFinancial = s.CopytoFinancial
	, CopyPhysicaltoFinancialName = s.CopyPhysicaltoFinancialName
	, CopytoMailing = s.CopytoMailing
	, CopyPhysicaltoMailingName = s.CopyPhysicaltoMailingName
	, CopytoMarketingEmail = s.CopytoMarketingEmail
	, CopytoMarketingeMailName = s.CopytoMarketingeMailName
	, CorporateName = s.CorporateName
	, County = s.County
	, DEA_HIN = s.DEA_HIN
	, DEA_HINExpiration = s.DEA_HINExpiration
	, DiversionCE = s.DiversionCE
	, DocuSignSender = s.DocuSignSender
	, DocuSignSenderEmail = s.DocuSignSenderEmail
	, DocusignSenderEmailName = s.DocusignSenderEmailName
	, DocusignSenderName = s.DocusignSenderName
	, DunBradstreetNo = s.DunBradstreetNo
	, EDIFTPActivation = s.EDIFTPActivation
	, EDIFTPApplicationReceived = s.EDIFTPApplicationReceived
	, EDIFTPApproved = s.EDIFTPApproved
	, FederalTaxID = s.FederalTaxID
	, ApplicationFeePaid = s.ApplicationFeePaid
	, FeePaidName = s.FeePaidName
	, CAHAverageGCR = s.CAHAverageGCR
	, GeneralEmail2 = s.GeneralEmail2
	, GroupNumber = s.GroupNumber
	, GroupAlliance = s.GroupAlliance
	, GroupAllianceName = s.GroupAllianceName
	, SaturdaysClose = s.SaturdaysClose
	, SaturdaysOpen = s.SaturdaysOpen
	, SundaysClose = s.SundaysClose
	, SundaysOpen = s.SundaysOpen
	, WeekdaysClose = s.WeekdaysClose
	, WeekdaysOpen = s.WeekdaysOpen
	, IATVTitle = s.IATVTitle
	, IncorporationState = s.IncorporationState
	, IndustrySupportFund = s.IndustrySupportFund
	, IndustrySupportFundName = s.IndustrySupportFundName
	, LastSalesCall = s.LastSalesCall
	, ManagedCareAffiliation = s.ManagedCareAffiliation
	, ManagedCareNetworkName = s.ManagedCareNetworkName
	, MarketingEmail = s.MarketingEmail
	, ManagedCareAffiliationOld = s.ManagedCareAffiliationOld
	, MCAffiliationName = s.MCAffiliationName
	, AreteEffective = s.AreteEffective
	, AreteNetwork = s.AreteNetwork
	, MCNetworkName = s.MCNetworkName
	, AreteTermination = s.AreteTermination
	, AAPAppReceived = s.AAPAppReceived
	, NCPAID = s.NCPAID
	, NCPDP = s.NCPDP
	, NPI = s.NPI
	, OrderingContactText = s.OrderingContactText
	, OrderingContact = s.OrderingContact
	, OderingContactLookupName = s.OderingContactLookupName
	, OrganizationType = s.OrganizationType
	, OrgTypeName = s.OrgTypeName
	, OwnerType = s.OwnerType
	, OwnerTypeName = s.OwnerTypeName
	, PharmacistName = s.PharmacistName
	, PharmacistLicense = s.PharmacistLicense
	, PharmacistLicenseExpiration = s.PharmacistLicenseExpiration
	, PharmacyOwnerText = s.PharmacyOwnerText
	, PharmacyOwnerEmail = s.PharmacyOwnerEmail
	, PharmacyOwnerFax = s.PharmacyOwnerFax
	, PharmacyOwner = s.PharmacyOwner
	, PharmacyOwnerLookupName = s.PharmacyOwnerLookupName
	, PharmacyOwnerPhone = s.PharmacyOwnerPhone
	, PharmacyOwnerTitle = s.PharmacyOwnerTitle
	, PharmacySystem = s.PharmacySystem
	, PharmacySystemName = s.PharmacySystemName
	, Planogram = s.Planogram
	, PlanogramName = s.PlanogramName
	, PreviousMemberRecord = s.PreviousMemberRecord
	, PreviousAAPMemberName = s.PreviousAAPMemberName
	, PrimaryWholesaler = s.PrimaryWholesaler
	, PrimaryWholesalerNewName = s.PrimaryWholesalerNewName
	, ScanTossActivation = s.ScanTossActivation
	, ScanTossApplicationReceived = s.ScanTossApplicationReceived
	, ScanTossEligible = s.ScanTossEligible
	, ScanTossStatus = s.ScanTossStatus
	, ScanTossStatusName = s.ScanTossStatusName
	, ScanTossVersion = s.ScanTossVersion
	, ScanTossVersionName = s.ScanTossVersionName
	, SendApplicationEmail = s.SendApplicationEmail
	, SendApplicationName = s.SendApplicationName
	, SoftwareLiabilityWaiver = s.SoftwareLiabilityWaiver
	, StartUp = s.StartUp
	, StartUpName = s.StartUpName
	, StateLicense = s.StateLicense
	, StateLicenseExpiration = s.StateLicenseExpiration
	, StateTaxID = s.StateTaxID
	, SandTBrandSmartPlus = s.SandTBrandSmartPlus
	, SandTCloud = s.SandTCloud
	, SandTCloudName = s.SandTCloudName
	, SandTCloudWorkstations = s.SandTCloudWorkstations
	, Territory = s.Territory
	, TerritoriesName = s.TerritoriesName
	, TerritoryManager = s.TerritoryManager
	, TerritoryManagerEmail = s.TerritoryManagerEmail
	, TerritoryManagerEmailName = s.TerritoryManagerEmailName
	, TerritoryManagerName = s.TerritoryManagerName
	, TerritoryName = s.TerritoryName
	, Owner = s.Owner
	, OwnerIDName = s.OwnerIDName
	, owneridtype = s.owneridtype
	, AAPParentID = s.AAPParentID
	, parentaccountidname = s.parentaccountidname
	, PrimaryContact = s.PrimaryContact
	, primarycontactidname = s.primarycontactidname
	, StatusCodeType = s.StatusCodeType
	, statuscodename = s.statuscodename
	, MainPhone = s.MainPhone
	, OtherPhone = s.OtherPhone
	, Telephone3 = s.Telephone3
	, VersionNumber = s.VersionNumber
	, Website = s.Website
	, APIPMID = s.APIPMID
	, GroupNo = s.GroupNo
	, WholesalerName = s.WholesalerName
	, FirstSalesDate = s.FirstSalesDate
	, IsHistoricalRecord = s.IsHistoricalRecord
	, ProfitAmpActivation = s.ProfitAmpActivation
	, ProfitAmpLevel = s.ProfitAmpLevel
	, ProfitAmpLevelName = s.ProfitAmpLevelName
	, ProfitAmpApplicationReceived = s.ProfitAmpApplicationReceived
	, ProfitAmpSenderEmail = s.ProfitAmpSenderEmail
	, ProfitAmpSignerName = s.ProfitAmpSignerName
	, ProfitAmpSignerTitle = s.ProfitAmpSignerTitle
	, ProfitAmpSenderEmailName = s.ProfitAmpSenderEmailName
	, ProfitAmpSent = s.ProfitAmpSent
	, ProfitAmpTermination = s.ProfitAmpTermination
	, ProfitAmpBilling = s.ProfitAmpBilling
	, ProfitAmpFee = s.ProfitAmpFee
	, APIEffectiveDate = s.APIEffectiveDate
	, APIQuitDate = s.APIQuitDate
	, APIEffectiveDateKey = s.APIEffectiveDateKey
	, APIQuitDateKey = s.APIQuitDateKey
	, AAPEffectiveDateKey = s.AAPEffectiveDateKey
	, AAPQuitDateKey = s.AAPQuitDateKey
	, PreviousMemberPMID = s.PreviousMemberPMID
	, CorrectedCAHAccountNo = s.CorrectedCAHAccountNo

	WHEN NOT MATCHED THEN
	INSERT(Classification, AccountClassificationCodename, AccountID, Createdbyname, CreatedOn, CreditLimit, CreditLimitBase, CreditHold, Creditonholdname, DonotallowBulkEmails
	, DonotallowBulkMails, DonotallowEmails, DonotallowFaxes, DonotallowPhoneCalls, DonotallowMails, SendMarketingMaterials, GeneralEmail, FinancialEmail, ExecutiveEmail
	, Fax, ModifiedBy, modifiedbyname, ModifiedOn, ModifiedByDelegate, modifiedonbehalfbyname, PharmacyName, AAPNumber, AAPEffectiveDate, ResignationReason, AAPResignationReasonname
	, AAPMembershipType, AAPMembershipTypeName, AAPParent, AAPParentText, AAPQuitDate, AAPStatus, AAPStatusName, AAPTermNotice, AccountSubType, AccountSubtypename, Affiliate
	, AffiliateActive, AffiliateEnd, AffiliateGroup, Affiliategroupname, Affiliatename, APINumber, ApplicationtoCredit, APIApplicationStatus, APIAppStatusname, ApplicationApproved
	, CSOSApproved, CSOSDeclined, CSOSInstalled, CSOSQuestionniareReceived, APIOrderCutOff, APICutoffname, APIPrimaryOrderMethod, APIOrderMethodname, PhotosReceived, APIPaymentTerms
	, APITermsName, APIAccountActivation, APIAlert, APIAlertName, APIBrands, APICreditAlert, APICreditAlertName, APICreditLimit, CSOSAlert, APICSOSAlertName, CSOSStatus
	, APICSOSStatusName, APIDefaultShipping, APIDefaultShippingName, APIFreight, APIFreightName, APIGenerics, APIMOT, APImotname, APIOTCs, APIPaymentMethod, APIPaymentMethodName
	, APIQuestionniare, APIQuestionniareName, APIRefrigerated, APIRefrigeratedName, APIStatus, APIStatusName, APITotals, APIWarehouse, APIWarehouseName, AplicorNumber, ApplicationFeeDate
	, APIAppReceived, AtRisk, AtRiskName, IATV, AuthorizedSignature, Automation, AutomationName, AverageVolume, BusinessClass, BusinessClassName, CAHPrimaryAccount, CAHAvgMonthlyVolume
	, CAHCostofGoods, CAHContractedDSO, CAHPotentialMonthlyVolume, CAHPaymentTerms, CAHTermsName, CAHContractDate, CAHEffDateNewAgreement, CAHLastReview, CAHMatrix, CAHPVAMatrixName
	, CAHReviewType, CAH_PVA_ReviewTypeName, CAHStatus, CAH_PVA_Statusname, CAHTermCode, CAH_PVA_TermCodeName, CAHTermComments, CAHTermDate, Category, CategoryName, CombinedVolume
	, Conference2015, Conference2015name, Conference2016, Conference2016name, Conference2017, Conference2017name, Conference2018, Conference2018name, CopytoFinancial, CopyPhysicaltoFinancialName
	, CopytoMailing, CopyPhysicaltoMailingName, CopytoMarketingEmail, CopytoMarketingeMailName, CorporateName, County, DEA_HIN, DEA_HINExpiration, DiversionCE, DocuSignSender
	, DocuSignSenderEmail, DocusignSenderEmailName, DocusignSenderName, DunBradstreetNo, EDIFTPActivation, EDIFTPApplicationReceived, EDIFTPApproved, FederalTaxID, ApplicationFeePaid
	, FeePaidName, CAHAverageGCR, GeneralEmail2, GroupNumber, GroupAlliance, GroupAllianceName, SaturdaysClose, SaturdaysOpen, SundaysClose, SundaysOpen, WeekdaysClose
	, WeekdaysOpen, IATVTitle, IncorporationState, IndustrySupportFund, IndustrySupportFundName, LastSalesCall, ManagedCareAffiliation, ManagedCareNetworkName, MarketingEmail
	, ManagedCareAffiliationOld, MCAffiliationName, AreteEffective, AreteNetwork, MCNetworkName, AreteTermination, AAPAppReceived, NCPAID, NCPDP, NPI, OrderingContactText
	, OrderingContact, OderingContactLookupName, OrganizationType, OrgTypeName, OwnerType, OwnerTypeName, PharmacistName, PharmacistLicense, PharmacistLicenseExpiration, PharmacyOwnerText
	, PharmacyOwnerEmail, PharmacyOwnerFax, PharmacyOwner, PharmacyOwnerLookupName, PharmacyOwnerPhone, PharmacyOwnerTitle, PharmacySystem, PharmacySystemName, Planogram
	, PlanogramName, PMID, PreviousMemberRecord, PreviousAAPMemberName, PrimaryWholesaler, PrimaryWholesalerNewName, ScanTossActivation, ScanTossApplicationReceived, ScanTossEligible
	, ScanTossStatus, ScanTossStatusName, ScanTossVersion, ScanTossVersionName, SendApplicationEmail, SendApplicationName, SoftwareLiabilityWaiver, StartUp, StartUpName, StateLicense
	, StateLicenseExpiration, StateTaxID, SandTBrandSmartPlus, SandTCloud, SandTCloudName, SandTCloudWorkstations, Territory, TerritoriesName, TerritoryManager, TerritoryManagerEmail
	, TerritoryManagerEmailName, TerritoryManagerName, TerritoryName, Owner, OwnerIDName, owneridtype, AAPParentID, parentaccountidname, PrimaryContact, primarycontactidname
	, StatusCodeType, statuscodename, MainPhone, OtherPhone, Telephone3, VersionNumber, Website, APIPMID, GroupNo, WholesalerName, FirstSalesDate, IsHistoricalRecord
	, ProfitAmpActivation, ProfitAmpLevel, ProfitAmpLevelName, ProfitAmpApplicationReceived, ProfitAmpSenderEmail, ProfitAmpSignerName, ProfitAmpSignerTitle, ProfitAmpSenderEmailName
	, ProfitAmpSent, ProfitAmpTermination, ProfitAmpBilling, ProfitAmpFee, APIEffectiveDate, APIQuitDate, APIEffectiveDateKey, APIQuitDateKey, AAPEffectiveDateKey, AAPQuitDateKey
	, PreviousMemberPMID, CorrectedCAHAccountNo
	)
	VALUES(s.Classification, s.AccountClassificationCodename, s.AccountID, s.Createdbyname, s.CreatedOn, s.CreditLimit, s.CreditLimitBase, s.CreditHold, s.Creditonholdname, s.DonotallowBulkEmails
	, s.DonotallowBulkMails, s.DonotallowEmails, s.DonotallowFaxes, s.DonotallowPhoneCalls, s.DonotallowMails, s.SendMarketingMaterials, s.GeneralEmail, s.FinancialEmail, s.ExecutiveEmail
	, s.Fax, s.ModifiedBy, s.modifiedbyname, s.ModifiedOn, s.ModifiedByDelegate, s.modifiedonbehalfbyname, s.PharmacyName, s.AAPNumber, s.AAPEffectiveDate, s.ResignationReason, s.AAPResignationReasonname
	, s.AAPMembershipType, s.AAPMembershipTypeName, s.AAPParent, s.AAPParentText, s.AAPQuitDate, s.AAPStatus, s.AAPStatusName, s.AAPTermNotice, s.AccountSubType, s.AccountSubtypename, s.Affiliate
	, s.AffiliateActive, s.AffiliateEnd, s.AffiliateGroup, s.Affiliategroupname, s.Affiliatename, s.APINumber, s.ApplicationtoCredit, s.APIApplicationStatus, s.APIAppStatusname, s.ApplicationApproved
	, s.CSOSApproved, s.CSOSDeclined, s.CSOSInstalled, s.CSOSQuestionniareReceived, s.APIOrderCutOff, s.APICutoffname, s.APIPrimaryOrderMethod, s.APIOrderMethodname, s.PhotosReceived, s.APIPaymentTerms
	, s.APITermsName, s.APIAccountActivation, s.APIAlert, s.APIAlertName, s.APIBrands, s.APICreditAlert, s.APICreditAlertName, s.APICreditLimit, s.CSOSAlert, s.APICSOSAlertName, s.CSOSStatus
	, s.APICSOSStatusName, s.APIDefaultShipping, s.APIDefaultShippingName, s.APIFreight, s.APIFreightName, s.APIGenerics, s.APIMOT, s.APImotname, s.APIOTCs, s.APIPaymentMethod, s.APIPaymentMethodName
	, s.APIQuestionniare, s.APIQuestionniareName, s.APIRefrigerated, s.APIRefrigeratedName, s.APIStatus, s.APIStatusName, s.APITotals, s.APIWarehouse, s.APIWarehouseName, s.AplicorNumber, s.ApplicationFeeDate
	, s.APIAppReceived, s.AtRisk, s.AtRiskName, s.IATV, s.AuthorizedSignature, s.Automation, s.AutomationName, s.AverageVolume, s.BusinessClass, s.BusinessClassName, s.CAHPrimaryAccount, s.CAHAvgMonthlyVolume
	, s.CAHCostofGoods, s.CAHContractedDSO, s.CAHPotentialMonthlyVolume, s.CAHPaymentTerms, s.CAHTermsName, s.CAHContractDate, s.CAHEffDateNewAgreement, s.CAHLastReview, s.CAHMatrix, s.CAHPVAMatrixName
	, s.CAHReviewType, s.CAH_PVA_ReviewTypeName, s.CAHStatus, s.CAH_PVA_Statusname, s.CAHTermCode, s.CAH_PVA_TermCodeName, s.CAHTermComments, s.CAHTermDate, s.Category, s.CategoryName, s.CombinedVolume
	, s.Conference2015, s.Conference2015name, s.Conference2016, s.Conference2016name, s.Conference2017, s.Conference2017name, s.Conference2018, s.Conference2018name, s.CopytoFinancial, s.CopyPhysicaltoFinancialName
	, s.CopytoMailing, s.CopyPhysicaltoMailingName, s.CopytoMarketingEmail, s.CopytoMarketingeMailName, s.CorporateName, s.County, s.DEA_HIN, s.DEA_HINExpiration, s.DiversionCE, s.DocuSignSender
	, s.DocuSignSenderEmail, s.DocusignSenderEmailName, s.DocusignSenderName, s.DunBradstreetNo, s.EDIFTPActivation, s.EDIFTPApplicationReceived, s.EDIFTPApproved, s.FederalTaxID, s.ApplicationFeePaid
	, s.FeePaidName, s.CAHAverageGCR, s.GeneralEmail2, s.GroupNumber, s.GroupAlliance, s.GroupAllianceName, s.SaturdaysClose, s.SaturdaysOpen, s.SundaysClose, s.SundaysOpen, s.WeekdaysClose
	, s.WeekdaysOpen, s.IATVTitle, s.IncorporationState, s.IndustrySupportFund, s.IndustrySupportFundName, s.LastSalesCall, s.ManagedCareAffiliation, s.ManagedCareNetworkName, s.MarketingEmail
	, s.ManagedCareAffiliationOld, s.MCAffiliationName, s.AreteEffective, s.AreteNetwork, s.MCNetworkName, s.AreteTermination, s.AAPAppReceived, s.NCPAID, s.NCPDP, s.NPI, s.OrderingContactText
	, s.OrderingContact, s.OderingContactLookupName, s.OrganizationType, s.OrgTypeName, s.OwnerType, s.OwnerTypeName, s.PharmacistName, s.PharmacistLicense, s.PharmacistLicenseExpiration, s.PharmacyOwnerText
	, s.PharmacyOwnerEmail, s.PharmacyOwnerFax, s.PharmacyOwner, s.PharmacyOwnerLookupName, s.PharmacyOwnerPhone, s.PharmacyOwnerTitle, s.PharmacySystem, s.PharmacySystemName, s.Planogram
	, s.PlanogramName, s.PMID, s.PreviousMemberRecord, s.PreviousAAPMemberName, s.PrimaryWholesaler, s.PrimaryWholesalerNewName, s.ScanTossActivation, s.ScanTossApplicationReceived, s.ScanTossEligible
	, s.ScanTossStatus, s.ScanTossStatusName, s.ScanTossVersion, s.ScanTossVersionName, s.SendApplicationEmail, s.SendApplicationName, s.SoftwareLiabilityWaiver, s.StartUp, s.StartUpName, s.StateLicense
	, s.StateLicenseExpiration, s.StateTaxID, s.SandTBrandSmartPlus, s.SandTCloud, s.SandTCloudName, s.SandTCloudWorkstations, s.Territory, s.TerritoriesName, s.TerritoryManager, s.TerritoryManagerEmail
	, s.TerritoryManagerEmailName, s.TerritoryManagerName, s.TerritoryName, s.Owner, s.OwnerIDName, s.owneridtype, s.AAPParentID, s.parentaccountidname, s.PrimaryContact, s.primarycontactidname
	, s.StatusCodeType, s.statuscodename, s.MainPhone, s.OtherPhone, s.Telephone3, s.VersionNumber, s.Website, s.APIPMID, s.GroupNo, s.WholesalerName, s.FirstSalesDate, s.IsHistoricalRecord
	, s.ProfitAmpActivation, s.ProfitAmpLevel, s.ProfitAmpLevelName, s.ProfitAmpApplicationReceived, s.ProfitAmpSenderEmail, s.ProfitAmpSignerName, s.ProfitAmpSignerTitle, s.ProfitAmpSenderEmailName
	, s.ProfitAmpSent, s.ProfitAmpTermination, s.ProfitAmpBilling, s.ProfitAmpFee, s.APIEffectiveDate, s.APIQuitDate, s.APIEffectiveDateKey, s.APIQuitDateKey, s.AAPEffectiveDateKey, s.AAPQuitDateKey
	, s.PreviousMemberPMID, s.CorrectedCAHAccountNo
	);

	UPDATE STATISTICS [dbo].[PharmacyDim]
END
























GO
