USE [WebDev]
GO
/****** Object:  StoredProcedure [dbo].[SurveyGetCredentialingRpt]    Script Date: 12/22/2020 8:09:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		John Ngo
-- Create date: 10/21/2014
-- Description:	SurveyGetCredentialingRpt
-- =============================================
CREATE PROCEDURE [dbo].[SurveyGetCredentialingRpt]
	-- Add the parameters for the stored procedure here
	@SurveyId INT,
	@PMId INT, 
	@Login NVARCHAR(50), 
    @Options NVARCHAR(MAX) = ''
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
    -- Insert statements for procedure here

SELECT DISTINCT top 20
'Yes' LoadSurvey,
'Yes' Completed,
'12/12/12' DateCompleted,
	a.PMID, 
	a.NCPDP,
	a.NPI,
	a.OwnerName,
    a.AccountName DBA,
	a.ContactFullName,
	a.Email,
	--a.Address,
	--a.Address2,
	a.Addr1,
	a.Addr2,
	a.City,
	a.State,
	a.Zip,
	a.Phone,
	a.Fax
FROM
    PharmacyMaster.dbo.v_PM_AllWithAffiliates a
-- dbo.v_CredentiallingPrepopulate a
-- LEFT JOIN dbo.SurveyAnswer an
WHERE	(ChainCode IS NOT NULL AND MCQuitDate IS NULL AND (AAPAccountNo IS NOT NULL OR AAPAccountNo <>'') 
		AND aapquitdate is null) OR (ChainCode IS NOT NULL AND MCQuitDate IS NULL AND IsNPP = - 1)
/*

MCParticipants

SELECT Distinct PMID FROM dbo.v_PM_AllWithAffiliates WHERE (ChainCode IS NOT NULL AND MCQuitDate IS NULL AND (AAPAccountNo IS NOT NULL OR AAPAccountNo <>'') AND aapquitdate is null) OR (ChainCode IS NOT NULL AND MCQuitDate IS NULL AND IsNPP = - 1)

*/
END

GO
