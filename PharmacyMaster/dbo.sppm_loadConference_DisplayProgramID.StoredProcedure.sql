USE [PharmacyMaster]
GO
/****** Object:  StoredProcedure [dbo].[sppm_loadConference_DisplayProgramID]    Script Date: 12/22/2020 7:35:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
-- =============================================
-- Author:		Joni Wilson
-- Create date: 3/15/2016
-- Description:	Get the ID in the PharmacyMaster..CurrConfProgramID 
-- =============================================
CREATE PROCEDURE [dbo].[sppm_loadConference_DisplayProgramID] 
AS
 
 
BEGIN 


SELECT * from PharmacyMaster..CurrConfProgramID

END

GO
