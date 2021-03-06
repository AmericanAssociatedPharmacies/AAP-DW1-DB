USE [RXMaster]
GO
/****** Object:  View [Staging].[vwPharmacyDim_old_20190122]    Script Date: 12/22/2020 7:53:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO












CREATE VIEW [Staging].[vwPharmacyDim_old_20190122]

AS


SELECT CONVERT(int, accountclassificationcode) AS Classification
, CONVERT(VARCHAR(250), LTRIM(RTRIM(accountclassificationcodename))) AS AccountClassificationCodename
, CONVERT(uniqueidentifier, accountid) AS AccountID
, CONVERT(VARCHAR(250), LTRIM(RTRIM(createdbyname))) AS Createdbyname
, CONVERT(datetime, createdon) AS CreatedOn
, CONVERT(money, creditlimit) AS CreditLimit
, CONVERT(money, creditlimit_base) AS CreditLimitBase
, CONVERT(bit, creditonhold) AS CreditHold
, CONVERT(VARCHAR(250), LTRIM(RTRIM(creditonholdname))) AS Creditonholdname
, CONVERT(bit, donotbulkemail) AS DonotallowBulkEmails
, CONVERT(bit, donotbulkpostalmail) AS DonotallowBulkMails
, CONVERT(bit, donotemail) AS DonotallowEmails
, CONVERT(bit, donotfax) AS DonotallowFaxes
, CONVERT(bit, donotphone) AS DonotallowPhoneCalls
, CONVERT(bit, donotpostalmail) AS DonotallowMails
, CONVERT(bit, donotsendmm) AS SendMarketingMaterials
, CONVERT(VARCHAR(250), LTRIM(RTRIM(emailaddress1))) AS GeneralEmail
, CONVERT(VARCHAR(250), LTRIM(RTRIM(emailaddress2))) AS FinancialEmail
, CONVERT(VARCHAR(250), LTRIM(RTRIM(emailaddress3))) AS ExecutiveEmail
, CONVERT(VARCHAR(250), LTRIM(RTRIM(fax))) AS Fax
, CONVERT(uniqueidentifier, modifiedby) AS ModifiedBy
, CONVERT(VARCHAR(250), LTRIM(RTRIM(modifiedbyname))) AS modifiedbyname
, CONVERT(datetime, modifiedon) AS ModifiedOn
, CONVERT(uniqueidentifier, modifiedonbehalfby) AS ModifiedByDelegate
, CONVERT(VARCHAR(250), LTRIM(RTRIM(modifiedonbehalfbyname))) AS modifiedonbehalfbyname
, CONVERT(VARCHAR(250), LTRIM(RTRIM(name))) AS PharmacyName
, CONVERT(VARCHAR(250), LTRIM(RTRIM(new_aap_account))) AS AAPNumber
, CONVERT(date, new_aap_effective_date) AS AAPEffectiveDate
, CONVERT(int, new_aap_resignation_reason) AS ResignationReason
, CONVERT(VARCHAR(250), LTRIM(RTRIM(new_aap_resignation_reasonname))) AS AAPResignationReasonname
, CONVERT(int, new_aapmembershiptype) AS AAPMembershipType
, CONVERT(VARCHAR(250), LTRIM(RTRIM(new_aapmembershiptypename))) AS AAPMembershipTypeName
, CONVERT(VARCHAR(250), LTRIM(RTRIM(new_aapparent))) AS AAPParent
, CONVERT(VARCHAR(250), LTRIM(RTRIM(new_aapparenttext))) AS AAPParentText
, CONVERT(date, new_aapquit) AS AAPQuitDate
, CONVERT(int, new_aapstatus) AS AAPStatus
, CONVERT(VARCHAR(250), LTRIM(RTRIM(new_aapstatusname))) AS AAPStatusName
, CONVERT(date, new_aaptermnotice) AS AAPTermNotice
, CONVERT(int, new_account_subtype) AS AccountSubType
, CONVERT(VARCHAR(250), LTRIM(RTRIM(new_account_subtypename))) AS AccountSubtypename
, CONVERT(int, new_affiliate) AS Affiliate
, CONVERT(date, new_affiliateactive) AS AffiliateActive
, CONVERT(date, new_affiliateend) AS AffiliateEnd
, CONVERT(int, new_affiliategroup) AS AffiliateGroup
, CONVERT(VARCHAR(250), LTRIM(RTRIM(new_affiliategroupname))) AS Affiliategroupname
, CONVERT(VARCHAR(250), LTRIM(RTRIM(new_affiliatename))) AS Affiliatename
, CONVERT(VARCHAR(250), LTRIM(RTRIM(new_api_account))) AS APINumber
, CONVERT(date, new_api_app_credit_date) AS ApplicationtoCredit
, CONVERT(int, new_api_app_status) AS APIApplicationStatus
, CONVERT(VARCHAR(250), LTRIM(RTRIM(new_api_app_statusname))) AS APIAppStatusname
, CONVERT(date, new_api_approved_date) AS ApplicationApproved
, CONVERT(date, new_api_csos_approved_date) AS CSOSApproved
, CONVERT(date, new_api_csos_declined_date) AS CSOSDeclined
, CONVERT(date, new_api_csos_installed_date) AS CSOSInstalled
, CONVERT(date, new_api_csos_profile_received_date) AS CSOSQuestionniareReceived
, CONVERT(int, new_api_cutoff) AS APIOrderCutOff
, CONVERT(VARCHAR(250), LTRIM(RTRIM(new_api_cutoffname))) AS APICutoffname
, CONVERT(int, new_api_order_method) AS APIPrimaryOrderMethod
, CONVERT(VARCHAR(250), LTRIM(RTRIM(new_api_order_methodname))) AS APIOrderMethodname
, CONVERT(date, new_api_photos_received_date) AS PhotosReceived
, CONVERT(int, new_api_terms) AS APIPaymentTerms
, CONVERT(VARCHAR(250), LTRIM(RTRIM(new_api_termsname))) AS APITermsName
, CONVERT(date, new_apiaccountactivation) AS APIAccountActivation
, CONVERT(int, new_apialert) AS APIAlert
, CONVERT(VARCHAR(250), LTRIM(RTRIM(new_apialertname))) AS APIAlertName
, CONVERT(int, new_apibrands) AS APIBrands
, CONVERT(int, new_apicreditalert) AS APICreditAlert
, CONVERT(VARCHAR(250), LTRIM(RTRIM(new_apicreditalertname))) AS APICreditAlertName
, CONVERT(int, new_apicreditlimit) AS APICreditLimit
, CONVERT(int, new_apicsosalert) AS CSOSAlert
, CONVERT(VARCHAR(250), LTRIM(RTRIM(new_apicsosalertname))) AS APICSOSAlertName
, CONVERT(int, new_apicsosstatus) AS CSOSStatus
, CONVERT(VARCHAR(250), LTRIM(RTRIM(new_apicsosstatusname))) AS APICSOSStatusName
, CONVERT(int, new_apidefaultshipping) AS APIDefaultShipping
, CONVERT(VARCHAR(250), LTRIM(RTRIM(new_apidefaultshippingname))) AS APIDefaultShippingName
, CONVERT(int, new_apifreight) AS APIFreight
, CONVERT(VARCHAR(250), LTRIM(RTRIM(new_apifreightname))) AS APIFreightName
, CONVERT(int, new_apigenerics) AS APIGenerics
, CONVERT(int, new_apimot) AS APIMOT
, CONVERT(VARCHAR(250), LTRIM(RTRIM(new_apimotname))) AS APImotname
, CONVERT(int, new_apiotcs) AS APIOTCs
, CONVERT(int, new_apipaymentmethod) AS APIPaymentMethod
, CONVERT(VARCHAR(250), LTRIM(RTRIM(new_apipaymentmethodname))) AS APIPaymentMethodName
, CONVERT(int, new_apiquestionniare) AS APIQuestionniare
, CONVERT(VARCHAR(250), LTRIM(RTRIM(new_apiquestionniarename))) AS APIQuestionniareName
, CONVERT(bit, new_apirefrigerated) AS APIRefrigerated
, CONVERT(VARCHAR(250), LTRIM(RTRIM(new_apirefrigeratedname))) AS APIRefrigeratedName
, CONVERT(int, new_apistatus) AS APIStatus
, CONVERT(VARCHAR(250), LTRIM(RTRIM(new_apistatusname))) AS APIStatusName
, CONVERT(int, new_apitotals) AS APITotals
, CONVERT(int, new_apiwarehouse) AS APIWarehouse
, CONVERT(VARCHAR(250), LTRIM(RTRIM(new_apiwarehousename))) AS APIWarehouseName
, CONVERT(VARCHAR(250), LTRIM(RTRIM(new_aplicor))) AS AplicorNumber
, CONVERT(date, new_applicationfeedate) AS ApplicationFeeDate
, CONVERT(date, new_applicationreceived) AS APIAppReceived
, CONVERT(int, new_at_risk) AS AtRisk
, CONVERT(VARCHAR(250), LTRIM(RTRIM(new_at_riskname))) AS AtRiskName
, CONVERT(VARCHAR(250), LTRIM(RTRIM(new_authorized_voter))) AS IATV
, CONVERT(VARCHAR(250), LTRIM(RTRIM(new_authorizedsignature))) AS AuthorizedSignature
, CONVERT(int, new_automation) AS Automation
, CONVERT(VARCHAR(250), LTRIM(RTRIM(new_automationname))) AS AutomationName
, CONVERT(int, new_averagevolume) AS AverageVolume
, CONVERT(int, new_businessclass) AS BusinessClass
, CONVERT(VARCHAR(250), LTRIM(RTRIM(new_businessclassname))) AS BusinessClassName
, CONVERT(VARCHAR(250), LTRIM(RTRIM(new_cah_account))) AS CAHPrimaryAccount
, CONVERT(int, new_cah_avg_volume) AS CAHAvgMonthlyVolume
, CONVERT(decimal, new_cah_cog) AS CAHCostofGoods
, CONVERT(decimal, new_cah_dso) AS CAHContractedDSO
, CONVERT(int, new_cah_potential_volume) AS CAHPotentialMonthlyVolume
, CONVERT(int, new_cah_terms) AS CAHPaymentTerms
, CONVERT(VARCHAR(250), LTRIM(RTRIM(new_cah_termsname))) AS CAHTermsName
, CONVERT(date, new_cahpvacontractdate) AS CAHContractDate
, CONVERT(date, new_cahpvaeffdatenewagreement) AS CAHEffDateNewAgreement
, CONVERT(date, new_cahpvalastreview) AS CAHLastReview
, CONVERT(int, new_cahpvamatrix) AS CAHMatrix
, CONVERT(VARCHAR(250), LTRIM(RTRIM(new_cahpvamatrixname))) AS CAHPVAMatrixName
, CONVERT(int, new_cahpvareviewtype) AS CAHReviewType
, CONVERT(VARCHAR(250), LTRIM(RTRIM(new_cahpvareviewtypename))) AS CAH_PVA_ReviewTypeName
, CONVERT(int, new_cahpvastatus) AS CAHStatus
, CONVERT(VARCHAR(250), LTRIM(RTRIM(new_cahpvastatusname))) AS CAH_PVA_Statusname
, CONVERT(int, new_cahpvatermcode) AS CAHTermCode
, CONVERT(VARCHAR(250), LTRIM(RTRIM(new_cahpvatermcodename))) AS CAH_PVA_TermCodeName
, CONVERT(VARCHAR(250), LTRIM(RTRIM(new_cahpvatermcomment))) AS CAHTermComments
, CONVERT(date, new_cahpvatermdate) AS CAHTermDate
, CONVERT(int, new_category) AS Category
, CONVERT(VARCHAR(250), LTRIM(RTRIM(new_categoryname))) AS CategoryName
, CONVERT(int, new_combinedvolume) AS CombinedVolume
, CONVERT(int, new_conference2015) AS Conference2015
, CONVERT(VARCHAR(250), LTRIM(RTRIM(new_conference2015name))) AS Conference2015name
, CONVERT(int, new_conference2016) AS Conference2016
, CONVERT(VARCHAR(250), LTRIM(RTRIM(new_conference2016name))) AS Conference2016name
, CONVERT(int, new_conference2017) AS Conference2017
, CONVERT(VARCHAR(250), LTRIM(RTRIM(new_conference2017name))) AS Conference2017name
, CONVERT(int, new_conference2018) AS Conference2018
, CONVERT(VARCHAR(250), LTRIM(RTRIM(new_conference2018name))) AS Conference2018name
, CONVERT(bit, new_copyphysicaltofinancial) AS CopytoFinancial
, CONVERT(VARCHAR(250), LTRIM(RTRIM(new_copyphysicaltofinancialname))) AS CopyPhysicaltoFinancialName
, CONVERT(bit, new_copyphysicaltomailing) AS CopytoMailing
, CONVERT(VARCHAR(250), LTRIM(RTRIM(new_copyphysicaltomailingname))) AS CopyPhysicaltoMailingName
, CONVERT(bit, new_copytomarketingemail) AS CopytoMarketingEmail
, CONVERT(VARCHAR(250), LTRIM(RTRIM(new_copytomarketingemailname))) AS CopytoMarketingeMailName
, CONVERT(VARCHAR(250), LTRIM(RTRIM(new_corporatename))) AS CorporateName
, CONVERT(VARCHAR(250), LTRIM(RTRIM(new_county))) AS County
, CONVERT(VARCHAR(250), LTRIM(RTRIM(new_dea))) AS DEA_HIN
, CONVERT(date, new_deaexpiration) AS DEA_HINExpiration
, CONVERT(date, new_diversionce) AS DiversionCE
, CONVERT(int, new_docusignsender) AS DocuSignSender
, CONVERT(int, new_docusignsenderemail) AS DocuSignSenderEmail
, CONVERT(VARCHAR(250), LTRIM(RTRIM(new_docusignsenderemailname))) AS DocusignSenderEmailName
, CONVERT(VARCHAR(250), LTRIM(RTRIM(new_docusignsendername))) AS DocusignSenderName
, CONVERT(VARCHAR(250), LTRIM(RTRIM(new_dunbradstreetno))) AS DunBradstreetNo
, CONVERT(date, new_edi_activation_date) AS EDIFTPActivation
, CONVERT(date, new_edi_app_received_date) AS EDIFTPApplicationReceived
, CONVERT(date, new_edi_approved_date) AS EDIFTPApproved
, CONVERT(VARCHAR(250), LTRIM(RTRIM(new_fed_tax))) AS FederalTaxID
, CONVERT(int, new_fee_paid) AS ApplicationFeePaid
, CONVERT(VARCHAR(250), LTRIM(RTRIM(new_fee_paidname))) AS FeePaidName
, CONVERT(decimal, new_gcr) AS CAHAverageGCR
, CONVERT(VARCHAR(250), LTRIM(RTRIM(new_generalemail2))) AS GeneralEmail2
, CONVERT(VARCHAR(250), LTRIM(RTRIM(new_group))) AS GroupNumber
, CONVERT(int, new_groupalliance) AS GroupAlliance
, CONVERT(VARCHAR(250), LTRIM(RTRIM(new_groupalliancename))) AS GroupAllianceName
, CONVERT(VARCHAR(250), LTRIM(RTRIM(new_hours_saturday_close))) AS SaturdaysClose
, CONVERT(VARCHAR(250), LTRIM(RTRIM(new_hours_saturday_open))) AS SaturdaysOpen
, CONVERT(VARCHAR(250), LTRIM(RTRIM(new_hours_sunday_close))) AS SundaysClose
, CONVERT(VARCHAR(250), LTRIM(RTRIM(new_hours_sunday_open))) AS SundaysOpen
, CONVERT(VARCHAR(250), LTRIM(RTRIM(new_hours_weekdays_close))) AS WeekdaysClose
, CONVERT(VARCHAR(250), LTRIM(RTRIM(new_hours_weekdays_open))) AS WeekdaysOpen
, CONVERT(VARCHAR(250), LTRIM(RTRIM(new_iatvtitle))) AS IATVTitle
, CONVERT(VARCHAR(250), LTRIM(RTRIM(new_incorporationstate))) AS IncorporationState
, CONVERT(int, new_industrysupportfund) AS IndustrySupportFund
, CONVERT(VARCHAR(250), LTRIM(RTRIM(new_industrysupportfundname))) AS IndustrySupportFundName
, CONVERT(date, new_lastsalescall) AS LastSalesCall
, CONVERT(int, new_managedcarenetwork) AS ManagedCareAffiliation
, CONVERT(VARCHAR(250), LTRIM(RTRIM(new_managedcarenetworkname))) AS ManagedCareNetworkName
, CONVERT(VARCHAR(250), LTRIM(RTRIM(new_marketingemail))) AS MarketingEmail
, CONVERT(int, new_mc_affiliation) AS ManagedCareAffiliationOld
, CONVERT(VARCHAR(250), LTRIM(RTRIM(new_mc_affiliationname))) AS MCAffiliationName
, CONVERT(date, new_mc_effective_date) AS AreteEffective
, CONVERT(int, new_mc_network) AS AreteNetwork
, CONVERT(VARCHAR(250), LTRIM(RTRIM(new_mc_networkname))) AS MCNetworkName
, CONVERT(date, new_mc_termination_date) AS AreteTermination
, CONVERT(date, new_memb_received_date) AS AAPAppReceived
, CONVERT(VARCHAR(250), LTRIM(RTRIM(new_ncpaid))) AS NCPAID
, CONVERT(VARCHAR(250), LTRIM(RTRIM(new_ncpdp))) AS NCPDP
, CONVERT(VARCHAR(250), LTRIM(RTRIM(new_npi))) AS NPI
, CONVERT(VARCHAR(250), LTRIM(RTRIM(new_orderingcontact))) AS OrderingContactText
, CONVERT(uniqueidentifier, new_orderingcontactlookup) AS OrderingContact
, CONVERT(VARCHAR(250), LTRIM(RTRIM(new_orderingcontactlookupname))) AS OderingContactLookupName
, CONVERT(int, new_org_type) AS OrganizationType
, CONVERT(VARCHAR(250), new_org_typename) AS OrgTypeName
, CONVERT(int, new_ownertype) AS OwnerType
, CONVERT(VARCHAR(250), LTRIM(RTRIM(new_ownertypename))) AS OwnerTypeName
, CONVERT(VARCHAR(250), LTRIM(RTRIM(new_pharmacist))) AS PharmacistName
, CONVERT(VARCHAR(250), LTRIM(RTRIM(new_pharmacistlicense))) AS PharmacistLicense
, CONVERT(date, new_pharmacistlicenseexpiration) AS PharmacistLicenseExpiration
, CONVERT(VARCHAR(250), LTRIM(RTRIM(new_pharmacyowner))) AS PharmacyOwnerText
, CONVERT(VARCHAR(250), LTRIM(RTRIM(new_pharmacyowneremail))) AS PharmacyOwnerEmail
, CONVERT(VARCHAR(250), LTRIM(RTRIM(new_pharmacyownerfax))) AS PharmacyOwnerFax
, CONVERT(uniqueidentifier, new_pharmacyownerlookup) AS PharmacyOwner
, CONVERT(VARCHAR(250), LTRIM(RTRIM(new_pharmacyownerlookupname))) AS PharmacyOwnerLookupName
, CONVERT(VARCHAR(250), LTRIM(RTRIM(new_pharmacyownerphone))) AS PharmacyOwnerPhone
, CONVERT(VARCHAR(250), LTRIM(RTRIM(new_pharmacyownertitle))) AS PharmacyOwnerTitle
, CONVERT(int, new_pharmacysystem) AS PharmacySystem
, CONVERT(VARCHAR(250), new_pharmacysystemname) AS PharmacySystemName
, CONVERT(int, new_planogram) AS Planogram
, CONVERT(VARCHAR(250), LTRIM(RTRIM(new_planogramname))) AS PlanogramName
, CONVERT(INT, LTRIM(RTRIM(new_pmid))) AS PMID
, CONVERT(uniqueidentifier, new_previousaapmember) AS PreviousMemberRecord
, CONVERT(VARCHAR(250), LTRIM(RTRIM(new_previousaapmembername))) AS PreviousAAPMemberName
, CONVERT(int, new_primarywholesalernew) AS PrimaryWholesaler
, CONVERT(VARCHAR(250), LTRIM(RTRIM(new_primarywholesalernewname))) AS PrimaryWholesalerNewName
, CONVERT(date, new_scantoss_activation_date) AS ScanTossActivation
, CONVERT(date, new_scantoss_app_received_date) AS ScanTossApplicationReceived
, CONVERT(date, new_scantoss_eligible_date) AS ScanTossEligible
, CONVERT(int, new_scantoss_status) AS ScanTossStatus
, CONVERT(VARCHAR(250), LTRIM(RTRIM(new_scantoss_statusname))) AS ScanTossStatusName
, CONVERT(int, new_scantoss_version) AS ScanTossVersion
, CONVERT(VARCHAR(250), LTRIM(RTRIM(new_scantoss_versionname))) AS ScanTossVersionName
, CONVERT(VARCHAR(250), LTRIM(RTRIM(new_sendapplicationemail))) AS SendApplicationEmail
, CONVERT(VARCHAR(250), LTRIM(RTRIM(new_sendapplicationname))) AS SendApplicationName
, CONVERT(date, new_softwareliabilitywaiver) AS SoftwareLiabilityWaiver
, CONVERT(int, new_startup) AS StartUp
, CONVERT(VARCHAR(250), LTRIM(RTRIM(new_startupname))) AS StartUpName
, CONVERT(VARCHAR(250), LTRIM(RTRIM(new_state_lic))) AS StateLicense
, CONVERT(date, new_state_lic_exp_date) AS StateLicenseExpiration
, CONVERT(VARCHAR(250), LTRIM(RTRIM(new_state_tax))) AS StateTaxID
, CONVERT(int, new_stbrandsmartplus) AS SandTBrandSmartPlus
, CONVERT(bit, new_stcloud) AS SandTCloud
, CONVERT(VARCHAR(250), LTRIM(RTRIM(new_stcloudname))) AS SandTCloudName
, CONVERT(VARCHAR(250), LTRIM(RTRIM(new_stcloudworkstations))) AS SandTCloudWorkstations
, CONVERT(int, new_territories) AS Territory
, CONVERT(VARCHAR(250), LTRIM(RTRIM(new_territoriesname))) AS TerritoriesName
, CONVERT(int, new_territorymanager) AS TerritoryManager
, CONVERT(int, new_territorymanageremail) AS TerritoryManagerEmail
, CONVERT(VARCHAR(250), LTRIM(RTRIM(new_territorymanageremailname))) AS TerritoryManagerEmailName
, CONVERT(VARCHAR(250), LTRIM(RTRIM(new_territorymanagername))) AS TerritoryManagerName
, CONVERT(VARCHAR(250), LTRIM(RTRIM(new_territoryname))) AS TerritoryName
, CONVERT(uniqueidentifier, ownerid) AS Owner
, CONVERT(VARCHAR(250), LTRIM(RTRIM(owneridname))) AS OwnerIDName
, CONVERT(VARCHAR(250), LTRIM(RTRIM(owneridtype))) AS owneridtype
, CONVERT(uniqueidentifier, parentaccountid) AS AAPParentID
, CONVERT(VARCHAR(250), parentaccountidname) AS parentaccountidname
, CONVERT(uniqueidentifier, primarycontactid) AS PrimaryContact
, CONVERT(VARCHAR(250), LTRIM(RTRIM(primarycontactidname))) AS primarycontactidname
, CONVERT(int, statuscode) AS StatusCodeType
, CONVERT(VARCHAR(250), LTRIM(RTRIM(statuscodename))) AS statuscodename
, CONVERT(VARCHAR(250), LTRIM(RTRIM(telephone1))) AS MainPhone
, CONVERT(VARCHAR(250), LTRIM(RTRIM(telephone2))) AS OtherPhone
, CONVERT(VARCHAR(250), LTRIM(RTRIM(telephone3))) AS Telephone3
, CONVERT(bigint, versionnumber) AS VersionNumber
, CONVERT(VARCHAR(250), LTRIM(RTRIM(websiteurl))) AS Website
, CONVERT(BIT, ISNULL(new_historicalrecord, 0)) AS IsHistoricalRecord
, CONVERT(DATE, new_profitampactivationdate) AS ProfitAmpActivation
, CONVERT(INT, new_profitamplevel) AS ProfitAmpLevel
, CONVERT(VARCHAR(250), new_profitamplevelname) AS ProfitAmpLevelName
, CONVERT(DATE, [new_profitampapplicationreceived]) AS ProfitAmpApplicationReceived
, CONVERT(VARCHAR(200), [new_profitampapplicationemail]) AS ProfitAmpSignerEmail
, CONVERT(VARCHAR(200), new_profitampapplicationname) AS ProfitAmpSignerName
, CONVERT(VARCHAR(200), new_profitampapplicationtitle) AS ProfitAmpSignerTitle
, CONVERT(INT, new_profitampsenderemail) AS ProfitAmpSenderEmail
, CONVERT(VARCHAR(500), new_profitampsenderemailname) AS ProfitAmpSenderEmailName
, CONVERT(DATE,new_profitampsent) AS [ProfitAmpSent]
, CONVERT(DATE, new_profitamptermination) AS ProfitAmpTermination
, CONVERT(DATE, [new_profitampbilling]) AS ProfitAmpBilling
, CONVERT(DECIMAL(28,0), [new_profitampfee] ) AS ProfitAmpFee 
FROM ODSIntake.[Staging].[CRM_AccountEntity] AS a
WHERE a.new_pmid IS NOT NULL
AND a.new_pmid <> ''












GO
