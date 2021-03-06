USE [SalesODS]
GO
/****** Object:  StoredProcedure [dbo].[usp_APISalesDetail_Load]    Script Date: 12/22/2020 7:58:50 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

​
CREATE PROCEDURE [dbo].[usp_APISalesDetail_Load]
​
​
AS
​
SET NOCOUNT ON;
​
BEGIN
​
	MERGE API.dbo.APISalesDetail AS T
	USING (SELECT ID, WHAccountID, InvNbr, InvLine, CustomerName, APIItemNbr, ItemDescription, Qty, UnitAmount, ItemGrp
				, AcctGrp, Territory, InvDate, LineAmt, ExtSales, OrderNbr, NDC_orig, NDC, DateLoaded
				, Type, WHNbr, Rebate, APIHoldbackAmount, RebateAfterAPIHoldbackAmount, AffiliateHoldbackPercent, AffiliateHoldbackAmount
				, FinalRebateAmount, APIHoldbackPercent
			FROM [Staging].[APISalesDetail]) AS S
			(ID, WHAccountID, InvNbr, InvLine, CustomerName, APIItemNbr, ItemDescription, Qty, UnitAmount, ItemGrp
		   , AcctGrp, Territory, InvDate, LineAmt, ExtSales, OrderNbr, NDC_orig, NDC, DateLoaded
		   , Type, WHNbr, Rebate, APIHoldbackAmount, RebateAfterAPIHoldbackAmount, AffiliateHoldbackPercent, AffiliateHoldbackAmount
		   , FinalRebateAmount, APIHoldbackPercent)
			ON T.ID = S.ID
​
WHEN MATCHED THEN
	
UPDATE SET WHAccountID = S.WHAccountID
		 , InvNbr = S.InvNbr
		 , InvLine = S.InvLine
		 , CustomerName = S.CustomerName
		 , APIItemNbr = S.APIItemNbr
		 , ItemDescription = S.ItemDescription
		 , Qty = S.Qty
		 , UnitAmount = S.UnitAmount
		 , ItemGrp = S.ItemGrp
		 , APIHoldbackAmount = S.APIHoldbackAmount
		 , RebateAfterAPIHoldbackAmount = S.RebateAfterAPIHoldbackAmount
		 , AffiliateHoldbackPercent = S.AffiliateHoldbackPercent
		 , AffiliateHoldbackAmount = S.AffiliateHoldbackAmount
		 , FinalRebateAmount = S.FinalRebateAmount
		 , APIHoldbackPercent = S.APIHoldbackPercent
​
WHEN NOT MATCHED THEN
​
		INSERT (ID, WHAccountID, InvNbr, InvLine, CustomerName, APIItemNbr, ItemDescription, Qty, UnitAmount, ItemGrp
			  , AcctGrp, Territory, InvDate, LineAmt, ExtSales, OrderNbr, NDC_orig, NDC, DateLoaded
			  , Type, WHNbr, Rebate, APIHoldbackAmount, RebateAfterAPIHoldbackAmount, AffiliateHoldbackPercent, AffiliateHoldbackAmount
		      , FinalRebateAmount, APIHoldbackPercent)
		VALUES (S.ID, S.WHAccountID, S.InvNbr, S.InvLine, S.CustomerName, S.APIItemNbr, S.ItemDescription, S.Qty, S.UnitAmount, S.ItemGrp
			  , S.AcctGrp, S.Territory, S.InvDate, S.LineAmt, S.ExtSales, S.OrderNbr, S.NDC_orig, S.NDC, S.DateLoaded
			  , S.Type, S.WHNbr, S.Rebate, S.APIHoldbackAmount, S.RebateAfterAPIHoldbackAmount, S.AffiliateHoldbackPercent, S.AffiliateHoldbackAmount
		      , S.FinalRebateAmount, S.APIHoldbackPercent)
			  
OUTPUT $action AS ActionType, INSERTED.ID
INTO dbo.APISalesDetail_ETL(ActionType,ID);
					
END
​
​
GO
