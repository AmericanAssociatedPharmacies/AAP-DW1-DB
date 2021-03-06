USE [PharmacyMaster]
GO
/****** Object:  StoredProcedure [dbo].[sppm_loadConferenceReg_ListCompare]    Script Date: 12/22/2020 7:35:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
-- =============================================
-- Author:		Joni Wilson
-- Create date: 4/26/2010
-- Description:	load Cardinal CHPH file for AAP
-- =============================================
CREATE PROCEDURE [dbo].[sppm_loadConferenceReg_ListCompare] 

	 AS
 
 
BEGIN 
DECLARE @PID   varchar(10);
SET @PID = (Select PID from PharmacyMaster..CurrConfProgramID);

 SELECT PMID,AccountName,AAPAccountNo,AAPParentNo,AAPQuitDate,APIAccountNo,APIStatus,GroupNo,Affiliate,'In API''s file Not in PM' as Notes from v_pm_allwithaffiliates where pmid in 
   ( SELECT  PMID from tmp_ConfCompare where pmid not in ( select pmid from pm_memberprograms where programid = @PID and enddate is null) )
UNION
 SELECT PMID,AccountName,AAPAccountNo,AAPParentNo,AAPQuitDate,APIAccountNo,APIStatus,GroupNo,Affiliate,'In PM Not in API''s file' as Notes from v_pm_allwithaffiliates where pmid in 
   ( select pmid from pm_memberprograms where programid = @PID and enddate is null and pmid not in (SELECT  PMID from tmp_ConfCompare ) )


END

GO
