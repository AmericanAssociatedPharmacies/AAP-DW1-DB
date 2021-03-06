USE [ODSIntake]
GO
/****** Object:  View [Staging].[vwAPIPricing_2]    Script Date: 12/22/2020 7:30:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [Staging].[vwAPIPricing_2]

AS

SELECT [NDC #] AS NDC
, [Net Price] AS APINetPrice
, [Invoice Price] AS APIInvoicePrice
, CONVERT(MONEY, ([API Price] * .06)) AS HoldBackPrice
, [API Price] AS APICustomerInvoicePrice
, [Rebate] AS APIRebate
, [% Rebate] AS APIRebatePercentage
, [Size]
FROM dbo.[CONTRACT]


GO
