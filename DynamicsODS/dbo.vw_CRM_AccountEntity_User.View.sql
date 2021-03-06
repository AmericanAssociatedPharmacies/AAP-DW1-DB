USE [DynamicsODS]
GO
/****** Object:  View [dbo].[vw_CRM_AccountEntity_User]    Script Date: 12/22/2020 6:59:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE VIEW [dbo].[vw_CRM_AccountEntity_User]

AS

SELECT [UserKey] 
	 , [accountid] 
	 , [new_aap_account] AS AAPAccount
	 , [new_aap_effective_date] AS AAPEffectiveDate
	 , [new_aap_resignation_reason] AS AAPResignationReason
	 , [new_aap_resignation_reasonname] AS AAPResignationReasonname
	 , [new_aapmembershiptype] AS aapmembershiptype
	 , [new_aapmembershiptypename] AS aapmembershiptypename
	 , [new_aapparent] AS aapparent
	 , [new_aapparenttext] AS aapparenttext
	 , [new_aapquit] AS aapquit
	 , [new_aapstatus] AS aapstatus
	 , [new_aapstatusname] AS aapstatusname
	 , [new_aaptermnotice] AS aaptermnotice
	 , [new_account_subtype] AS AccountSubtype
	 , [new_account_subtypename] AS AccountSubtypename
	 , [new_affiliate] AS affiliate
	 , [new_affiliateactive] AS affiliateactive
	 , [new_affiliateend] AS affiliateend
	 , [new_affiliategroup] AS affiliategroup
	 , [new_affiliategroupname] AS affiliategroupname
	 , [new_affiliatename] AS affiliatename
	 , [new_aplicor] AS aplicor
	 , [new_applicationfeedate] AS applicationfeedate
	 , [new_applicationreceived] AS applicationreceived
	 , [new_at_risk] AS AtRisk
	 , [new_at_riskname] AS AtRiskname
	 , [new_authorized_voter] AS AuthorizedVoter
	 , [new_authorizedsignature] AS authorizedsignature
	 , [new_automation] AS automation
	 , [new_automationname] AS automationname
	 , [new_averagevolume] AS averagevolume
	 , [new_businessclass] AS businessclass
	 , [new_businessclassname] AS businessclassname
	 , NULL AS [new_category] 
	 , [new_categoryname] AS categoryname
	 , [new_combinedvolume] AS combinedvolume
	 , [new_computer_software] AS ComputerSoftware
	 , [new_computer_softwarename] AS ComputerSoftwarename
	 , [new_conference2015] AS conference2015
	 , [new_conference2015name] AS conference2015name
	 , [new_conference2016] AS conference2016
	 , [new_conference2016name] AS conference2016name
	 , [new_conference2017] AS conference2017
	 , [new_conference2017name] AS conference2017name
	 , [new_conference2018] AS conference2018
	 , [new_conference2018name] AS conference2018name
	 , [new_copyphysicaltofinancial] AS copyphysicaltofinancial
	 , [new_copyphysicaltofinancialname] AS copyphysicaltofinancialname
	 , [new_copyphysicaltomailing] AS copyphysicaltomailing
	 , [new_copyphysicaltomailingname] AS copyphysicaltomailingname
	 , [new_copytomarketingemail] AS copytomarketingemail
	 , [new_copytomarketingemailname] AS copytomarketingemailname
	 , [new_corporatename] AS corporatename
	 , [new_county] AS county
	 , [new_dea] AS dea
	 , [new_deaexpiration] AS deaexpiration
	 , [new_diversionce] AS diversionce
	 , [new_docusignsender] AS docusignsender
	 , [new_docusignsenderemail] AS docusignsenderemail
	 , [new_docusignsenderemailname] AS docusignsenderemailname
	 , [new_docusignsendername] AS docusignsendername
	 , [new_dunbradstreetno] AS dunbradstreetno
	 , [new_edi_activation_date] AS EdiActivationDate
	 , [new_edi_app_received_date] AS EdiAppReceivedDate
	 , [new_edi_approved_date] AS EdiApprovedDate
	 , [new_fed_tax] AS FedTax
	 , [new_fee_paid] AS FeePaid
	 , [new_fee_paidname] AS FeePaidname
	 , [new_gcr] AS gcr
	 , [new_generalemail2] AS generalemail2
	 , [new_group] AS [group]
	 , [new_groupalliance] AS groupalliance
	 , [new_groupalliancename] AS groupalliancename
	 , [new_hours_saturday_close] AS HoursSaturdayClose
	 , [new_hours_saturday_open] AS HoursSaturdayOpen
	 , [new_hours_sunday_close] AS HoursSundayClose
	 , [new_hours_sunday_open] AS HoursSundayOpen
	 , [new_hours_weekdays_close] AS HoursWeekdaysClose
	 , [new_hours_weekdays_open] AS HoursWeekdaysOpen
	 , [new_iatvtitle] AS iatvtitle
	 , [new_incorporationstate] AS incorporationstate
	 , [new_industrysupportfund] AS industrysupportfund
	 , [new_industrysupportfundname] AS industrysupportfundname
	 , [new_lastsalescall] AS lastsalescall
	 , [new_managedcarenetwork] AS managedcarenetwork
	 , [new_managedcarenetworkname] AS managedcarenetworkname
	 , [new_marketingemail] AS marketingemail
	 , [new_mc_affiliation] AS McAffiliation
	 , [new_mc_affiliationname] AS McAffiliationname
	 , [new_mc_effective_date] AS mcEffectiveDate
	 , [new_mc_network] AS McNetwork
	 , [new_mc_networkname] AS McNetworkname
	 , [new_mc_termination_date] AS McTerminationDate
	 , [new_memb_received_date] AS MembReceivedDate
	 , [new_ncpaid] AS ncpaid
	 , [new_ncpdp] AS ncpdp
	 , [new_npi] AS npi
	 , [new_orderingcontact] AS orderingcontact
	 , [new_orderingcontactlookup] AS orderingcontactlookup
	 , [new_orderingcontactlookupname] AS orderingcontactlookupname
	 , [new_orderingcontactlookupyominame] AS orderingcontactlookupyominame
	 , [new_org_type] AS OrgType
	 , [new_org_typename] AS OrgTypename
	 , [new_ownertype] AS ownertype
	 , [new_ownertypename] AS ownertypename
	 , [new_parentaccounttext] AS parentaccounttext
	 , [new_pharmacist] AS pharmacist
	 , [new_pharmacistlicense] AS pharmacistlicense
	 , [new_pharmacistlicenseexpiration] AS pharmacistlicenseexpiration
	 , [new_pharmacyowner] AS pharmacyowner
	 , [new_pharmacyowneremail] AS pharmacyowneremail
	 , [new_pharmacyownerfax] AS pharmacyownerfax
	 , [new_pharmacyownerlookup] AS pharmacyownerlookup
	 , [new_pharmacyownerlookupname] AS pharmacyownerlookupname
	 , [new_pharmacyownerlookupyominame] AS pharmacyownerlookupyominame
	 , [new_pharmacyownerphone] AS pharmacyownerphone
	 , [new_pharmacyownertitle] AS pharmacyownertitle
	 , [new_pharmacysystem] AS pharmacysystem
	 , [new_pharmacysystemname] AS pharmacysystemname
	 , [new_planogram] AS planogram
	 , [new_planogramname] AS planogramname
	 , [new_planogramquit] AS planogramquit
	 , [new_planogramstart] AS planogramstart
	 , [new_pmid] AS pmid
	 , [new_previousaapmember] AS previousaapmember
	 , [new_previousaapmembername] AS previousaapmembername
	 , [new_previousaapmemberyominame] AS previousaapmemberyominame
	 , [new_previousgroupalliance] AS previousgroupalliance
	 , [new_previousgroupalliancename] AS previousgroupalliancename
	 , [new_previousprimarywholesaler] AS previousprimarywholesaler
	 , [new_previousprimarywholesalername] AS previousprimarywholesalername
	 , [new_previouswholesaler] AS previouswholesaler
	 , [new_previouswholesaleraccountno] AS previouswholesaleraccountno
	 , [new_previouswholesalername] AS previouswholesalername
	 , [new_primarycontact] AS primarycontact
	 , [new_primarywholesaleraccountno] AS primarywholesaleraccountno
	 , [new_primarywholesalernew] AS primarywholesalernew
	 , [new_primarywholesalernewname] AS primarywholesalernewname
	 , [new_sendapplicationemail] AS sendapplicationemail 
	 , [new_sendapplicationname] AS sendapplicationname
	 , [new_softwareliabilitywaiver] AS softwareliabilitywaiver
	 , [new_startup] AS startup
	 , [new_startupname] AS startupname
	 , [new_state_lic] AS StateLic
	 , [new_state_lic_exp_date] AS StateLicExpDate
	 , [new_state_tax] AS StateTax
	 , [new_stbrandsmartplus] AS stbrandsmartplus
	 , [new_stcloud] AS stcloud
	 , [new_stcloudname] AS stcloudname
	 , [new_stcloudworkstations] AS stcloudworkstations
	 , [new_territories] AS territories
	 , [new_territoriesname] AS territoriesname
	 , [new_territory] AS territory
	 , [new_territorymanager] AS territorymanager
	 , [new_territorymanageremail] AS territorymanageremail
	 , [new_territorymanageremailname] AS territorymanageremailname
	 , [new_territorymanagername] AS territorymanagername
	 , [new_territoryname] AS territoryname
	 , [new_wholesaler] AS wholesaler
	 , [new_wholesalername] AS wholesalername
	 , [new_businessestablished] AS businessestablished
	 , [new_controlledsubstancesprofile] AS controlledsubstancesprofile
	 , [new_controlledsubstancesprofilename] AS controlledsubstancesprofilename
	 , [new_creditreportauth] AS creditreportauth
	 , [new_creditreportauthname] AS creditreportauthname
	 , [new_deahinissue] AS deahinissue
	 , [new_historicalrecord] AS historicalrecord
	 , [new_lastvisit] AS lastvisit
	 , [new_lastvisitdate] AS lastvisitdate
	 , [new_lastvisitrollup] AS lastvisitrollup
	 , [new_lastvisitrollup_date] AS LastvisitrollupDat
	 , [new_lastvisitrollup_state] AS LastvisitrollupState
	 , [new_marketinglevel] AS marketinglevel
	 , [new_marketinglevelname] AS marketinglevelname
	 , [new_ownershipchange] AS ownershipchange
	 , [new_ownershipchangename] AS ownershipchangename
	 , [new_personalguaranty] AS personalguaranty
	 , [new_personalguarantyname] AS personalguarantyname
	 , [new_powerofattorney] AS powerofattorney
	 , [new_powerofattorneyname] AS powerofattorneyname 
	 , [new_rebatepaymentmethod] AS rebatepaymentmethod
	 , [new_rebatepaymentmethodname] AS rebatepaymentmethodname
	 , [new_sendapplicationtitle] AS sendapplicationtitle
	 , [new_triggerapionboarding] AS triggerapionboarding
	 , [new_triggerapionboardingname] AS triggerapionboardingname
	 , [new_vai] AS vai
	 , [new_zone] AS zone
	 , [new_zonename] AS zonename
	 , [new_conference2019] AS conference2019
	 , [new_conference2019name] AS conference2019name
	 , [new_deapharmacyname] AS deapharmacyname
	 , [new_heyrman] AS heyrman
	 , [new_heyrmanname] AS heyrmanname
	 , [new_pharmacyownermobilephone] AS pharmacyownermobilephone
	 , [new_referralincentivedate] AS referralincentivedate
	 , [new_referralincentivepaid] AS referralincentivepaid
	 , [new_referralincentivestatus] AS referralincentivestatus
	 , [new_referralincentivestatusname] AS referralincentivestatusname
	 , [new_referralstatus] AS referralstatus
	 , [new_referralstatusname] AS referralstatusname
	 , [new_referralsubmissiondate] AS referralsubmissiondate
	 , [new_referringpharmacy] AS referringpharmacy
	 , [new_referringpharmacyemail] AS referringpharmacyemail
	 , [new_referringpharmacyname] AS referringpharmacyname
	 , [new_referringpharmacyyominame] AS referringpharmacyyominame
	 , [new_secondaryphone] AS secondaryphone
	 , [new_specialty] AS specialty
	 , [new_specialtyname] AS specialtyname
	 , [new_description] AS description
	 , [new_historicalrecordname] AS historicalrecordname
	 , [DateKey] 
	 , [RowCreatedDate] 
	 , [RowUpdatedDate] 
	 , [new_cahcsosaccount] AS cahcsosaccount
	 , [new_websitelogin] AS websitelogin
	 , [new_websitepassword] AS websitepassword
	 , [new_categorynewname] AS categorynewname
	 , new_categorynew AS categorynew
FROM [dbo].[CRM_AccountEntity_User]





GO
