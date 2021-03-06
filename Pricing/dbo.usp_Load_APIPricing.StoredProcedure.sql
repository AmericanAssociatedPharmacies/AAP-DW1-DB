USE [Pricing]
GO
/****** Object:  StoredProcedure [dbo].[usp_Load_APIPricing]    Script Date: 12/22/2020 7:32:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[usp_Load_APIPricing]

AS

SET NOCOUNT ON;

BEGIN

	--Insert rows
	INSERT INTO [dbo].[APIPricing](NDC, DateKey, APINetPrice, APIManufacturerInvoicePrice, APICustomerInvoicePrice
									, APIPricePerUnit, APIRebate, APIRebatePercentage, APIHoldBackPrice, APICustomerNetPrice
									)
	SELECT NDC, DateKey, APINetPrice, APIManufacturerInvoicePrice, APICustomerInvoicePrice
	, APIPricePerUnit, APIRebate, APIRebatePercentage, APIHoldBackPrice, APICustomerNetPrice
	FROM ODSIntake.dbo.[vwAPIPricing] AS sap
	WHERE NOT EXISTS(SELECT 1
						FROM [dbo].[APIPricing] AS ap
						WHERE sap.DateKey = ap.DateKey
						AND sap.NDC = ap.NDC
					)

	--Update Stats
	UPDATE STATISTICS [dbo].[APIPricing]
	

END

GO
