USE [PharmacyMaster]
GO
/****** Object:  StoredProcedure [dbo].[sppm_loadConference_DisplayProgramDesc]    Script Date: 12/22/2020 7:35:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
-- =============================================
-- Author:		Joni Wilson
-- Create date: 3/15/2016
-- Description:	Get the description of the Conf Program id in the PharmacyMaster..CurrConfProgramID 
-- =============================================
CREATE PROCEDURE [dbo].[sppm_loadConference_DisplayProgramDesc] 
AS
 
 
BEGIN 


SELECT DESCRIPTION from
(
	SELECT * from PharmacyMaster..pm_programs where programid in (SELECT * from PharmacyMaster..CurrConfProgramID )
) ch


END

GO
