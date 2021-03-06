USE [DynamicsODS]
GO
/****** Object:  Table [Staging].[CRM_AccountEntity_User]    Script Date: 12/22/2020 6:59:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Staging].[CRM_AccountEntity_User](
	[RowID] [int] IDENTITY(1,1) NOT NULL,
	[accountid] [uniqueidentifier] NULL,
	[new_aap_account] [nvarchar](100) NULL,
	[new_aap_effective_date] [date] NULL,
	[new_aap_resignation_reason] [int] NULL,
	[new_aap_resignation_reasonname] [nvarchar](250) NULL,
	[new_aapmembershiptype] [int] NULL,
	[new_aapmembershiptypename] [nvarchar](250) NULL,
	[new_aapparent] [nvarchar](4000) NULL,
	[new_aapparenttext] [nvarchar](100) NULL,
	[new_aapquit] [date] NULL,
	[new_aapstatus] [int] NULL,
	[new_aapstatusname] [nvarchar](250) NULL,
	[new_aaptermnotice] [date] NULL,
	[new_account_subtype] [int] NULL,
	[new_account_subtypename] [nvarchar](250) NULL,
	[new_affiliate] [int] NULL,
	[new_affiliateactive] [date] NULL,
	[new_affiliateend] [date] NULL,
	[new_affiliategroup] [int] NULL,
	[new_affiliategroupname] [nvarchar](250) NULL,
	[new_affiliatename] [nvarchar](250) NULL,
	[new_aplicor] [nvarchar](100) NULL,
	[new_applicationfeedate] [date] NULL,
	[new_applicationreceived] [date] NULL,
	[new_at_risk] [int] NULL,
	[new_at_riskname] [nvarchar](250) NULL,
	[new_authorized_voter] [nvarchar](100) NULL,
	[new_authorizedsignature] [nvarchar](100) NULL,
	[new_automation] [int] NULL,
	[new_automationname] [nvarchar](250) NULL,
	[new_averagevolume] [int] NULL,
	[new_businessclass] [int] NULL,
	[new_businessclassname] [nvarchar](250) NULL,
	[new_categoryname] [nvarchar](250) NULL,
	[new_combinedvolume] [int] NULL,
	[new_computer_software] [int] NULL,
	[new_computer_softwarename] [nvarchar](250) NULL,
	[new_conference2015] [int] NULL,
	[new_conference2015name] [nvarchar](250) NULL,
	[new_conference2016] [int] NULL,
	[new_conference2016name] [nvarchar](250) NULL,
	[new_conference2017] [int] NULL,
	[new_conference2017name] [nvarchar](250) NULL,
	[new_conference2018] [int] NULL,
	[new_conference2018name] [nvarchar](250) NULL,
	[new_copyphysicaltofinancial] [bit] NULL,
	[new_copyphysicaltofinancialname] [nvarchar](250) NULL,
	[new_copyphysicaltomailing] [bit] NULL,
	[new_copyphysicaltomailingname] [nvarchar](250) NULL,
	[new_copytomarketingemail] [bit] NULL,
	[new_copytomarketingemailname] [nvarchar](250) NULL,
	[new_corporatename] [nvarchar](100) NULL,
	[new_county] [nvarchar](100) NULL,
	[new_dea] [nvarchar](100) NULL,
	[new_deaexpiration] [date] NULL,
	[new_diversionce] [date] NULL,
	[new_docusignsender] [int] NULL,
	[new_docusignsenderemail] [int] NULL,
	[new_docusignsenderemailname] [nvarchar](250) NULL,
	[new_docusignsendername] [nvarchar](250) NULL,
	[new_dunbradstreetno] [nvarchar](100) NULL,
	[new_edi_activation_date] [date] NULL,
	[new_edi_app_received_date] [date] NULL,
	[new_edi_approved_date] [date] NULL,
	[new_fed_tax] [nvarchar](100) NULL,
	[new_fee_paid] [int] NULL,
	[new_fee_paidname] [nvarchar](250) NULL,
	[new_gcr] [decimal](28, 0) NULL,
	[new_generalemail2] [nvarchar](4000) NULL,
	[new_group] [nvarchar](100) NULL,
	[new_groupalliance] [int] NULL,
	[new_groupalliancename] [nvarchar](250) NULL,
	[new_hours_saturday_close] [nvarchar](100) NULL,
	[new_hours_saturday_open] [nvarchar](100) NULL,
	[new_hours_sunday_close] [nvarchar](100) NULL,
	[new_hours_sunday_open] [nvarchar](100) NULL,
	[new_hours_weekdays_close] [nvarchar](100) NULL,
	[new_hours_weekdays_open] [nvarchar](100) NULL,
	[new_iatvtitle] [nvarchar](100) NULL,
	[new_incorporationstate] [nvarchar](2) NULL,
	[new_industrysupportfund] [int] NULL,
	[new_industrysupportfundname] [nvarchar](250) NULL,
	[new_lastsalescall] [date] NULL,
	[new_managedcarenetwork] [int] NULL,
	[new_managedcarenetworkname] [nvarchar](250) NULL,
	[new_marketingemail] [nvarchar](100) NULL,
	[new_mc_affiliation] [int] NULL,
	[new_mc_affiliationname] [nvarchar](250) NULL,
	[new_mc_effective_date] [date] NULL,
	[new_mc_network] [int] NULL,
	[new_mc_networkname] [nvarchar](250) NULL,
	[new_mc_termination_date] [date] NULL,
	[new_memb_received_date] [date] NULL,
	[new_ncpaid] [nvarchar](8) NULL,
	[new_ncpdp] [nvarchar](7) NULL,
	[new_npi] [nvarchar](11) NULL,
	[new_orderingcontact] [nvarchar](100) NULL,
	[new_orderingcontactlookup] [uniqueidentifier] NULL,
	[new_orderingcontactlookupname] [nvarchar](100) NULL,
	[new_orderingcontactlookupyominame] [nvarchar](100) NULL,
	[new_org_type] [int] NULL,
	[new_org_typename] [nvarchar](250) NULL,
	[new_ownertype] [int] NULL,
	[new_ownertypename] [nvarchar](250) NULL,
	[new_parentaccounttext] [nvarchar](100) NULL,
	[new_pharmacist] [nvarchar](100) NULL,
	[new_pharmacistlicense] [nvarchar](100) NULL,
	[new_pharmacistlicenseexpiration] [date] NULL,
	[new_pharmacyowner] [nvarchar](100) NULL,
	[new_pharmacyowneremail] [nvarchar](100) NULL,
	[new_pharmacyownerfax] [nvarchar](12) NULL,
	[new_pharmacyownerlookup] [uniqueidentifier] NULL,
	[new_pharmacyownerlookupname] [nvarchar](100) NULL,
	[new_pharmacyownerlookupyominame] [nvarchar](100) NULL,
	[new_pharmacyownerphone] [nvarchar](12) NULL,
	[new_pharmacyownertitle] [nvarchar](100) NULL,
	[new_pharmacysystem] [int] NULL,
	[new_pharmacysystemname] [nvarchar](250) NULL,
	[new_planogram] [int] NULL,
	[new_planogramname] [nvarchar](250) NULL,
	[new_planogramquit] [date] NULL,
	[new_planogramstart] [date] NULL,
	[new_pmid] [nvarchar](100) NULL,
	[new_previousaapmember] [uniqueidentifier] NULL,
	[new_previousaapmembername] [nvarchar](100) NULL,
	[new_previousaapmemberyominame] [nvarchar](100) NULL,
	[new_previousgroupalliance] [int] NULL,
	[new_previousgroupalliancename] [nvarchar](250) NULL,
	[new_previousprimarywholesaler] [int] NULL,
	[new_previousprimarywholesalername] [nvarchar](250) NULL,
	[new_previouswholesaler] [int] NULL,
	[new_previouswholesaleraccountno] [nvarchar](100) NULL,
	[new_previouswholesalername] [nvarchar](250) NULL,
	[new_primarycontact] [nvarchar](100) NULL,
	[new_primarywholesaleraccountno] [nvarchar](100) NULL,
	[new_primarywholesalernew] [int] NULL,
	[new_primarywholesalernewname] [nvarchar](250) NULL,
	[new_sendapplicationemail] [nvarchar](100) NULL,
	[new_sendapplicationname] [nvarchar](100) NULL,
	[new_softwareliabilitywaiver] [date] NULL,
	[new_startup] [int] NULL,
	[new_startupname] [nvarchar](250) NULL,
	[new_state_lic] [nvarchar](100) NULL,
	[new_state_lic_exp_date] [date] NULL,
	[new_state_tax] [nvarchar](100) NULL,
	[new_stbrandsmartplus] [int] NULL,
	[new_stcloud] [bit] NULL,
	[new_stcloudname] [nvarchar](250) NULL,
	[new_stcloudworkstations] [nvarchar](3) NULL,
	[new_territories] [int] NULL,
	[new_territoriesname] [nvarchar](250) NULL,
	[new_territory] [int] NULL,
	[new_territorymanager] [int] NULL,
	[new_territorymanageremail] [int] NULL,
	[new_territorymanageremailname] [nvarchar](250) NULL,
	[new_territorymanagername] [nvarchar](250) NULL,
	[new_territoryname] [nvarchar](250) NULL,
	[new_wholesaler] [int] NULL,
	[new_wholesalername] [nvarchar](250) NULL,
	[new_businessestablished] [date] NULL,
	[new_controlledsubstancesprofile] [int] NULL,
	[new_controlledsubstancesprofilename] [nvarchar](250) NULL,
	[new_creditreportauth] [int] NULL,
	[new_creditreportauthname] [nvarchar](250) NULL,
	[new_deahinissue] [date] NULL,
	[new_historicalrecord] [bit] NULL,
	[new_lastvisit] [datetime] NULL,
	[new_lastvisitdate] [datetime] NULL,
	[new_lastvisitrollup] [datetime] NULL,
	[new_lastvisitrollup_date] [datetime] NULL,
	[new_lastvisitrollup_state] [int] NULL,
	[new_marketinglevel] [int] NULL,
	[new_marketinglevelname] [nvarchar](250) NULL,
	[new_ownershipchange] [int] NULL,
	[new_ownershipchangename] [nvarchar](250) NULL,
	[new_personalguaranty] [int] NULL,
	[new_personalguarantyname] [nvarchar](250) NULL,
	[new_powerofattorney] [int] NULL,
	[new_powerofattorneyname] [nvarchar](250) NULL,
	[new_rebatepaymentmethod] [int] NULL,
	[new_rebatepaymentmethodname] [nvarchar](250) NULL,
	[new_sendapplicationtitle] [nvarchar](100) NULL,
	[new_triggerapionboarding] [bit] NULL,
	[new_triggerapionboardingname] [nvarchar](250) NULL,
	[new_vai] [nvarchar](7) NULL,
	[new_zone] [int] NULL,
	[new_zonename] [nvarchar](250) NULL,
	[new_conference2019] [int] NULL,
	[new_conference2019name] [nvarchar](250) NULL,
	[new_deapharmacyname] [nvarchar](50) NULL,
	[new_heyrman] [int] NULL,
	[new_heyrmanname] [nvarchar](250) NULL,
	[new_pharmacyownermobilephone] [nvarchar](12) NULL,
	[new_referralincentivedate] [date] NULL,
	[new_referralincentivepaid] [date] NULL,
	[new_referralincentivestatus] [int] NULL,
	[new_referralincentivestatusname] [nvarchar](250) NULL,
	[new_referralstatus] [int] NULL,
	[new_referralstatusname] [nvarchar](250) NULL,
	[new_referralsubmissiondate] [date] NULL,
	[new_referringpharmacy] [uniqueidentifier] NULL,
	[new_referringpharmacyemail] [nvarchar](100) NULL,
	[new_referringpharmacyname] [nvarchar](100) NULL,
	[new_referringpharmacyyominame] [nvarchar](100) NULL,
	[new_secondaryphone] [nvarchar](50) NULL,
	[new_specialty] [int] NULL,
	[new_specialtyname] [nvarchar](250) NULL,
	[new_description] [nvarchar](4000) NULL,
	[new_historicalrecordname] [varchar](500) NULL,
	[DateKey] [int] NULL,
	[RowCreatedDate] [datetime] NOT NULL,
	[new_cahcsosaccount] [nvarchar](250) NULL,
	[new_websitelogin] [nvarchar](250) NULL,
	[new_websitepassword] [nvarchar](250) NULL,
	[new_categorynewname] [nvarchar](500) NULL,
	[new_categorynew] [int] NULL,
	[new_category] [int] NULL,
	[new_membershipowner] [nvarchar](250) NULL,
	[new_previousmemberpmid] [int] NULL,
 CONSTRAINT [CPK_Staging_CRM_AccountEntity_User] PRIMARY KEY CLUSTERED 
(
	[RowID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [AK_Staging_CRM_AccountEntity_User] UNIQUE NONCLUSTERED 
(
	[accountid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [Staging].[CRM_AccountEntity_User] ADD  DEFAULT (getdate()) FOR [RowCreatedDate]
GO
