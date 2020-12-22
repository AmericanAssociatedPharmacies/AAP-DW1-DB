USE [IOSDDS]
GO
/****** Object:  Table [Staging].[PharmacyDim]    Script Date: 12/22/2020 7:05:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Staging].[PharmacyDim](
	[PharmacyKey] [int] NOT NULL,
	[Classification] [int] NULL,
	[AccountClassificationCodename] [varchar](250) NULL,
	[AccountID] [uniqueidentifier] NULL,
	[Createdbyname] [varchar](250) NULL,
	[CreatedOn] [datetime] NULL,
	[CreditLimit] [money] NULL,
	[CreditLimitBase] [money] NULL,
	[CreditHold] [bit] NULL,
	[Creditonholdname] [varchar](250) NULL,
	[DonotallowBulkEmails] [bit] NULL,
	[DonotallowBulkMails] [bit] NULL,
	[DonotallowEmails] [bit] NULL,
	[DonotallowFaxes] [bit] NULL,
	[DonotallowPhoneCalls] [bit] NULL,
	[DonotallowMails] [bit] NULL,
	[SendMarketingMaterials] [bit] NULL,
	[GeneralEmail] [varchar](250) NULL,
	[FinancialEmail] [varchar](250) NULL,
	[ExecutiveEmail] [varchar](250) NULL,
	[Fax] [varchar](250) NULL,
	[ModifiedBy] [uniqueidentifier] NULL,
	[modifiedbyname] [varchar](250) NULL,
	[ModifiedOn] [datetime] NULL,
	[ModifiedByDelegate] [uniqueidentifier] NULL,
	[modifiedonbehalfbyname] [varchar](250) NULL,
	[PharmacyName] [varchar](250) NULL,
	[AAPNumber] [varchar](250) NULL,
	[AAPEffectiveDate] [date] NULL,
	[ResignationReason] [int] NULL,
	[AAPResignationReasonname] [varchar](250) NULL,
	[AAPMembershipType] [int] NULL,
	[AAPMembershipTypeName] [varchar](250) NULL,
	[AAPParent] [varchar](250) NULL,
	[AAPParentText] [varchar](250) NULL,
	[AAPQuitDate] [date] NULL,
	[AAPStatus] [int] NULL,
	[AAPStatusName] [varchar](250) NULL,
	[AAPTermNotice] [date] NULL,
	[AccountSubType] [int] NULL,
	[AccountSubtypename] [varchar](250) NULL,
	[Affiliate] [int] NULL,
	[AffiliateActive] [date] NULL,
	[AffiliateEnd] [date] NULL,
	[AffiliateGroup] [int] NULL,
	[Affiliategroupname] [varchar](250) NULL,
	[Affiliatename] [varchar](250) NULL,
	[APINumber] [varchar](250) NULL,
	[ApplicationtoCredit] [date] NULL,
	[APIApplicationStatus] [int] NULL,
	[APIAppStatusname] [varchar](250) NULL,
	[ApplicationApproved] [date] NULL,
	[CSOSApproved] [date] NULL,
	[CSOSDeclined] [date] NULL,
	[CSOSInstalled] [date] NULL,
	[CSOSQuestionniareReceived] [date] NULL,
	[APIOrderCutOff] [int] NULL,
	[APICutoffname] [varchar](250) NULL,
	[APIPrimaryOrderMethod] [int] NULL,
	[APIOrderMethodname] [varchar](250) NULL,
	[PhotosReceived] [date] NULL,
	[APIPaymentTerms] [int] NULL,
	[APITermsName] [varchar](250) NULL,
	[APIAccountActivation] [date] NULL,
	[APIAlert] [int] NULL,
	[APIAlertName] [varchar](250) NULL,
	[APIBrands] [int] NULL,
	[APICreditAlert] [int] NULL,
	[APICreditAlertName] [varchar](250) NULL,
	[APICreditLimit] [int] NULL,
	[CSOSAlert] [int] NULL,
	[APICSOSAlertName] [varchar](250) NULL,
	[CSOSStatus] [int] NULL,
	[APICSOSStatusName] [varchar](250) NULL,
	[APIDefaultShipping] [int] NULL,
	[APIDefaultShippingName] [varchar](250) NULL,
	[APIFreight] [int] NULL,
	[APIFreightName] [varchar](250) NULL,
	[APIGenerics] [int] NULL,
	[APIMOT] [int] NULL,
	[APImotname] [varchar](250) NULL,
	[APIOTCs] [int] NULL,
	[APIPaymentMethod] [int] NULL,
	[APIPaymentMethodName] [varchar](250) NULL,
	[APIQuestionniare] [int] NULL,
	[APIQuestionniareName] [varchar](250) NULL,
	[APIRefrigerated] [bit] NULL,
	[APIRefrigeratedName] [varchar](250) NULL,
	[APIStatus] [int] NULL,
	[APIStatusName] [varchar](250) NULL,
	[APITotals] [int] NULL,
	[APIWarehouse] [int] NULL,
	[APIWarehouseName] [varchar](250) NULL,
	[AplicorNumber] [varchar](250) NULL,
	[ApplicationFeeDate] [date] NULL,
	[APIAppReceived] [date] NULL,
	[AtRisk] [int] NULL,
	[AtRiskName] [varchar](250) NULL,
	[IATV] [varchar](250) NULL,
	[AuthorizedSignature] [varchar](250) NULL,
	[Automation] [int] NULL,
	[AutomationName] [varchar](250) NULL,
	[AverageVolume] [int] NULL,
	[BusinessClass] [int] NULL,
	[BusinessClassName] [varchar](250) NULL,
	[CAHPrimaryAccount] [varchar](250) NULL,
	[CAHAvgMonthlyVolume] [int] NULL,
	[CAHCostofGoods] [decimal](18, 0) NULL,
	[CAHContractedDSO] [decimal](18, 0) NULL,
	[CAHPotentialMonthlyVolume] [int] NULL,
	[CAHPaymentTerms] [int] NULL,
	[CAHTermsName] [varchar](250) NULL,
	[CAHContractDate] [date] NULL,
	[CAHEffDateNewAgreement] [date] NULL,
	[CAHLastReview] [date] NULL,
	[CAHMatrix] [int] NULL,
	[new_cahpvamatrixname] [varchar](250) NULL,
	[CAHReviewType] [int] NULL,
	[CAH_PVA_ReviewTypeName] [varchar](250) NULL,
	[CAHStatus] [int] NULL,
	[CAH_PVA_Statusname] [varchar](250) NULL,
	[CAHTermCode] [int] NULL,
	[CAH_PVA_TermCodeName] [varchar](250) NULL,
	[CAHTermComments] [varchar](250) NULL,
	[CAHTermDate] [date] NULL,
	[Category] [int] NULL,
	[CategoryName] [varchar](250) NULL,
	[CombinedVolume] [int] NULL,
	[Conference2015] [int] NULL,
	[Conference2015name] [varchar](250) NULL,
	[Conference2016] [int] NULL,
	[Conference2016name] [varchar](250) NULL,
	[Conference2017] [int] NULL,
	[Conference2017name] [varchar](250) NULL,
	[Conference2018] [int] NULL,
	[Conference2018name] [varchar](250) NULL,
	[CopytoFinancial] [bit] NULL,
	[CopyPhysicaltoFinancialName] [varchar](250) NULL,
	[CopytoMailing] [bit] NULL,
	[CopyPhysicaltoMailingName] [varchar](250) NULL,
	[CopytoMarketingEmail] [bit] NULL,
	[CopytoMarketingeMailName] [varchar](250) NULL,
	[CorporateName] [varchar](250) NULL,
	[County] [varchar](250) NULL,
	[DEA_HIN] [varchar](250) NULL,
	[DEA_HINExpiration] [date] NULL,
	[DiversionCE] [date] NULL,
	[DocuSignSender] [int] NULL,
	[DocuSignSenderEmail] [int] NULL,
	[DocusignSenderEmailName] [varchar](250) NULL,
	[DocusignSenderName] [varchar](250) NULL,
	[DunBradstreetNo] [varchar](250) NULL,
	[EDIFTPActivation] [date] NULL,
	[EDIFTPApplicationReceived] [date] NULL,
	[EDIFTPApproved] [date] NULL,
	[FederalTaxID] [varchar](250) NULL,
	[ApplicationFeePaid] [int] NULL,
	[FeePaidName] [varchar](250) NULL,
	[CAHAverageGCR] [decimal](18, 0) NULL,
	[GeneralEmail2] [varchar](250) NULL,
	[GroupNumber] [varchar](250) NULL,
	[GroupAlliance] [int] NULL,
	[GroupAllianceName] [varchar](250) NULL,
	[SaturdaysClose] [varchar](250) NULL,
	[SaturdaysOpen] [varchar](250) NULL,
	[SundaysClose] [varchar](250) NULL,
	[SundaysOpen] [varchar](250) NULL,
	[WeekdaysClose] [varchar](250) NULL,
	[WeekdaysOpen] [varchar](250) NULL,
	[IATVTitle] [varchar](250) NULL,
	[IncorporationState] [varchar](250) NULL,
	[IndustrySupportFund] [int] NULL,
	[IndustrySupportFundName] [varchar](250) NULL,
	[LastSalesCall] [date] NULL,
	[ManagedCareAffiliation] [int] NULL,
	[ManagedCareNetworkName] [varchar](250) NULL,
	[MarketingEmail] [varchar](250) NULL,
	[ManagedCareAffiliationOld] [int] NULL,
	[MCAffiliationName] [varchar](250) NULL,
	[AreteEffective] [date] NULL,
	[AreteNetwork] [int] NULL,
	[MCNetworkName] [varchar](250) NULL,
	[AreteTermination] [date] NULL,
	[AAPAppReceived] [date] NULL,
	[NCPAID] [varchar](250) NULL,
	[NCPDP] [varchar](250) NULL,
	[NPI] [varchar](250) NULL,
	[OrderingContactText] [varchar](250) NULL,
	[OrderingContact] [uniqueidentifier] NULL,
	[OderingContactLookupName] [varchar](250) NULL,
	[OrganizationType] [int] NULL,
	[OrgTypeName] [varchar](250) NULL,
	[OwnerType] [int] NULL,
	[OwnerTypeName] [varchar](250) NULL,
	[PharmacistName] [varchar](250) NULL,
	[PharmacistLicense] [varchar](250) NULL,
	[PharmacistLicenseExpiration] [date] NULL,
	[PharmacyOwnerText] [varchar](250) NULL,
	[PharmacyOwnerEmail] [varchar](250) NULL,
	[PharmacyOwnerFax] [varchar](250) NULL,
	[PharmacyOwner] [uniqueidentifier] NULL,
	[PharmacyOwnerLookupName] [varchar](250) NULL,
	[PharmacyOwnerPhone] [varchar](250) NULL,
	[PharmacyOwnerTitle] [varchar](250) NULL,
	[PharmacySystem] [int] NULL,
	[new_pharmacysystemname] [varchar](250) NULL,
	[Planogram] [int] NULL,
	[PlanogramName] [varchar](250) NULL,
	[PMID] [int] NOT NULL,
	[PreviousMemberRecord] [uniqueidentifier] NULL,
	[PreviousAAPMemberMame] [varchar](250) NULL,
	[PrimaryWholesaler] [int] NULL,
	[PrimaryWholesalerNewName] [varchar](250) NULL,
	[ScanTossActivation] [date] NULL,
	[ScanTossApplicationReceived] [date] NULL,
	[ScanTossEligible] [date] NULL,
	[ScanTossStatus] [int] NULL,
	[ScanTossStatusName] [varchar](250) NULL,
	[ScanTossVersion] [int] NULL,
	[ScanTossVersionName] [varchar](250) NULL,
	[SendApplicationEmail] [varchar](250) NULL,
	[SendApplicationName] [varchar](250) NULL,
	[SoftwareLiabilityWaiver] [date] NULL,
	[StartUp] [int] NULL,
	[StartUpName] [varchar](250) NULL,
	[StateLicense] [varchar](250) NULL,
	[StateLicenseExpiration] [date] NULL,
	[StateTaxID] [varchar](250) NULL,
	[SandTBrandSmartPlus] [int] NULL,
	[SandTCloud] [bit] NULL,
	[SandTCloudName] [varchar](250) NULL,
	[SandTCloudWorkstations] [varchar](250) NULL,
	[Territory] [int] NULL,
	[TerritoriesName] [varchar](250) NULL,
	[TerritoryManager] [int] NULL,
	[TerritoryManagerEmail] [int] NULL,
	[TerritoryManagerEmailName] [varchar](250) NULL,
	[TerritoryManagerName] [varchar](250) NULL,
	[TerritoryName] [varchar](250) NULL,
	[Owner] [uniqueidentifier] NULL,
	[OwnerIDName] [varchar](250) NULL,
	[owneridtype] [varchar](250) NULL,
	[AAPParentID] [uniqueidentifier] NULL,
	[parentaccountidname] [varchar](250) NULL,
	[PrimaryContact] [uniqueidentifier] NULL,
	[primarycontactidname] [varchar](250) NULL,
	[StatusCodeType] [int] NULL,
	[statuscodename] [varchar](250) NULL,
	[MainPhone] [varchar](250) NULL,
	[OtherPhone] [varchar](250) NULL,
	[Telephone3] [varchar](250) NULL,
	[VersionNumber] [bigint] NULL,
	[Website] [varchar](250) NULL,
	[APIPMID] [int] NULL,
	[GroupNo] [varchar](250) NULL,
	[WholesalerName] [varchar](250) NULL,
	[IsCurrent] [bit] NOT NULL,
	[StartDateKey] [int] NOT NULL,
	[EndDateKey] [int] NOT NULL,
	[RowCreatedDate] [datetime] NOT NULL,
	[RowVersionID] [varbinary](8) NOT NULL,
	[FirstSalesDate] [date] NOT NULL,
	[IsHistoricalRecord] [bit] NOT NULL,
 CONSTRAINT [CPK_Staging_PharmacyDim] PRIMARY KEY CLUSTERED 
(
	[PharmacyKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [Staging].[PharmacyDim] ADD  DEFAULT (getdate()) FOR [RowCreatedDate]
GO
ALTER TABLE [Staging].[PharmacyDim] ADD  DEFAULT ('19000101') FOR [FirstSalesDate]
GO
ALTER TABLE [Staging].[PharmacyDim] ADD  DEFAULT ((0)) FOR [IsHistoricalRecord]
GO
