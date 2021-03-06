USE [API]
GO
/****** Object:  StoredProcedure [dbo].[usp_APISalesDetail]    Script Date: 12/22/2020 6:09:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_APISalesDetail]

	@DateKey INT

AS

SET NOCOUNT ON;

BEGIN

	DECLARE @Date DATETIME

	SET @Date = CONVERT(datetime, convert(varchar(10), @DateKey))

	SELECT ID, WHAccountID, InvNbr, InvLine, CustomerName, APIItemNbr, ItemDescription, Qty, UnitAmount, ItemGrp, AcctGrp, Territory, InvDate, LineAmt
	, ExtSales, OrderNbr, NDC_orig, NDC, DateLoaded, Type, WHNbr, Rebate, APIHoldBackPercent, APIHoldBackAmount, RebateAfterAPIHoldbackAmount, AffiliateHoldbackPercent
	, AffiliateHoldbackAmount, FinalRebateAmount
	FROM [dbo].[APISalesDetail]
	WHERE InvDate = @Date
	ORDER BY ID ASC



END
GO
