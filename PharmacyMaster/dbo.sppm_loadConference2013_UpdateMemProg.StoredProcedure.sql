USE [PharmacyMaster]
GO
/****** Object:  StoredProcedure [dbo].[sppm_loadConference2013_UpdateMemProg]    Script Date: 12/22/2020 7:35:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
-- =============================================
-- Author:		Joni Wilson
-- Create date: 4/26/2010
-- Description:	load Cardinal CHPH file for AAP
-- =============================================
CREATE PROCEDURE [dbo].[sppm_loadConference2013_UpdateMemProg] 
(@createDate as varchar(10)) 
	 AS
 
 
BEGIN 

   IF EXISTS(SELECT name FROM sys.tables
        WHERE name = 'PM_MemberPrograms_bkp')
          DROP TABLE PM_MemberPrograms_bkp;

	SELECT * into PM_MemberPrograms_bkp from pm_memberprograms;


--Need to use this to insert into PM_MemberPrograms so you don't get duplicates -CHAGNE TO PROD!!
   INSERT into  pm_memberprograms   
	SELECT PMID ,'195' as ProgramID,StartDate,null as EndDate,null as Comment,@createDate as Created,@createDate as Modified,  -- CHANGE DATE!!!!!
 	1 as RowVersion ,-1 as AAP from tmp_ConfReg2013_MemProgs where PMID not in (select pmid from  pm_memberprograms  where programid = '195')

 
END

GO
