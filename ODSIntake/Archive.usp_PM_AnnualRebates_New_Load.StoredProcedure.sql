USE [ODSIntake]
GO
/****** Object:  StoredProcedure [Archive].[usp_PM_AnnualRebates_New_Load]    Script Date: 12/22/2020 7:30:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [Archive].[usp_PM_AnnualRebates_New_Load]

AS

SET NOCOUNT ON;

BEGIN

INSERT INTO [Archive].[PM_AnnualRebates_New](ID, Year, PMID, TM, APIAccountNo, AccountName, Affiliate, BusClass, TotalGenerics, GenericIncentiveFirstPayment, GenericIncentiveSecondPayment, GenericIncentive
, PlanOGramRebate, PatronageDividend, PatDivFirstPayment, PatDivSecondPayment, [3MRebate], POGRebate, MasonRebate, RowCreatedDate, RowUpdatedDate, RowversionID)
SELECT ID, Year, PMID, TM, APIAccountNo, AccountName, Affiliate, BusClass, TotalGenerics, GenericIncentiveFirstPayment, GenericIncentiveSecondPayment, GenericIncentive
, PlanOGramRebate, PatronageDividend, PatDivFirstPayment, PatDivSecondPayment, [3MRebate], POGRebate, MasonRebate, RowCreatedDate, RowUpdatedDate, RowversionID
FROM [Staging].[PM_AnnualRebates_New]



END
GO
