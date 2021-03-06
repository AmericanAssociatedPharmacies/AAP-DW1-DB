USE [Pricing]
GO
/****** Object:  StoredProcedure [dbo].[usp_PriceFact_Load_API]    Script Date: 12/22/2020 7:32:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






CREATE PROCEDURE [dbo].[usp_PriceFact_Load_API]

/*******************************************************************************

-- Author: Scott Edwards
-- Description: Used to insert\update API information for PricingFact table.
-- InParameter: N\A
-- OutParameter: N\A
-- Created Date: 08/16/2017
-- Revision History :
-- Modified Date Modified By version Description
-- Test code: Execute sproc as is.

********************************************************************************/


AS

SET NOCOUNT ON;

BEGIN


	MERGE [dbo].[PriceFact] AS t
	USING(SELECT a.NDC
			, a.DateKey
			, ISNULL(d.DrugKey, 0) AS DrugKey
			, ISNULL(cd.[CompetitorDrugKey], 0) AS CompetitorDrugKey
			, a.APINetPrice
			, a.APIManufacturerInvoicePrice
			, a.APICustomerInvoicePrice
			, a.APIPricePerUnit
			, a.APIRebate
			, a.APIRebatePercentage
			, a.APIHoldBackAmount
			, a.APICustomerNetPrice
			FROM [Staging].[APIPricing] AS a
			INNER JOIN(SELECT MAX(DrugKey) AS DrugKey
						, NDC
						FROM dbo.DrugDim
						GROUP BY NDC
						) AS d ON a.NDC = d.NDC
			INNER JOIN [dbo].[CompetitorDrugDim] AS cd ON A.RowVersionID = cd.API_RowVersionID
				) AS s (NDC, DateKey, DrugKey, CompetitorDrugKey ,APINetPrice, APIManufacturerInvoicePrice, APICustomerInvoicePrice
					, APIPricePerUnit, APIRebate, APIRebatePercentage, APIHoldBackAmount
					, APICustomerNetPrice
					) ON t.DateKey = s.DateKey 
						AND t.DrugKey = s.DrugKey
						AND t.CompetitorDrugKey = s.CompetitorDrugKey
	WHEN MATCHED THEN 
	UPDATE SET [APINetPrice] = s.[APINetPrice]
				, APIManufacturerInvoicePrice = s.APIManufacturerInvoicePrice
				, APICustomerInvoicePrice = s.APICustomerInvoicePrice
				, APIPricePerUnit =  s.APIPricePerUnit
				, APIRebate = s.APIRebate
				, APIRebatePercentage = s.APIRebatePercentage
				, APIHoldBackAmount = s.APIHoldBackAmount
				, APICustomerNetPrice = s.APICustomerNetPrice
	WHEN NOT MATCHED THEN
	INSERT (DateKey
			, DrugKey
			, CompetitorDrugKey
			, APINetPrice
			, APIManufacturerInvoicePrice
			, APICustomerInvoicePrice
			, APIPricePerUnit
			, APIRebate
			, APIRebatePercentage
			, APIHoldBackAmount
			, APICustomerNetPrice
			)
	VALUES(s.DateKey
			, s.DrugKey
			, s.CompetitorDrugKey
			, s.APINetPrice
			, s.APIManufacturerInvoicePrice
			, s.APICustomerInvoicePrice
			, s.APIPricePerUnit
			, s.APIRebate
			, s.APIRebatePercentage
			, s.APIHoldBackAmount
			, s.APICustomerNetPrice
			)
	;


END





GO
