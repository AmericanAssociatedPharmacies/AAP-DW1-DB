USE [ODSIntake]
GO
/****** Object:  StoredProcedure [Archive].[usp_PM_Rebates_CHAAP_New_Load]    Script Date: 12/22/2020 7:30:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [Archive].[usp_PM_Rebates_CHAAP_New_Load]

AS

SET NOCOUNT ON;

BEGIN

	INSERT INTO [Archive].[PM_Rebates_CHAAP_New](Date, PMID, PrimaryCANo, Division, APIAccountNo, AccountName, ExtendedSales, AAPVolumeAdminFee, RxPlusAdminFee, Affiliate, BusCls, AAPVolumeAdminFeePaidToAffiliate
	, BrandRxSales, SourceGenericSales, ExcludedGenericSales, TotalGenericSales, AAPGenericAdminFee, AAPGenericAdminFeePaidToPipco, IPAGenericAdminFee, ContractPerformanceRebate
	, GenericRebate, LeaderRebate, MSIRebate, PayToStore, PayToAffiliateOffice, TotalToPayOut, TM, PayAccount, EffRebatePerc, HRTA, SortCode, RebateType
	, [Check Fee], [A/P Payment Mode], PriceProtectionRebate, AdjustedExtSales, AdjustedGenericSource, PriceProtection, PrescribedWellnessFee, GenericRebateAdjustment
	, PriceProtectionAdjustment, VolAdminFeeAdj, AffilAdminFeeAdj, GenericAdminFeeAdj, NCPAMembershipFee, FloridaPhcyAssocDeduct, AreteEligible, AretePerformanceRebate
	, TotalRXlessExcludedItems, COGRebate, [COGRebate%], RowCreatedDate, RowUpdatedDate, RowversionID)
	SELECT Date, PMID, PrimaryCANo, Division, APIAccountNo, AccountName, ExtendedSales, AAPVolumeAdminFee, RxPlusAdminFee, Affiliate, BusCls, AAPVolumeAdminFeePaidToAffiliate
	, BrandRxSales, SourceGenericSales, ExcludedGenericSales, TotalGenericSales, AAPGenericAdminFee, AAPGenericAdminFeePaidToPipco, IPAGenericAdminFee, ContractPerformanceRebate
	, GenericRebate, LeaderRebate, MSIRebate, PayToStore, PayToAffiliateOffice, TotalToPayOut, TM, PayAccount, EffRebatePerc, HRTA, SortCode, RebateType
	, [Check Fee], [A/P Payment Mode], PriceProtectionRebate, AdjustedExtSales, AdjustedGenericSource, PriceProtection, PrescribedWellnessFee, GenericRebateAdjustment
	, PriceProtectionAdjustment, VolAdminFeeAdj, AffilAdminFeeAdj, GenericAdminFeeAdj, NCPAMembershipFee, FloridaPhcyAssocDeduct, AreteEligible, AretePerformanceRebate
	, TotalRXlessExcludedItems, COGRebate, [COGRebate%], RowCreatedDate, RowUpdatedDate, RowversionID
	FROM [Staging].[PM_Rebates_CHAAP_New]

END
GO
