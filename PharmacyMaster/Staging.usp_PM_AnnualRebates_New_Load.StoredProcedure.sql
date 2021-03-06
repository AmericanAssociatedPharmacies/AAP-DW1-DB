USE [PharmacyMaster]
GO
/****** Object:  StoredProcedure [Staging].[usp_PM_AnnualRebates_New_Load]    Script Date: 12/22/2020 7:35:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [Staging].[usp_PM_AnnualRebates_New_Load]

AS

SET NOCOUNT ON;

BEGIN

	SET IDENTITY_INSERT [Staging].[PM_AnnualRebates_New] ON;

	INSERT INTO [Staging].[PM_AnnualRebates_New](ID, Year, PMID, TM, APIAccountNo, AccountName, Affiliate, BusClass, TotalGenerics, GenericIncentiveFirstPayment, GenericIncentiveSecondPayment, GenericIncentive
	, PlanOGramRebate, PatronageDividend, PatDivFirstPayment, PatDivSecondPayment, [3MRebate], POGRebate, MasonRebate, RowCreatedDate, RowUpdatedDate, RowversionID)
	SELECT ID, Year, PMID, TM, APIAccountNo, AccountName, Affiliate, BusClass, TotalGenerics, GenericIncentiveFirstPayment, GenericIncentiveSecondPayment, GenericIncentive
	, PlanOGramRebate, PatronageDividend, PatDivFirstPayment, PatDivSecondPayment, [3MRebate], POGRebate, MasonRebate, RowCreatedDate, RowUpdatedDate, RowversionID
	FROM ODSIntake.[Staging].[PM_AnnualRebates_New]

	SET IDENTITY_INSERT [Staging].[PM_AnnualRebates_New] OFF;



END
GO
