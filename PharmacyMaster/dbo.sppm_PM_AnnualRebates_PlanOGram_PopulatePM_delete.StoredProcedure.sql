USE [PharmacyMaster]
GO
/****** Object:  StoredProcedure [dbo].[sppm_PM_AnnualRebates_PlanOGram_PopulatePM_delete]    Script Date: 12/22/2020 7:35:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




-- =============================================
-- Author:		< Joni Wilson>
-- Create date: <10/08/2010>
-- Description:	 Populate ALL_VOlume table with API WH Sales 
-- =============================================
CREATE PROCEDURE [dbo].[sppm_PM_AnnualRebates_PlanOGram_PopulatePM_delete]
(@in_year varchar(4) )
AS
BEGIN
 
 
UPDATE t set 
        PlanOGramRebate =  v.PRebate ,
		Affiliate = v.subtype 
	    FROM   pharmacymaster..PM_AnnualRebates t 
			inner join 
			 (  
              	SELECT SUM([2014 Rebate]) as PRebate ,  pmid,subtype from reports..import_planogram2014  -- CHANGE table
				 GROUP BY   pmid,subtype
			) v 
		   on t.pmid =v.pmid  where year = @in_year

 

--INSERT PM_AnnualRebates where PMID does not already exist
 INSERT  into pharmacymaster..PM_AnnualRebates (Year,PMID,TM,APIAccountNo,AccountName,BusClass, PlanOGramRebate ,Affiliate )   

      SELECT @in_year ,PMID,Territory,apiAccountNo,accountname,BusinessClass,Rebate,subtype as Affiliate FROM (    -- CHANGE DATES
			SELECT  a.pmid, p.territory,p.apiAccountNo ,p.accountname,p.BusinessClass, SUM([2014 Rebate]) as Rebate,subtype
				 FROM  reports..import_planogram2014 a  -- CHANGE table
					join pharmacymaster..pm_pharmacy p on a.pmid = p.pmid
				 
				 GROUP BY  a.pmid,Territory,p.apiAccountNo,p.accountname,BusinessClass,subtype
                   
		 )vol
	 WHERE not exists  (select pmid from pharmacymaster..PM_AnnualRebates where pmid = vol.pmid and   year= @in_year );-- CHANGE DATES



	---SET any NULLS TO ZERO and DO totals
    
	UPDATE pharmacymaster..PM_AnnualRebates set PlanOGramRebate = 0.00 where PlanOGramRebate is null;
	UPDATE pharmacymaster..PM_AnnualRebates set PatronageDividend = 0.00 where PatronageDividend is null;
	UPDATE pharmacymaster..PM_AnnualRebates set GenericIncentive = 0.00 where GenericIncentive is null;
	UPDATE pharmacymaster..PM_AnnualRebates set PatDivFirstPayment = 0.00 where PatDivFirstPayment is null;
  	UPDATE pharmacymaster..PM_AnnualRebates set PatDivSecondPayment = 0.00 where PatDivSecondPayment is null;
    UPDATE pharmacymaster..PM_AnnualRebates set [3MRebate] = 0.00 where [3MRebate] is null;
	UPDATE pharmacymaster..PM_AnnualRebates set POGRebate = 0.00 where POGRebate is null;
	UPDATE pharmacymaster..PM_AnnualRebates set MasonRebate = 0.00 where MasonRebate is null;
  UPDATE pharmacymaster..PM_AnnualRebates set TotalGenerics = 0.00 where TotalGenerics is null;
UPDATE pharmacymaster..PM_AnnualRebates set Affiliate = '' where Affiliate is null;

 
END








GO
