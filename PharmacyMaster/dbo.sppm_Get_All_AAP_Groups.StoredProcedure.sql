USE [PharmacyMaster]
GO
/****** Object:  StoredProcedure [dbo].[sppm_Get_All_AAP_Groups]    Script Date: 12/22/2020 7:35:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




-- =============================================
-- Author:		< Joni Wilson>
-- Create date: <04/08/2010>
-- Description:	See all groups as they exis now
-- =============================================
CREATE PROCEDURE [dbo].[sppm_Get_All_AAP_Groups]

AS
BEGIN
 
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
  
	SELECT p.pmid,p.accountname,g.group_name,p.apiaccountno ,aga.affiliategroupname, aga.aapid , aap1.groupdesignation ,aap1.aapid from pharmacymaster..pm_pharmacy p
	left outer join
	(
	 SELECT * from pharmacymaster..pm_groups  where affiliateid is not null
	) g on p.businessclass = g.buscls
	left outer join
	(
	  SELECT ag.affiliategroupname,aap.aapid ,aap.groupdesignation from aap..AAPAccountAffiliateGroup a 
	   left outer  join 
	   (
			select affiliategroupname ,affiliategroupid from aap..aapaffiliategroup
	   )ag
	  on a.affiliategroupid = ag.affiliategroupid
	  left outer join 
	  (
		SELECT aapid,accountid,groupdesignation from aap..aapaccount 
	   )aap
	  on a.accountid = aap.accountid
	) aga
	on p.aapaccountno = aga.aapid
	left outer join 
	  (
		SELECT  groupdesignation,aapid from aap..aapaccount 
	   )aap1
	  on p.aapaccountno = aap1.aapid

	order by groupdesignation desc
END








GO
