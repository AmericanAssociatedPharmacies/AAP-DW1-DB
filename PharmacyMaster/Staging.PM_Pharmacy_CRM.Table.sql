USE [PharmacyMaster]
GO
/****** Object:  Table [Staging].[PM_Pharmacy_CRM]    Script Date: 12/22/2020 7:35:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Staging].[PM_Pharmacy_CRM](
	[PMID] [int] IDENTITY(100000,1) NOT NULL,
	[PMParentID] [int] NULL,
	[AAPAccountNo] [varchar](20) NULL,
	[AAPEffectiveDate] [datetime] NULL,
	[AAPParentNo] [varchar](20) NULL,
	[AAPPreviousGroup] [varchar](50) NULL,
	[AAPQuitDate] [datetime] NULL,
	[AAPStatus] [varchar](32) NULL,
	[AccountDescription] [varchar](200) NULL,
	[AccountName] [varchar](65) NULL,
	[AllowDupDEA] [varchar](1) NULL,
	[APIAccountNo] [varchar](20) NULL,
	[APIDEA] [varchar](50) NULL,
	[APIMemberNo] [varchar](30) NULL,
	[APIPMID] [int] NULL,
	[APIStatus] [varchar](32) NULL,
	[AvgWholesaleVolume] [bigint] NULL,
	[BusinessClass] [varchar](4) NULL,
	[CAHStatus] [varchar](32) NULL,
	[CardinalDC] [varchar](32) NULL,
	[CategoryID] [int] NULL,
	[CompetitiveAcct] [smallint] NULL,
	[ComputerSoftware] [varchar](255) NULL,
	[ContractDate] [datetime] NULL,
	[CorporateName] [varchar](100) NULL,
	[CustPayTermsAPI] [varchar](20) NULL,
	[DateOpened] [datetime] NULL,
	[DBA] [varchar](100) NULL,
	[DEA] [varchar](50) NULL,
	[DEAEXP] [datetime] NULL,
	[Email] [varchar](255) NULL,
	[EmergencyPhone] [varchar](15) NULL,
	[EstMonthlyVol] [numeric](18, 2) NULL,
	[FedID] [varchar](12) NULL,
	[GroupNo] [varchar](20) NULL,
	[HolidayHours] [varchar](100) NULL,
	[Hours] [varchar](100) NULL,
	[IsHighVolume] [tinyint] NULL,
	[StoreHours_HolidayAM] [varchar](5) NULL,
	[StoreHours_HolidayPM] [varchar](5) NULL,
	[StoreHours_MondayFridayAM] [varchar](5) NULL,
	[StoreHours_MondayFridayPM] [varchar](5) NULL,
	[StoreHours_SaturdayAM] [varchar](5) NULL,
	[StoreHours_SaturdayPM] [varchar](5) NULL,
	[StoreHours_SundayAM] [varchar](5) NULL,
	[StoreHours_SundayPM] [varchar](5) NULL,
	[IsStartUpStore] [smallint] NULL,
	[NCPDP] [varchar](20) NULL,
	[NPI] [varchar](50) NULL,
	[NumReactivated] [int] NULL,
	[OrigStartDate] [datetime] NULL,
	[OwnerName] [varchar](200) NULL,
	[Payee_id] [int] NULL,
	[PrimaryCAAccountNo] [varchar](32) NULL,
	[PrimaryWholesaler] [int] NULL,
	[QPS] [varchar](4) NULL,
	[Rank] [bigint] NULL,
	[Resigned] [varchar](1) NULL,
	[Source] [varchar](25) NULL,
	[Status] [varchar](32) NULL,
	[Territory] [varchar](4) NULL,
	[UDAccountNo] [varchar](20) NULL,
	[UDNonPharmacy] [varchar](2) NULL,
	[UDParentNo] [varchar](25) NULL,
	[UDQuitDate] [datetime] NULL,
	[UDStatus] [varchar](32) NULL,
	[Website] [varchar](100) NULL,
	[Wholesaler] [varchar](25) NULL,
	[WholesalerAccountNo] [varchar](32) NULL,
	[WhyResigned] [varchar](255) NULL,
	[IsBuyingGroup] [smallint] NULL,
	[IsPos] [smallint] NULL,
	[IsPva] [smallint] NULL,
	[FeePaid] [smallint] NULL,
	[IsManagedCare] [smallint] NULL,
	[IsWarehouse] [smallint] NULL,
	[IsNPP] [smallint] NULL,
	[ACHEmail] [varchar](255) NULL,
	[Created] [datetime] NOT NULL,
	[Modified] [datetime] NOT NULL,
	[RowVersion] [int] NULL,
	[MembershipType] [int] NULL,
	[OrganizationType] [int] NULL,
	[AuthorizedVoter] [nvarchar](50) NULL,
	[MembershipOwner] [varchar](200) NULL,
	[WHSNUM] [varchar](2) NULL,
	[PlansExcluded] [varchar](255) NULL,
	[IsClaimData] [smallint] NULL,
	[IsUPCData] [smallint] NULL,
	[MedicarePartBNo] [varchar](20) NULL,
	[DoNotFax] [smallint] NULL,
	[CommunicationPreference] [varchar](1) NULL,
	[APIPaymentMode] [varchar](255) NULL,
	[AAPPaymentMode] [varchar](255) NULL,
	[NCPA] [varchar](50) NULL,
	[OptOutNCPA] [smallint] NULL,
	[ReasonNotEligibleNCPA] [varchar](255) NULL,
 CONSTRAINT [PK_PM_Pharmacy_CRM] PRIMARY KEY CLUSTERED 
(
	[PMID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [Staging].[PM_Pharmacy_CRM] ADD  DEFAULT ((0)) FOR [CompetitiveAcct]
GO
ALTER TABLE [Staging].[PM_Pharmacy_CRM] ADD  DEFAULT ((0)) FOR [IsStartUpStore]
GO
ALTER TABLE [Staging].[PM_Pharmacy_CRM] ADD  DEFAULT ('N') FOR [Resigned]
GO
ALTER TABLE [Staging].[PM_Pharmacy_CRM] ADD  DEFAULT ((0)) FOR [IsBuyingGroup]
GO
ALTER TABLE [Staging].[PM_Pharmacy_CRM] ADD  DEFAULT ((0)) FOR [IsPos]
GO
ALTER TABLE [Staging].[PM_Pharmacy_CRM] ADD  DEFAULT ((0)) FOR [IsPva]
GO
ALTER TABLE [Staging].[PM_Pharmacy_CRM] ADD  DEFAULT ((0)) FOR [FeePaid]
GO
ALTER TABLE [Staging].[PM_Pharmacy_CRM] ADD  DEFAULT ((0)) FOR [IsManagedCare]
GO
ALTER TABLE [Staging].[PM_Pharmacy_CRM] ADD  DEFAULT ((0)) FOR [IsWarehouse]
GO
ALTER TABLE [Staging].[PM_Pharmacy_CRM] ADD  DEFAULT ((0)) FOR [IsNPP]
GO
ALTER TABLE [Staging].[PM_Pharmacy_CRM] ADD  DEFAULT (getdate()) FOR [Created]
GO
ALTER TABLE [Staging].[PM_Pharmacy_CRM] ADD  DEFAULT (getdate()) FOR [Modified]
GO
ALTER TABLE [Staging].[PM_Pharmacy_CRM] ADD  DEFAULT ((1)) FOR [RowVersion]
GO
ALTER TABLE [Staging].[PM_Pharmacy_CRM] ADD  DEFAULT ((0)) FOR [IsClaimData]
GO
ALTER TABLE [Staging].[PM_Pharmacy_CRM] ADD  DEFAULT ((0)) FOR [IsUPCData]
GO
