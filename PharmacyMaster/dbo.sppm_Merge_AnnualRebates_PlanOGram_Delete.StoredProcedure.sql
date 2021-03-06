USE [PharmacyMaster]
GO
/****** Object:  StoredProcedure [dbo].[sppm_Merge_AnnualRebates_PlanOGram_Delete]    Script Date: 12/22/2020 7:35:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




-- =============================================
-- Author:		< Joni Wilson>
-- Create date: <10/08/2010>
-- Description:	 Populate ALL_VOlume table with API WH Sales 
-- =============================================
CREATE PROCEDURE [dbo].[sppm_Merge_AnnualRebates_PlanOGram_Delete]
 
AS
BEGIN
 
 
 -- Merging in old tables

--INSERT PM_AnnualRebates where PMID does not already exist
 INSERT  into reports..import_RebatePlanOGram (Year, PMID, AccountName,Owner,Address1,City,State,Zip,
             Description,Affiliate,AAPAccountNo,APIAccountNo,Rebate)   

      SELECT '2011' ,a.PMID,p.AccountName,Fullname,Address1,City,ST,Zip,Type,SubType,p.AAPAccountNo ,
                   p.APIAccountNo, SUM(Rebate) as Rebate
				 FROM  reports..import_planogram2011 a  
					join pharmacymaster..pm_pharmacy p on a.pmid = p.pmid
				 
				 GROUP BY a.PMID,p.AccountName,Fullname,Address1,City,ST,Zip,Type,SubType,p.AAPAccountNo ,
                   p.APIAccountNo
 
 

 

 
END








GO
