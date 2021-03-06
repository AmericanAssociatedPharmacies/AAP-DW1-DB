USE [SalesODS]
GO
/****** Object:  StoredProcedure [dbo].[usp_APISalesDetail_Insert]    Script Date: 12/22/2020 7:58:50 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[usp_APISalesDetail_Insert]


AS

SET NOCOUNT ON;

BEGIN

	INSERT INTO API.dbo.APISalesDetail(ID, WHAccountID, InvNbr, InvLine, CustomerName, APIItemNbr, ItemDescription, Qty, UnitAmount, ItemGrp
										, AcctGrp, Territory, InvDate, LineAmt, ExtSales, OrderNbr, NDC_orig, NDC, DateLoaded
										, Type, WHNbr, Rebate, APIHoldbackAmount, RebateAfterAPIHoldbackAmount, AffiliateHoldbackPercent, AffiliateHoldbackAmount
										, FinalRebateAmount, APIHoldbackPercent
										)
	SELECT ID, WHAccountID, InvNbr, InvLine, CustomerName, APIItemNbr, ItemDescription, Qty, UnitAmount, ItemGrp
										, AcctGrp, Territory, InvDate, LineAmt, ExtSales, OrderNbr, NDC_orig, NDC, DateLoaded
										, Type, WHNbr, Rebate, APIHoldbackAmount, RebateAfterAPIHoldbackAmount, AffiliateHoldbackPercent, AffiliateHoldbackAmount
										, FinalRebateAmount, APIHoldbackPercent
	FROM [Staging].[APISalesDetail] AS s
	WHERE NOT EXISTS(SELECT 1
						FROM API.dbo.APISalesDetail AS sa
						WHERE s.ID = sa.ID
						)	

END


GO
