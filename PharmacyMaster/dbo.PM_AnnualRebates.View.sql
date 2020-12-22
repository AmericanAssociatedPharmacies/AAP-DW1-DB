USE [PharmacyMaster]
GO
/****** Object:  View [dbo].[PM_AnnualRebates]    Script Date: 12/22/2020 7:35:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[PM_AnnualRebates]

AS

SELECT ID, Year, PMID, TM, APIAccountNo, AccountName, Affiliate, BusClass, TotalGenerics, GenericIncentiveFirstPayment, GenericIncentiveSecondPayment, GenericIncentive, PlanOGramRebate, PatronageDividend, PatDivFirstPayment, PatDivSecondPayment, [3MRebate], POGRebate, MasonRebate
FROM [dbo].[PM_AnnualRebates_New]
GO
