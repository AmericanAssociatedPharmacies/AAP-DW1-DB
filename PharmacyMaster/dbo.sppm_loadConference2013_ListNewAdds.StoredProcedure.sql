USE [PharmacyMaster]
GO
/****** Object:  StoredProcedure [dbo].[sppm_loadConference2013_ListNewAdds]    Script Date: 12/22/2020 7:35:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
-- =============================================
-- Author:		Joni Wilson
-- Create date: 4/26/2010
-- Description:	load Cardinal CHPH file for AAP
-- =============================================
CREATE PROCEDURE [dbo].[sppm_loadConference2013_ListNewAdds] 
(@in_date varchar(10))
	 AS
 
 
BEGIN 



-- --SQL for file to send to Julie
 SELECT PMID,AccountName,AAPAccountNo,AAPParentNo,AAPQuitDate,APIAccountNo,APIStatus,GroupNo,Affiliate from v_pm_allwithaffiliates where pmid in (
	SELECT pmid from pm_memberprograms where created = @in_date and programid = '195' and enddate is null) order by aapparentno desc,groupno desc


END

GO
