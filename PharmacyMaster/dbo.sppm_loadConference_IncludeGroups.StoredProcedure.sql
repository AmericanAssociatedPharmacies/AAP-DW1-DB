USE [PharmacyMaster]
GO
/****** Object:  StoredProcedure [dbo].[sppm_loadConference_IncludeGroups]    Script Date: 12/22/2020 7:35:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
-- =============================================
-- Author:		Joni Wilson
-- Create date: 4/26/2010
-- Description:	load Cardinal CHPH file for AAP
-- =============================================
CREATE PROCEDURE [dbo].[sppm_loadConference_IncludeGroups] 
	 AS
 
 
BEGIN 

	 IF EXISTS(SELECT name FROM sys.tables
		 WHERE name = 'tmp_ConfReg_Group')
	 BEGIN
      DROP TABLE tmp_ConfReg_Group
     END

---- tmp_ConfReg Is the file API gives me - I add in the GroupNo -- NOTE Change temp table name here if loaded to different table
	SELECT * into tmp_ConfReg_Group from (

		SELECT c.*,case when p.GroupNo is null or p.GroupNo = '' then p.AAPParentNo else p.GroupNo end as GroupNo from tmp_ConfReg c
		left outer join
		(
			SELECT pmid,GroupNO,AAPParentNo from pm_pharmacy 
		) p 
		on c.pmid = p.pmid 
	)ch

	UPDATE tmp_ConfReg_Group set GroupNo = null where GroupNo = ''
 
--

	 IF EXISTS(SELECT name FROM sys.tables
		 WHERE name = 'tmp_ConfReg_MemProgs')
	 BEGIN
      DROP TABLE tmp_ConfReg_MemProgs
     END
----Here I get all PMID's to enter into PM_MemberPrograms table

	SELECT * into tmp_ConfReg_MemProgs from
	( 
		SELECT PMID,GroupNo ,cast(null as DateTime) as StartDate from pm_pharmacy  where groupno in (
		SELECT distinct groupno from tmp_ConfReg_Group  where groupno is not null)	and GroupNo is not null and GroupNo ! = '' and (
		(aapquitdate is null and aapaccountno is not null) or ( apiaccountno is not null and apistatus = 'active') ) and DEA not like '%-BIA%' and DEA not like '%-POA%'
        UNION
		SELECT PMID,AAPParentNo as GroupNo ,cast(null as DateTime) as StartDate from pm_pharmacy  where AAPParentNo in (
		SELECT distinct groupno from tmp_ConfReg_Group  where groupno is not null)	and AAPParentNo is not null and AAPParentNo ! = '' and (
		(aapquitdate is null and aapaccountno is not null) or ( apiaccountno is not null and apistatus = 'active') )  and DEA not like '%-BIA%' and DEA not like '%-POA%'
		UNION
		SELECT PMID,GroupNo,cast(null as DateTime) as StartDate from pm_pharmacy  where pmid in (
		SELECT PMID from tmp_ConfReg_Group where groupno is null)
	)ch



----Update the startDate with date from Julies file - where GroupNo is not null
--
	UPDATE  su  set 
		StartDate = ch.[Date Rec]  
   FROM tmp_ConfReg_MemProgs   su 
	inner join 
		( SELECT [Date Rec] ,GroupNo from tmp_ConfReg_Group where GroupNo is  not  null) ch
   on su.GroupNo = ch.groupno



----Now update startDate by pmid where GroupNo is null
--
	UPDATE  su  set 
	StartDate = ch.[Date Rec]  
    FROM tmp_ConfReg_MemProgs   su 
	inner join 
		( SELECT [Date Rec] ,PMID from tmp_ConfReg_Group where GroupNo is   null) ch
    on su.PMID = ch.PMID
--


----Use todays date if the date in the file was null
	UPDATE tmp_ConfReg_MemProgs set startdate = GetDate() where startdate is null

  

END

GO
