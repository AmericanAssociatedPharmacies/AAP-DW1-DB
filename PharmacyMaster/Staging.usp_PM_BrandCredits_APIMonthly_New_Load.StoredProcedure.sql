USE [PharmacyMaster]
GO
/****** Object:  StoredProcedure [Staging].[usp_PM_BrandCredits_APIMonthly_New_Load]    Script Date: 12/22/2020 7:35:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [Staging].[usp_PM_BrandCredits_APIMonthly_New_Load]

AS

SET NOCOUNT ON;

BEGIN

	INSERT INTO [Staging].[PM_BrandCredits_APIMonthly_New](Date, PMID, APIAccountNo, AccountName, BrandCredits, Territory, BrandSales, ACH, PayTerms, RowCreatedDate, RowUpdatedDate, RowversionID)
	SELECT Date, PMID, APIAccountNo, AccountName, BrandCredits, Territory, BrandSales, ACH, PayTerms, RowCreatedDate, RowUpdatedDate, RowversionID
	FROM ODSIntake.[Staging].[PM_BrandCredits_APIMonthly_New]

END
GO
