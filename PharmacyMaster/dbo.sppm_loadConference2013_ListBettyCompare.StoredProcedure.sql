USE [PharmacyMaster]
GO
/****** Object:  StoredProcedure [dbo].[sppm_loadConference2013_ListBettyCompare]    Script Date: 12/22/2020 7:35:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
-- =============================================
-- Author:		Joni Wilson
-- Create date: 4/26/2010
-- Description:	load Cardinal CHPH file for AAP
-- =============================================
CREATE PROCEDURE [dbo].[sppm_loadConference2013_ListBettyCompare] 

	 AS
 
 
BEGIN 

 SELECT PMID,AccountName,AAPAccountNo,AAPParentNo,AAPQuitDate,APIAccountNo,APIStatus,GroupNo,Affiliate,'In Betty''s file Not in PM' as Notes from v_pm_allwithaffiliates where pmid in 
   ( SELECT  PMID from tmp_Conf2013Betty where pmid not in ( select pmid from pm_memberprograms where programid = '195' and enddate is null) )
UNION
 SELECT PMID,AccountName,AAPAccountNo,AAPParentNo,AAPQuitDate,APIAccountNo,APIStatus,GroupNo,Affiliate,'In PM Not in Betty''s file' as Notes from v_pm_allwithaffiliates where pmid in 
   ( select pmid from pm_memberprograms where programid = '195' and enddate is null and pmid not in (SELECT  PMID from tmp_Conf2013Betty ) )


END

GO
