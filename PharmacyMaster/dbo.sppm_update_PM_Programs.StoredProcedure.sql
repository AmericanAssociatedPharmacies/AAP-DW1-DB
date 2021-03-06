USE [PharmacyMaster]
GO
/****** Object:  StoredProcedure [dbo].[sppm_update_PM_Programs]    Script Date: 12/22/2020 7:35:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




-- =============================================
-- Author:		< Joni Wilson>
-- Create date: <04/28/2010>
-- Description:	UPdate PM_Programs table
-- =============================================
CREATE PROCEDURE [dbo].[sppm_update_PM_Programs]

AS
BEGIN
 
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
  
	   --- Drop the previous runs table

   IF EXISTS(SELECT name FROM sys.tables
        WHERE name = 'PM_Programs_bkp')
          DROP TABLE PM_Programs_bkp

   SELECT * into PM_Programs_bkp from PM_Programs


   IF EXISTS(SELECT name FROM sys.tables
        WHERE name = 'PM_Programs')
          DROP TABLE PM_Programs
  
	SELECT * into  PM_Programs from (
	SELECT Program_ID as ProgramID,Description,Comment_Const as CommentConst,Category from aap..aapprograms
	)ch
 

    IF EXISTS(SELECT name FROM sys.tables
        WHERE name = 'PM_MemberPrograms_bkp')
          DROP TABLE PM_MemberPrograms_bkp

	SELECT * into PM_MemberPrograms_bkp from PM_MemberPrograms

    IF EXISTS(SELECT name FROM sys.tables
        WHERE name = 'PM_MemberPrograms')
          DROP TABLE PM_MemberPrograms

	SELECT * into  PM_MemberPrograms from (
	SELECT p.PMID,m.ProgramID,m.StartDate,m.EndDate,m.Comment from aap..aapmemberprogram m 
	 join aap..aapaccount a  on m.accountid = a.accountid
	join pharmacymaster..pm_pharmacy p on a.dea = p.dea
	) ch
 



 
END








GO
