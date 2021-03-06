USE [PharmacyMaster]
GO
/****** Object:  StoredProcedure [dbo].[sppm_QA_PPQtrForPipco]    Script Date: 12/22/2020 7:35:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




-- =============================================
-- Author:		< Joni Wilson>
-- Create date: <10/15/2012>
-- Description:	 Create PP Quarterly QA for Pipco
-- =============================================
CREATE PROCEDURE [dbo].[sppm_QA_PPQtrForPipco]
(@period varchar(6),@dev float)
AS
BEGIN


        Select t.PMID,  Payment,PaymentAmt from tmp_PP_Pipco_Group t

        join 
        (
          Select pmid,PaymentAmt from pm_rebates_ppartner where period = @period
        ) p
        on t.pmid = p.pmid where Payment - PaymentAmt > @dev or PaymentAmt - Payment > @dev
 
 
END








GO
