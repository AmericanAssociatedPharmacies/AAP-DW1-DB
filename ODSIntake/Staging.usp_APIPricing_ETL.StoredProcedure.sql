USE [ODSIntake]
GO
/****** Object:  StoredProcedure [Staging].[usp_APIPricing_ETL]    Script Date: 12/22/2020 7:30:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [Staging].[usp_APIPricing_ETL]


AS

/******************************
** File:  N\A  
** Name: Staging.usp_APIPricing_ETL
** Desc: Used to pull data for API Pricing ETL
** Auth: RSE
** Date: 11/30/2017
**************************
** Change History
**************************
** PR   Date        Author		Description 
** --   --------   -------		------------------------------------
** 1    11/30/2017    RSE		Created from SQL VIEW 8/28/2017
** 2	11/30/2017	  RSE		Per conversation with Bob on 11/29/2017, remove "1.06" multiplier. "API Price" is
								APICustomerInvoicePrice used in ETL	
** 3	01/05/2018	  RSE		Changed the [APIHoldBackAmount]	column to include logic based on the year					
								 		
*******************************/


SET NOCOUNT ON;

BEGIN

	SELECT dt.NDC
	, dt.API_ItemNumber
	, dt.DateKey
	, dt.APINetPrice
	, dt.APIManufacturerInvoicePrice
	, dt.APICustomerInvoicePrice
	, ca.APIPricePerUnit
	, dt.APIRebate
	, dt.APIRebatePercentage
	, dt.APIHoldBackAmount
	, ca.APICustomerNetPrice
	FROM(SELECT RowID
		, CONVERT(VARCHAR(11), [NDC #]) AS NDC
		, DateKey
		, CONVERT(VARCHAR(25), [API ITEM #]) AS API_ItemNumber
		, CONVERT(MONEY, [NET PRICE]) AS APINetPrice
		, CONVERT(MONEY, [INVOICE PRICE]) AS APIManufacturerInvoicePrice
		, CONVERT(MONEY, ([API PRICE])) AS APICustomerInvoicePrice
		, CONVERT(MONEY, [REBATE]) AS APIRebate
		, CONVERT(DECIMAL(5,2), [% REBATE]) AS APIRebatePercentage
		, CASE
			WHEN DateKey < 20180101 THEN CONVERT(MONEY, ([INVOICE PRICE] * .06)) 
			WHEN DateKey >= 20180101 THEN CONVERT(MONEY, ([INVOICE PRICE] * .025)) 
			END
			AS APIHoldBackAmount
		FROM [Staging].[ContractUp]
		) AS dt 
	CROSS APPLY(SELECT RowID
				, [NDC #] AS NDC
				, (CONVERT(MONEY, dt.APICustomerInvoicePrice)/c.[Size]) AS APIPricePerUnit 
				, CONVERT(MONEY, (dt.APICustomerInvoicePrice - dt.APIRebate + dt.APIHoldBackAmount)) AS APICustomerNetPrice
				FROM [Staging].[ContractUp] AS c
				WHERE dt.RowID = c.[RowID]
				) AS ca
	WHERE ca.[RowID] = dt.RowID
	AND dt.NDC IS NOT NULL
	ORDER BY dt.NDC ASC



END




GO
