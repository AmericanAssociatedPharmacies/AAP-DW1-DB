USE [PharmacyMaster]
GO
/****** Object:  StoredProcedure [Staging].[usp_PM_Rebates_APIMonthly_New_Load]    Script Date: 12/22/2020 7:35:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [Staging].[usp_PM_Rebates_APIMonthly_New_Load]

AS

SET NOCOUNT ON;

BEGIN

	SET IDENTITY_INSERT Staging.PM_Rebates_APIMonthly_New ON

	INSERT INTO [Staging].[PM_Rebates_APIMonthly_New]
				(RowID
				, [Date]
				, [PMID]
				, [APIAccountNo]
				, [Pharmacy Name]
				, [Business Class]
				, [Rebate Administrator]
				, [API Generic Sales]
				, [API Brand Sales]
				, [API OTC Sales]
				, [API Total Whse Sales]
				, [API Whse Gross Rebate]
				, [Adjust for Promotions]
				, [Adjust for Returns]
				, [Adjust for Rebate Errors]
				, [Generic Admin Fee]
				, [API WHSE REBATE for Payout]
				, [Less Negative Rebates]
				, [Unpaid Finance Charges]
				, [Check Fee]
				, [Held Rebate]
				, [Rebate to Pay Acct/Admin]
				, [Less Group Admin]
				, [Net Rebate to Store]
				, [Pay Account]
				, [Print Rebate Letter]
				, [Brand Credits Disbursed]
				, [Accelerated Pay Discount]
				, [Avg Rebate Percentage]
				, [A/P Payment Mode]
				, [Previous Month Held Rebate]
				, [PostAveRebatePerc]
				, [True10Sales]
				, [True10Rebate]
				, [AreteRebateFee]
				, [APIInstantRebate]
				, [CalcAPIRebatePercentage]
				, [RowCreatedDate]
				, [RowUpdatedDate]
				, [RowversionID]
				, [APIGenericSalesTier1] 
				, [APIGenericSalesTier2] 
				, [APIGenericRebateTier1] 
				, [APIGenericRebateTier2] 
								)
			SELECT RowID 
			, [Date]
			, [PMID]
			, [APIAccountNo]
			, [Pharmacy Name]
			, [Business Class]
			, [Rebate Administrator]
			, [API Generic Sales]
			, [API Brand Sales]
			, [API OTC Sales]
			, [API Total Whse Sales]
			, [API Whse Gross Rebate]
			, [Adjust for Promotions]
			, [Adjust for Returns]
			, [Adjust for Rebate Errors]
			, [Generic Admin Fee]
			, [API WHSE REBATE for Payout]
			, [Less Negative Rebates]
			, [Unpaid Finance Charges]
			, [Check Fee]
			, [Held Rebate]
			, [Rebate to Pay Acct/Admin]
			, [Less Group Admin]
			, [Net Rebate to Store]
			, [Pay Account]
			, [Print Rebate Letter]
			, [Brand Credits Disbursed]
			, [Accelerated Pay Discount]
			, [Avg Rebate Percentage]
			, [A/P Payment Mode]
			, [Previous Month Held Rebate]
			, [PostAveRebatePerc]
			, [True10Sales]
			, [True10Rebate]
			, [AreteRebateFee]
			, [APIInstantRebate]
			, [CalcAPIRebatePercentage]
			, [RowCreatedDate]
			, [RowUpdatedDate]
			, [RowversionID]
			, [APIGenericSalesTier1] 
			, [APIGenericSalesTier2] 
			, [APIGenericRebateTier1] 
			, [APIGenericRebateTier2] 
			FROM ODSIntake.[Staging].[PM_Rebates_APIMonthly_New]

	SET IDENTITY_INSERT Staging.PM_Rebates_APIMonthly_New OFF

END


--SELECT ', [' + name + ']'
--FROM sys.syscolumns
--WHERE id = OBJECT_ID('Staging.PM_Rebates_APIMonthly_New')
--ORDER BY colid ASC

GO
