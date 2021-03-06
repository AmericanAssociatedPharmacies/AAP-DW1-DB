USE [PharmacyMaster]
GO
/****** Object:  StoredProcedure [dbo].[sppm_loadConference2013_Old]    Script Date: 12/22/2020 7:35:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
-- =============================================
-- Author:		Joni Wilson
-- Create date: 4/26/2010
-- Description:	load Cardinal CHPH file for AAP
-- =============================================
CREATE PROCEDURE [dbo].[sppm_loadConference2013_Old] 
	 AS
 
 
BEGIN 
-- to add pmid to Julies file -- NOTE Change temp table name here if loaded to different table may have to add the PMID field to temp table
--UPDATE  t  set 
--	t.pmid = p.pmid  
--FROM tmp_conf2013f   t 
--join
--(
--select pmid,aapaccountno,apiaccountno from pm_pharmacy	
--) p
--on t.aap# = p.aapaccountno or t.api# = p.apiaccountno  

	 IF EXISTS(SELECT name FROM sys.tables
		 WHERE name = 'tmp_ConfReg2013_Group')
	 BEGIN
      DROP TABLE tmp_ConfReg2013_Group
     END

---- tmp_ConfReg2013 Is the file Julie gives me - I add in the GroupNo -- NOTE Change temp table name here if loaded to different table
	SELECT * into tmp_ConfReg2013_Group from (

		SELECT c.*,case when p.GroupNo is null or p.GroupNo = '' then p.AAPParentNo else p.GroupNo end as GroupNo from tmp_conf2013f c
		left outer join
		(
			SELECT pmid,GroupNO,AAPParentNo from pm_pharmacy 
		) p 
		on c.pmid = p.pmid 
	)ch

	UPDATE tmp_ConfReg2013_Group set GroupNo = null where GroupNo = ''
 
--

	 IF EXISTS(SELECT name FROM sys.tables
		 WHERE name = 'tmp_ConfReg2013_MemProgs')
	 BEGIN
      DROP TABLE tmp_ConfReg2013_MemProgs
     END
----Here I get all PMID's to enter into PM_MemberPrograms table

	SELECT * into tmp_ConfReg2013_MemProgs from
	( 
		SELECT PMID,GroupNo ,cast(null as DateTime) as StartDate from pm_pharmacy  where groupno in (
		SELECT distinct groupno from tmp_ConfReg2013_Group  where groupno is not null)	and GroupNo is not null and GroupNo ! = '' and (
		(aapquitdate is null and aapaccountno is not null) or ( apiaccountno is not null and apistatus = 'active') )
        UNION
		SELECT PMID,AAPParentNo as GroupNo ,cast(null as DateTime) as StartDate from pm_pharmacy  where AAPParentNo in (
		SELECT distinct groupno from tmp_ConfReg2013_Group  where groupno is not null)	and AAPParentNo is not null and AAPParentNo ! = '' and (
		(aapquitdate is null and aapaccountno is not null) or ( apiaccountno is not null and apistatus = 'active') )
		UNION
		SELECT PMID,GroupNo,cast(null as DateTime) as StartDate from pm_pharmacy  where pmid in (
		SELECT PMID from tmp_ConfReg2013_Group where groupno is null)
	)ch



----Update the startDate with date from Julies file - where GroupNo is not null
--
	UPDATE  su  set 
		StartDate = ch.[Date Rec]  
   FROM tmp_ConfReg2013_MemProgs   su 
	inner join 
		( SELECT [Date Rec] ,GroupNo from tmp_ConfReg2013_Group where GroupNo is  not  null) ch
   on su.GroupNo = ch.groupno



----Now update startDate by pmid where GroupNo is null
--
	UPDATE  su  set 
	StartDate = ch.[Date Rec]  
    FROM tmp_ConfReg2013_MemProgs   su 
	inner join 
		( SELECT [Date Rec] ,PMID from tmp_ConfReg2013_Group where GroupNo is   null) ch
    on su.PMID = ch.PMID
--


----Now update with todays date where date from Julie was null

	UPDATE tmp_ConfReg2013_MemProgs set startdate = GetDate() where startdate is null

  



--Need to use this to insert into PM_MemberPrograms so you don't get duplicates
  --INSERT into  pm_memberprograms  --The actual insert is done in another call - here we just want to display what will be inserted
	SELECT PMID ,'195' as ProgramID,StartDate,null as EndDate,null as Comment,'02/11/2013' as Created,'02/11/2013' as Modified,  -- CHANGE DATE!!!!!
 	1 as RowVersion ,-1 as AAP from tmp_ConfReg2013_MemProgs where PMID not in (select pmid from pm_memberprograms where programid = '195')



------- TO UPDATE ANY THAT HAVE QUIT

--	select su.enddate,su.pmid,ch.aapquitdate,ch.pmid 
--	   FROM pm_memberprograms  su 
--		inner join 
--			(  
--
--				select * from pm_pharmacy where aapquitdate is  not null and pmid in 
--				(
--				select   pmid from pm_memberprograms where programid = '195'
--				and enddate is null
--				) and apistatus  = 'closed'
--
--			) ch
--	   on su.pmid = ch.pmid  where programid = '195'
--
--UPDATE  su  set 
--			enddate = ch.aapquitdate  
--   FROM pm_memberprograms  su 
--		inner join 
--			(  
--
--				select * from pm_pharmacy where aapquitdate is  not null and pmid in 
--				(
--				select   pmid from pm_memberprograms where programid = '195'
--				and enddate is null
--				) and apistatus  = 'closed'
--
--			) ch
--	   on su.pmid = ch.pmid  where programid = '195'

-- Or can update with this

--select * from pm_pharmacy where
--pmid in (select pmid from pm_memberprograms where programid = '195' and enddate is null)
--and apistatus != 'active' and apiaccountno is not null
--and aapquitdate is not null
--
--update pm_memberprograms set enddate = '02/12/2012' where pmid in 
--(100180,
--105238,
--105528,
--105792) and programid = '195'


-- --SQL for file to send to Julie
-- select PMID,AccountName,AAPAccountNo,AAPParentNo,APIAccountNo,APIStatus,GroupNo,Affiliate from v_pm_allwithaffiliates where pmid in (
-- select pmid from pm_memberprograms where created = '02/11/2013'  -- CHANGE DATE 
-- and programid = '195' and enddate is null) order by aapparentno desc,groupno desc
--
-- select PMID,AccountName,AAPAccountNo,AAPParentNo,APIAccountNo,APIStatus,GroupNo,Affiliate from v_pm_allwithaffiliates where pmid in (
-- select pmid from pm_memberprograms  -- CHANGE DATE 
-- where programid = '195' and enddate is null) order by aapparentno desc,groupno desc



-- Original Insert
-- 	SELECT PMID ,'195' as ProgramID,StartDate,null as EndDate,null as Comment,'09/20/2012' as Created,'09/20/2012' as Modified,
-- 	1 as RowVersion ,-1 as AAP from tmp_ConfReg2013_MemProgs

--
--This is a way to get all groups too 
--select distinct pmid,apiaccountno,aapaccountno ,GroupNo from pm_pharmacy 
--where groupno in (select groupno from tmp_ConfReg2013_Group where groupno is not null)
--group by pmid,apiaccountno,aapaccountno ,GroupNo

-- To test if there are any new groups added that weren't there when it was created
--select * from tmp_ConfReg2013_MemProgs where pmid not in (
--select distinct pmid from pm_pharmacy 
--where groupno in (select groupno from tmp_ConfReg2013_Group where groupno is not null)
--group by pmid
--union
--select pmid from tmp_ConfReg2013_Group where groupno is   null
--)

END

GO
