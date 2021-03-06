USE [PharmacyMaster]
GO
/****** Object:  StoredProcedure [dbo].[sppm_Get_AAP_AffiliateGroups]    Script Date: 12/22/2020 7:35:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




-- =============================================
-- Author:		< Joni Wilson>
-- Create date: <04/08/2010>
-- Description:	See all groups as they exis now
-- =============================================
CREATE PROCEDURE [dbo].[sppm_Get_AAP_AffiliateGroups]

AS
BEGIN
 
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
  
	SELECT aga.affiliategroupname as GroupName,  aga.aapid ,tmp.PMGroupNo
		 from pharmacymaster..pm_pharmacy p
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
		join pharmacymaster..tmp_MapAAPGroupToPMGroup tmp on  tmp.aapgroup = aga.affiliategroupname
	where  aga.affiliategroupname 
	is not null 
END








GO
