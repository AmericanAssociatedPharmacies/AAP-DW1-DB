USE [SSRS]
GO
/****** Object:  View [dbo].[APISalesDetail]    Script Date: 12/22/2020 8:05:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[APISalesDetail]
AS
     SELECT [ID]
          , [WHAccountID]
          , [InvNbr]
          , [InvLine]
          , [CustomerName]
          , [APIItemNbr]
          , [ItemDescription]
          , [Qty]
          , [UnitAmount]
          , [ItemGrp]
          , [AcctGrp]
          , [Territory]
          , [InvDate]
          , [LineAmt]
          , [ExtSales]
          , [OrderNbr]
          , [NDC_orig]
          , [NDC]
          , [DateLoaded]
          , [Type]
          , [WHNbr]
          , [Rebate]
          , [APIHoldBackPercent]
          , [APIHoldBackAmount]
          , [RebateAfterAPIHoldbackAmount]
          , [AffiliateHoldbackPercent]
          , [AffiliateHoldbackAmount]
          , [FinalRebateAmount]
          , [RowversionID]
     FROM [API].[dbo].[APISalesDetail]
	 WHERE YEAR([InvDate]) >= YEAR(DATEADD(yy, -2, GETDATE()))
GO
