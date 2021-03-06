USE [Reports]
GO
/****** Object:  StoredProcedure [dbo].[usp_rpt_CreditMemoDetails]    Script Date: 12/22/2020 7:39:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_rpt_CreditMemoDetails] @CreditMemoNum VARCHAR(20)
AS
     SELECT t1.ID
          , t1.WHAccountID
          , t1.InvNbr
          , t1.InvLine
          , t1.CustomerName
          , t1.APIItemNbr
          , t1.ItemDescription
          , t1.Qty
          , t1.UnitAmount
          , t1.ItemGrp
          , t1.AcctGrp
          , t1.Territory
          , t1.InvDate
          , t1.LineAmt
          , t1.ExtSales
          , t1.OrderNbr
          , t1.NDC_orig
          , t1.NDC
          , t1.DateLoaded
          , t1.Type
          , t1.WHNbr
          , t1.Rebate
     FROM API.dbo.APISalesDetail AS t1
--JOIN PharmacyMaster.dbo.v_PM_AllWithAffiliates AS t2 ON t2.APIAccountNo = t1.WHAccountID
     WHERE t1.InvNbr = @CreditMemoNum;
GO
