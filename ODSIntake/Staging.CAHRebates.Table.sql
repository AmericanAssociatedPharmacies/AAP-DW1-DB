USE [ODSIntake]
GO
/****** Object:  Table [Staging].[CAHRebates]    Script Date: 12/22/2020 7:30:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Staging].[CAHRebates](
	[RowID] [int] IDENTITY(1,1) NOT NULL,
	[FileRowID] [int] NOT NULL,
	[Marker] [varchar](500) NULL,
	[PMID] [varchar](500) NULL,
	[PrimaryCANmber] [varchar](500) NULL,
	[Division] [varchar](500) NULL,
	[APINumber] [varchar](500) NULL,
	[AccountName] [varchar](500) NULL,
	[City] [varchar](500) NULL,
	[ST] [varchar](500) NULL,
	[SumOfExtendedSales] [varchar](500) NULL,
	[PriceProtection] [varchar](500) NULL,
	[AdjustedExtSales] [varchar](500) NULL,
	[AAPVolumeAdminFee] [varchar](500) NULL,
	[VolAdminFeeAdjustment] [varchar](500) NULL,
	[RxPlusAdminFee] [varchar](500) NULL,
	[BsClass] [varchar](500) NULL,
	[Affiliation] [varchar](500) NULL,
	[AffiliateAdminFee] [varchar](500) NULL,
	[AffilAdminFeeAdjustment] [varchar](500) NULL,
	[TotalRXLessExcludedItems] [varchar](500) NULL,
	[SumOfCCA_AAPGenerics] [varchar](500) NULL,
	[SumOfCCA_AAPExcludedGenericRxProd] [varchar](500) NULL,
	[SumOfTotalGenerics] [varchar](500) NULL,
	[AdjustedGenericSource] [varchar](500) NULL,
	[EstGenericAdminFee] [varchar](500) NULL,
	[GenericAdminFeeAdjustment] [varchar](500) NULL,
	[CalculatedGenericRebate] [varchar](500) NULL,
	[GenericRebateAdjustment] [varchar](500) NULL,
	[COGRebate] [varchar](500) NULL,
	[COGRebatePercentage] [varchar](500) NULL,
	[FloridaPharmaccyAssocDeduct] [varchar](500) NULL,
	[LeaderRebate] [varchar](500) NULL,
	[MSIRebate] [varchar](500) NULL,
	[PriceProtectionRebate] [varchar](500) NULL,
	[PriceProtectionAdjustment] [varchar](500) NULL,
	[PrescribedWellnessFee] [varchar](500) NULL,
	[NCPAMembershipFee] [varchar](500) NULL,
	[AreteEligible] [varchar](500) NULL,
	[AretePerformanceRebate] [varchar](500) NULL,
	[CheckFee] [varchar](500) NULL,
	[PaytoStore] [varchar](500) NULL,
	[PaytoAffiliateOffice] [varchar](500) NULL,
	[TotaltoPayOut] [varchar](500) NULL,
	[TerritoryManager] [varchar](500) NULL,
	[PayAccount] [varchar](500) NULL,
	[EffectiveRebatePercentage] [varchar](500) NULL,
	[HRTA] [varchar](500) NULL,
	[SortCode] [varchar](500) NULL,
	[AP_PaymentMode] [varchar](500) NULL,
	[Matrix] [varchar](500) NULL,
	[FileProcessed] [varchar](1000) NULL,
	[RowCreatedDate] [datetime] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [Staging].[CAHRebates] ADD  DEFAULT (getdate()) FOR [RowCreatedDate]
GO
