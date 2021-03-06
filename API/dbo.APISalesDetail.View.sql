USE [API]
GO
/****** Object:  View [dbo].[APISalesDetail]    Script Date: 12/22/2020 6:09:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[APISalesDetail]

AS

SELECT ID, WHAccountID, InvNbr, InvLine, CustomerName, APIItemNbr, ItemDescription, Qty, UnitAmount, ItemGrp, AcctGrp, Territory, InvDate, LineAmt, ExtSales, OrderNbr, NDC_orig, NDC, DateLoaded, Type, WHNbr, Rebate, APIHoldbackPercent, APIHoldbackAmount, RebateAfterAPIHoldbackAmount, AffiliateHoldbackPercent, AffiliateHoldbackAmount, FinalRebateAmount, DiscountPercentage, ConferenceCreditPercentage, ConferenceCreditAmount, RowversionID, PMID, TransTypeCode, TransTypeCodeDesc, CarrierCode, CarrierDesc
FROM DB1.API.dbo.APISalesDetail
WHERE ID > 0

GO
