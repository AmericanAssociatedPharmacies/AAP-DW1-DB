USE [PharmacyMaster]
GO
/****** Object:  StoredProcedure [dbo].[sppm_update_CHAAP_SALES_PMID]    Script Date: 12/22/2020 7:35:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




-- =============================================
-- Author:		< Joni Wilson>
-- Create date: <04/28/2010>
-- Description:	UPdate PM_Programs table
-- =============================================
CREATE PROCEDURE [dbo].[sppm_update_CHAAP_SALES_PMID]

AS
BEGIN
 
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
  
   --FIRST update missing PMID using any supplied aapaccountno
   UPDATE  s  set 
		pmid = p.pmid  
			FROM chaap_sales   s 
		join
		(
			SELECT pmid,aapaccountno from pm_pharmacy 
		) p
		on s.aapaccountno = p.aapaccountno where 
			s.aapaccountno  is not null 
 
--	SELECT s.pmid,p.pmid from chaap_sales s
--	 join
--	(
--	SELECT pmid,aapaccountno from pm_pharmacy 
--	) p
--	  on s.aapaccountno = p.aapaccountno where 
--	s.aapaccountno  is not null

	


	-- Then update by CHAccountNo aka CAAccountNo


		UPDATE  s  set 
		pmid = pc.pmid  
			FROM chaap_sales   s 
		join
		(
			SELECT c.caaccountno,c.dea,p.pmid  from v_PM_CHAccounts_DEA c 
				join (select pmid, dea  from pm_pharmacy ) p
			on c.dea = p.dea
		) pc
		on cast(s.chaccountno as varchar(32)) = pc.caaccountno


--		SELECT s.pmid,pc.pmid from chaap_sales s
--		 join
--		(
--		SELECT c.caaccountno,c.dea,p.pmid  from v_PM_CHAccounts_DEA c 
--		join (select pmid, dea  from pm_pharmacy ) p
--		on c.dea = p.dea
--
--		) pc on s.chaccountno = pc.caaccountno

	--NEXT UPDATE PMID using udaccountno - that is in the store number for some

	 UPDATE  s  set 
		pmid = p.pmid  
			FROM chaap_sales   s 
		join
		(
			SELECT pmid,udaccountno from pm_pharmacy 
		) p
		on s.aapaccountno = p.udaccountno where 
			s.aapaccountno  is not null and s.pmid is null
 
--	SELECT s.pmid,p.pmid from chaap_sales s
--	 join
--	(
--	SELECT pmid,udaccountno from pm_pharmacy 
--	) p
--	  on s.aapaccountno = p.udaccountno where 
--          s.aapaccountno  is not null and s.pmid is null


-- Next update using our PM_VendorAccts table

   UPDATE  s  set 
		pmid = p.pmid  
			FROM chaap_sales   s 
		join
		(
			SELECT pmid,vendacctnum from pm_vendoraccts 
		) p
		 on cast(s.chaccountno as varchar(32)) =  p.vendacctnum  where 
            s.pmid is null
-- 
--	SELECT s.pmid,p.pmid from chaap_sales s
--	 join
--	(
--	SELECT pmid,vendacctnum from pm_vendoraccts 
--	) p
--	  on cast(s.chaccountno as varchar(32)) =  p.vendacctnum  where 
--            s.pmid is null
-- use the table that Jeff populates from lookups he does
	UPDATE  su  set 
			pmid = ch.pmid  
	   FROM pharmacymaster..chaap_sales   su 
		inner join 
			( select pmid,chaccountno from purchases..CH_PMIDXref where pmid is not null ) ch
	   on su.chaccountno = ch.chaccountno where su.pmid is null

 
END








GO
