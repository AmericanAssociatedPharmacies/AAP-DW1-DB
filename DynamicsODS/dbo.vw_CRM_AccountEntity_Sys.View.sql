USE [DynamicsODS]
GO
/****** Object:  View [dbo].[vw_CRM_AccountEntity_Sys]    Script Date: 12/22/2020 6:59:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[vw_CRM_AccountEntity_Sys]

AS

SELECT [SysKey] 
	 , [accountcategorycode] AS AccountCategoryCode
	 , [accountcategorycodename] AS AccountCategoryCodeName
	 , [accountclassificationcode] AS AccountClassificationCode
	 , [accountclassificationcodename] AS AccountClassificationCodeName 
	 , [accountid] AS AccountId
	 , [accountnumber] AS AccountNumber
	 , [accountratingcode] AS AccountRatingCode 
	 , [accountratingcodename] AS AccountRatingCodeName
	 , [aging30] AS Aging30
	 , [aging30_base] AS Aging30Base
	 , [aging60] AS Aging60
	 , [aging60_base] AS Aging60Base
	 , [aging90] AS Aging90
	 , [aging90_base] AS Aging90Base
	 , [businesstypecode] AS BusinessTypeCode 
	 , [businesstypecodename] AS BusinessTypeCodeName
	 , [createdby] AS CreatedBy
	 , [createdbyexternalparty] AS CreatedByExternalParty
	 , [createdbyexternalpartyname] AS CreatedByExternalPartyName
	 , [createdbyexternalpartyyominame] AS CreatedByExternalPartyYomiName
	 , [createdbyname] AS CreatedByName
	 , [createdbyyominame] AS CreatedByYomiName
	 , [createdon] AS Createdon
	 , [createdonbehalfby] AS CreatedonBehalfBy
	 , [createdonbehalfbyname] AS CreatedOnBehalfByName
	 , [createdonbehalfbyyominame] AS CreatedOnBehalfByYomiName
	 , [creditlimit] AS CreditLimit
	 , [creditlimit_base] AS CreditLimitBase
	 , [creditonhold] AS CreditOnHold
	 , [creditonholdname] AS CreditOnHoldName
	 , [customersizecode] AS CustomerSizeCode 
	 , [customersizecodename] AS CustomerSizeCodeName
	 , [customertypecode] AS CustomerTypeCode
	 , [customertypecodename] AS CustomerTypeCodeName
	 , [defaultpricelevelid] AS DefaultPriceLevelId
	 , [defaultpricelevelidname] AS DefaultPriceLevelIdName
	 , [description] AS Description 
	 , [donotbulkemail] AS DoNotBulkEmail 
	 , [donotbulkemailname] AS DoNotBulkEmailName  
	 , [donotbulkpostalmail] AS DoNotBulkPostalmail
	 , [donotbulkpostalmailname] AS DoNotBulkPostalmailName
	 , [donotemail] AS DoNotEmail
	 , [donotemailname] AS DoNotEmailName 
	 , [donotfax] AS DoNotFax
	 , [donotfaxname] AS DoNotFaxName
	 , [donotphone] AS DoNotPhone
	 , [donotphonename] AS DoNotPhoneName
	 , [donotpostalmail] AS DoNotPostalMail 
	 , [donotpostalmailname] AS DoNotPostalMailName
	 , [donotsendmarketingmaterialname] AS DoNotSendMarketingMaterialName
	 , [donotsendmm] AS DoNotSendmm 
	 , [entityimage_timestamp] AS EntityImageTimeStamp
	 , [entityimage_url] AS EntityImageUrl
	 , [entityimageid] AS EntityImageaId
	 , [exchangerate] AS ExchangeRate 
	 , [fax] AS Fax
	 , [followemail] AS FollowEmail
	 , [followemailname] AS FollowEmailName
	 , [ftpsiteurl] AS FTPSiteurl 
	 , [importsequencenumber] AS ImportSequenceNumber
	 , [industrycode] AS IndustryCode  
	 , [industrycodename] AS IndustryCodeName
	 , [isprivatename] AS IsPrivateName 
	 , [lastonholdtime] AS LastOnHoldTime  
	 , [lastusedincampaign] AS LastUsedInCampaign 
	 , [marketcap] AS MarketCap 
	 , [marketcap_base] AS MarketCapBase
	 , [marketingonly] AS MarketingOnly 
	 , [marketingonlyname] AS MarketingOnlyName
	 , [masteraccountidname] AS MasterAccountIdName
	 , [masteraccountidyominame] AS MasterAccountIdYomiName
	 , [masterid] AS MasterId  
	 , [merged] AS Merged  
	 , [mergedname] AS MergedName 
	 , [modifiedby] AS ModifiedBy  
	 , [modifiedbyexternalparty] AS ModifiedByExternalParty
	 , [modifiedbyexternalpartyname] AS ModifiedByExternalPartyName
	 , [modifiedbyexternalpartyyominame] AS ModifiedByExternalPartyYomiName
	 , [modifiedbyname] AS ModifiedByName 
	 , [modifiedbyyominame] AS ModifiedByYomiName
	 , [modifiedon] AS ModifiedOn
	 , [modifiedonbehalfby] AS ModifiedOnBehalfBy 
	 , [modifiedonbehalfbyname] AS ModifiedOnBehalfByName
	 , [modifiedonbehalfbyyominame] AS ModifiedOnBehalfByYomiName
	 , [name] AS Name
	 , [numberofemployees] AS NumberOfEmployees 
	 , [onholdtime] AS OnHoldTime 
	 , [opendeals] AS OpenDeals  
	 , [opendeals_date] AS OpenDealsDate
	 , [opendeals_state] AS  OpendealsState
	 , [openrevenue] AS OpenRevenue
	 , [openrevenue_base] AS OpenRevenueBase
	 , [openrevenue_date] AS  OpenRevenueDate
	 , [openrevenue_state] AS  OpenRevenueState
	 , [originatingleadid] AS OriginatingLeadId
	 , [originatingleadidname] AS OriginatingLeadIdName
	 , [originatingleadidyominame] AS OriginatingLeadIdYomiName
	 , [overriddencreatedon] AS OverRiddenCreatedOn
	 , [ownerid] AS OwnerId
	 , [owneridname] AS OwnerIdName
	 , [owneridtype] AS  OwnerIdType
	 , [owneridyominame] AS OwnerIdYomiName
	 , [ownershipcode] AS  OwnershipCode
	 , [ownershipcodename] AS OwnershipCodeName  
	 , [owningbusinessunit] AS OwningBusinessUnit
	 , [owningteam] AS OwningTeam
	 , [owninguser] AS OwningUser 
	 , [parentaccountid] AS ParentAccountId
	 , [parentaccountidname] AS ParentAccountIdname
	 , [parentaccountidyominame] AS ParentaccountIdYomiName
	 , [participatesinworkflow] AS ParticipatesinWorkFlow 
	 , [participatesinworkflowname] AS ParticipatesinworkFlowName 
	 , [paymenttermscode] AS PaymentTermsCode
	 , [paymenttermscodename] AS PaymentTermsCodeName  
	 , [preferredappointmentdaycode] AS PreferredAppointmentDayCode
	 , [preferredappointmentdaycodename] AS PreferredAppointmentdayCodeName
	 , [preferredappointmenttimecode] AS  PreferredAppointmentTimeCode
	 , [preferredappointmenttimecodename] AS PreferredAppointmentTimeCodeName
	 , [preferredcontactmethodcode] AS  PreferredContactMethodCode
	 , [preferredcontactmethodcodename] AS PreferredContactMethodCodeName
	 , [preferredequipmentid] AS  PreferredEquipmentId
	 , [preferredequipmentidname] AS PreferredEquipmentIdName 
	 , [preferredserviceid] AS PreferredServiceId
	 , [preferredserviceidname] AS PreferredServiceIdName
	 , [preferredsystemuserid] AS  PreferredSystemUserId
	 , [preferredsystemuseridname] AS PreferredSystemUserIdName
	 , [preferredsystemuseridyominame] AS PreferredSystemUserIdYomiName
	 , [primarycontactid] AS  PrimaryContactId
	 , [primarycontactidname] AS PrimaryContactIdName
	 , [primarycontactidyominame] AS PrimaryContactidYomiName
	 , [primarysatoriid] AS  PrimarySatoriId
	 , [primarytwitterid] AS  PrimaryTwitterId
	 , [processid] AS  ProcessId
	 , [revenue] AS Revenue
	 , [revenue_base] AS RevenueBase
	 , [sharesoutstanding] AS SharesOutstanding 
	 , [shippingmethodcode] AS  ShippingMethodCode
	 , [shippingmethodcodename] AS ShippingMethodCodeName 
	 , [sic] AS SIC 
	 , [slaid] AS  SlaId
	 , [slainvokedid] AS SlaInvokedId 
	 , [slainvokedidname] AS SlaInvokedIdName 
	 , [slaname] AS SlaName
	 , [stageid] AS  StageId
	 , [statecode] AS StateCode 
	 , [statecodename] AS StateCodeName 
	 , [statuscode] AS  StatusCode
	 , [statuscodename] AS StatusCodeName 
	 , [stockexchange] AS StockExchange
	 , [telephone1] AS  Telephone1
	 , [telephone2] AS  Telephone2
	 , [telephone3] AS  Telephone3
	 , [territorycode] AS  TerritoryCode
	 , [territorycodename] AS TerritoryCodeName 
	 , [territoryid] AS  TerritoryId
	 , [territoryidname] AS TerritoryIdName
	 , [tickersymbol] AS TickerSymbol
	 , [timespentbymeonemailandmeetings] AS TimeSpentBymeonEmailandMeetings
	 , [timezoneruleversionnumber] AS  TimezoneRuleVersionNumber
	 , [transactioncurrencyid] AS  TransactionCurrencyId
	 , [transactioncurrencyidname] AS TransactionCurrencyIdName
	 , [traversedpath] AS  TraversedPath
	 , [utcconversiontimezonecode] AS  UTCConversionTimezoneCode
	 , [versionnumber] AS VersionNumber
	 , [websiteurl] AS WebsiteURL 
	 , [yominame] AS  YomiName
	 , [DateKey] 
	 , [RowCreatedDate]  
	 , [RowUpdatedDate]  
	 , [RowversionID]   
FROM [dbo].[CRM_AccountEntity_Sys]

GO
