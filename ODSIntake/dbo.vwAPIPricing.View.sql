USE [ODSIntake]
GO
/****** Object:  View [dbo].[vwAPIPricing]    Script Date: 12/22/2020 7:30:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






CREATE VIEW [dbo].[vwAPIPricing]

AS

SELECT dt.NDC
, dt.API_ItemNumber
, dt.DateKey
, dt.APINetPrice
, dt.APIManufacturerInvoicePrice
, dt.APICustomerInvoicePrice
, ca.APIPricePerUnit
, dt.APIRebate
, dt.APIRebatePercentage
, dt.APIHoldBackPrice
, ca.APICustomerNetPrice
FROM(SELECT CONVERT(VARCHAR(11), LTRIM(RTRIM([NDC #]))) AS NDC
	, CONVERT(VARCHAR(25),LTRIM(RTRIM([API ITEM #]))) AS API_ItemNumber
	, DateKey
	, CONVERT(MONEY, [NET PRICE]) AS APINetPrice
	, CONVERT(MONEY, [INVOICE PRICE]) AS APIManufacturerInvoicePrice
	, CONVERT(MONEY, ([Contract Price] * [FEE SCHED])) AS APICustomerInvoicePrice
	, CONVERT(MONEY, [REBATE]) AS APIRebate
	, CONVERT(DECIMAL(5,2), [% REBATE]) AS APIRebatePercentage
	, CASE
		WHEN DateKey < 20180101 THEN CONVERT(MONEY, ([INVOICE PRICE] * .06)) 
		WHEN DateKey >= 20180101 THEN CONVERT(MONEY, ([INVOICE PRICE] * .025)) 
		END
		AS APIHoldBackPrice
	FROM [Staging].[ContractUp]
	) AS dt 
CROSS APPLY(SELECT [NDC #] AS NDC
			, (CONVERT(MONEY, dt.APICustomerInvoicePrice)/c.[Size]) AS APIPricePerUnit 
			, CONVERT(MONEY, (dt.APICustomerInvoicePrice - dt.APIRebate)) AS APICustomerNetPrice
			FROM [Staging].[ContractUp] AS c
			WHERE dt.NDC = c.[NDC #]
			) AS ca
WHERE ca.[NDC] = dt.NDC





GO
