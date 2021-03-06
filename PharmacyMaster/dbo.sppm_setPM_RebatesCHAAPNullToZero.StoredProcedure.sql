USE [PharmacyMaster]
GO
/****** Object:  StoredProcedure [dbo].[sppm_setPM_RebatesCHAAPNullToZero]    Script Date: 12/22/2020 7:35:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




-- =============================================
-- Author:		< Joni Wilson>
-- Create date: <07/02/2012>
-- Description:	When Changing the ALL_Volume through UI need to recalculate the combined totals after an update has occurred
-- =============================================
CREATE PROCEDURE [dbo].[sppm_setPM_RebatesCHAAPNullToZero]

AS
BEGIN
 
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
  
	   --- Drop the previous runs table
--UPdate Totals 
	UPDATE PharmacyMaster..pm_rebates_Chaap set AAPGenericAdminFeePaidToPipco = 0 where AAPGenericAdminFeePaidToPipco is null;
	UPDATE PharmacyMaster..pm_rebates_Chaap set ExtendedSales = 0 where ExtendedSales is null;
	UPDATE PharmacyMaster..pm_rebates_Chaap set AAPVolumeAdminFee = 0 where AAPVolumeAdminFee is null;
	UPDATE PharmacyMaster..pm_rebates_Chaap set AAPVolumeAdminFeePaidToAffiliate = 0 where AAPVolumeAdminFeePaidToAffiliate is null;
	UPDATE PharmacyMaster..pm_rebates_Chaap set BrandRxSales = 0 where BrandRxSales is null;
	UPDATE PharmacyMaster..pm_rebates_Chaap set SourceGenericSales = 0 where SourceGenericSales is null;
	UPDATE PharmacyMaster..pm_rebates_Chaap set ExcludedGenericSales = 0 where ExcludedGenericSales is null;
	UPDATE PharmacyMaster..pm_rebates_Chaap set TotalGenericSales = 0 where TotalGenericSales is null;
	UPDATE PharmacyMaster..pm_rebates_Chaap set AAPGenericAdminFee = 0 where AAPGenericAdminFee is null;
	UPDATE PharmacyMaster..pm_rebates_Chaap set IPAGenericAdminFee = 0 where IPAGenericAdminFee is null;
	UPDATE PharmacyMaster..pm_rebates_Chaap set GenericRebate = 0 where GenericRebate is null;
	UPDATE PharmacyMaster..pm_rebates_Chaap set LeaderRebate = 0 where LeaderRebate is null;
	UPDATE PharmacyMaster..pm_rebates_Chaap set MSIRebate = 0 where MSIRebate is null;
	UPDATE PharmacyMaster..pm_rebates_Chaap set PayToStore = 0 where PayToStore is null;
	UPDATE PharmacyMaster..pm_rebates_Chaap set PayToAffiliateOffice = 0 where PayToAffiliateOffice is null;
	UPDATE PharmacyMaster..pm_rebates_Chaap set TotalToPayOut = 0 where TotalToPayOut is null;
	UPDATE PharmacyMaster..pm_rebates_Chaap set EffRebatePerc = 0 where EffRebatePerc is null;
	UPDATE PharmacyMaster..pm_rebates_Chaap set HRTA = 0 where HRTA is null;
	UPDATE PharmacyMaster..pm_rebates_Chaap set RxplusAdminFee = 0 where RxplusAdminFee is null;


    -- New 

	UPDATE Reports..pm_rebates_Chaap set ContractPerformanceRebate = 0 where ContractPerformanceRebate is null;
	UPDATE Reports..pm_rebates_Chaap set [Check Fee] = 0 where [Check Fee] is null;
	UPDATE Reports..pm_rebates_Chaap set PriceProtectionRebate = 0 where PriceProtectionRebate is null;
	UPDATE Reports..pm_rebates_Chaap set AdjustedExtSales = 0 where AdjustedExtSales is null;
	UPDATE Reports..pm_rebates_Chaap set AdjustedGenericSource = 0 where AdjustedGenericSource is null;
	UPDATE Reports..pm_rebates_Chaap set PriceProtection = 0 where PriceProtection is null;
	UPDATE Reports..pm_rebates_Chaap set PrescribedWellnessFee = 0 where PrescribedWellnessFee is null;
	UPDATE Reports..pm_rebates_Chaap set GenericRebateAdjustment = 0 where GenericRebateAdjustment is null;
	UPDATE Reports..pm_rebates_Chaap set PriceProtectionAdjustment = 0 where PriceProtectionAdjustment is null;
	UPDATE Reports..pm_rebates_Chaap set VolAdminFeeAdj = 0 where VolAdminFeeAdj is null;
	UPDATE Reports..pm_rebates_Chaap set AffilAdminFeeAdj = 0 where AffilAdminFeeAdj is null;
	UPDATE Reports..pm_rebates_Chaap set GenericAdminFeeAdj = 0 where GenericAdminFeeAdj is null;
	UPDATE Reports..pm_rebates_Chaap set NCPAMembershipFee = 0 where NCPAMembershipFee is null;
	UPDATE Reports..pm_rebates_Chaap set FloridaPhcyAssocDeduct = 0 where FloridaPhcyAssocDeduct is null;
END








GO
