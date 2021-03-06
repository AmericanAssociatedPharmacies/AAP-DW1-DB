USE [PharmacyMaster]
GO
/****** Object:  StoredProcedure [dbo].[sppm_updateMemberProgramsConference2013]    Script Date: 12/22/2020 7:35:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
-- =============================================
-- Author:		Joni Wilson
-- Create date: 4/26/2010
-- Description:	load Cardinal CHPH file for AAP
-- =============================================
CREATE PROCEDURE [dbo].[sppm_updateMemberProgramsConference2013] 
	 AS
 
 
BEGIN 
 

--Need to use this to insert into PM_MemberPrograms so you don't get duplicates
 INSERT into  pm_memberprograms
	SELECT PMID ,'195' as ProgramID,StartDate,null as EndDate,null as Comment,'09/20/2012' as Created,'09/20/2012' as Modified,
 	1 as RowVersion ,-1 as AAP from tmp_ConfReg2013_MemProgs where PMID not in (select pmid from pm_memberprograms where programid = '195')

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
