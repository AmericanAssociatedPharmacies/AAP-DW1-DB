USE [ODSIntake]
GO
/****** Object:  View [Staging].[vwAPIPricing]    Script Date: 12/22/2020 7:30:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE VIEW [Staging].[vwAPIPricing]

AS


SELECT NDC, API_ItemNumber, DateKey, APICustomerInvoicePrice, APIPricePerUnit, APIRebate, APIRebatePercentage, APIHoldBackAmount, APICustomerNetPrice
FROM DB1.API.[Staging].[vwAPIPricingDW1]





/*--SELECT dt.NDC
--, dt.API_ItemNumber
--, dt.DateKey
--, dt.APINetPrice
--, dt.APIManufacturerInvoicePrice
--, dt.APICustomerInvoicePrice
--, ca.APIPricePerUnit
--, dt.APIRebate
--, dt.APIRebatePercentage
--, dt.APIHoldBackAmount
--, ca.APICustomerNetPrice
--FROM(SELECT RowID
--	, CONVERT(VARCHAR(11), [NDC #]) AS NDC
--	, DateKey
--	, CONVERT(VARCHAR(25), [API ITEM #]) AS API_ItemNumber
--	, CONVERT(MONEY, [NET PRICE]) AS APINetPrice
--	, CONVERT(MONEY, [INVOICE PRICE]) AS APIManufacturerInvoicePrice
--	--, CONVERT(MONEY, ([API PRICE] * 1.06)) AS APICustomerInvoicePrice Per Bob on 11/29/2017, "1.06" not needed.
--	, CONVERT(MONEY, ([API PRICE])) AS APICustomerInvoicePrice
--	, CONVERT(MONEY, [REBATE]) AS APIRebate
--	, CONVERT(DECIMAL(5,2), [% REBATE]) AS APIRebatePercentage
--	--, CONVERT(MONEY, ([INVOICE PRICE] * .06)) AS APIHoldBackPrice
--	, CONVERT(MONEY, ([API PRICE] * .06)) AS APIHoldBackAmount
--	FROM [Staging].[ContractUp]
--	) AS dt 
--CROSS APPLY(SELECT RowID
--			, [NDC #] AS NDC
--			, (CONVERT(MONEY, dt.APICustomerInvoicePrice)/c.[Size]) AS APIPricePerUnit 
--			, CONVERT(MONEY, (dt.APICustomerInvoicePrice - dt.APIRebate + dt.APIHoldBackAmount)) AS APICustomerNetPrice
--			FROM [Staging].[ContractUp] AS c
--			WHERE dt.RowID = c.[RowID]
--			) AS ca
--WHERE ca.[RowID] = dt.RowID*/
GO
