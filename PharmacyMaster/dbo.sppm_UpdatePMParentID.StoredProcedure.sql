USE [PharmacyMaster]
GO
/****** Object:  StoredProcedure [dbo].[sppm_UpdatePMParentID]    Script Date: 12/22/2020 7:35:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




-- =============================================
-- Author:		< Joni Wilson>
-- Create date: <03/29/2010>
-- Description:	Update the ParentPMID
-- =============================================
CREATE PROCEDURE [dbo].[sppm_UpdatePMParentID]

AS
BEGIN
 
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
  

-- DO UD Accounts first - only do those where there is a udaccount and no aapaccount

 -- Clear what is there first
	UPDATE tmp_PM_Pharmacy_testParentID set PMParentID = null;

  -- Need to do the child ones fisrt in UD - they have group set to itself evne if there is no group - go figure
	UPDATE  pm  set 
			PMParentID = m.pmid
	   FROM tmp_PM_Pharmacy_testParentID pm 
		inner join 
			(  SELECT udaccountno,udparentno,pmid
				 FROM  tmp_PM_Pharmacy_testParentID 
				 WHERE      udaccountno is not null and aapaccountno is null
			 ) m
	   on pm.udparentno = m.udaccountno where pm.pmid != m.pmid
       and  pm.udaccountno is not null and pm.aapaccountno is null

  --- Next need to update PmParentID of the Parent itself
	UPDATE  tmp1  set 
			PMParentID =  tmp1.pmid
	   FROM tmp_PM_Pharmacy_testParentID tmp1 
		inner join 
			(  SELECT * FROM tmp_PM_Pharmacy_testParentID
                   WHERE      udaccountno is not null and aapaccountno is null
			 ) tmp2
	   on tmp2.pmparentid = tmp1.pmid  


-- Update with AAPParent Info 

	UPDATE  pm  set 
			PMParentID = m.pmid
	   FROM tmp_PM_Pharmacy_testParentID pm 
		inner join 
			(  SELECT aapaccountno,aapparentno,pmid
				 FROM  tmp_PM_Pharmacy_testParentID 
				 WHERE      aapaccountno is not null 
			 ) m
	   on pm.aapparentno = m.aapaccountno where 
          pm.aapaccountno is not null 


-- Select Statements to verify for UD

-- Need to do the child ones first in UD - they have group set to itself evne if there is no group - go figure
--select p.udaccountno,p.udparentno,p.pmid as ChildPMID,m.udparentno,m.udaccountno,m.pmid as ParentPMID
--	   FROM tmp_PM_Pharmacy_testParentID p
--		inner join 
--			(  SELECT udaccountno,udparentno,pmid
--				 FROM  tmp_PM_Pharmacy_testParentID 
--				 WHERE      udaccountno is not null and aapaccountno is null
--			 ) m
--	   on p.udparentno = m.udaccountno   where p.pmid != m.pmid and  p.udaccountno is not null and p.aapaccountno is null
--order by m.pmid
--
---- Once that is done can get the PMID of the parent and update the PMParentID with itself
--select tmp1.accountname,tmp1.pmid,tmp1.pmparentid,tmp1.udaccountno,tmp1.udparentno,
-- tmp2.pmid,tmp2.pmparentid,tmp2.udaccountno,tmp2.udparentno
-- from tmp_PM_Pharmacy_testParentID tmp1
--join 
--(
--select * from tmp_PM_Pharmacy_testParentID
--  WHERE      udaccountno is not null and aapaccountno is null
--) tmp2
--on tmp2.pmparentid = tmp1.pmid

--Select statements to verify AAP
--select p.aapaccountno,p.aapparentno,p.pmid  as ChildPMID,p.pmparentid,m.aapparentno,m.aapaccountno,m.pmid as ParentPMID,m.pmparentid 
--	   FROM tmp_PM_Pharmacy_testParentID p
--		inner join 
--			(  SELECT aapaccountno,aapparentno,pmid,pmparentid
--				 FROM  tmp_PM_Pharmacy_testParentID 
--				 WHERE      aapaccountno is not null 
--			 ) m
--	   on p.aapparentno = m.aapaccountno   where    p.aapaccountno is not null  
--order by m.pmid
END








GO
