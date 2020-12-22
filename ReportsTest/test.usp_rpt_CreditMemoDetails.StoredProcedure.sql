USE [ReportsTest]
GO
/****** Object:  StoredProcedure [test].[usp_rpt_CreditMemoDetails]    Script Date: 12/22/2020 7:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [test].[usp_rpt_CreditMemoDetails]
@CreditMemoNum VARCHAR(20)
AS
SELECT
*
FROM API.dbo.APISalesDetail AS t1
--JOIN PharmacyMaster.dbo.v_PM_AllWithAffiliates AS t2 ON t2.APIAccountNo = t1.WHAccountID
WHERE t1.InvNbr = @CreditMemoNum
--AND YEAR(t1.InvDate) >= 2009
GO
