USE [WebDev]
GO
/****** Object:  StoredProcedure [dbo].[SurveyGetRecredentialingRpt]    Script Date: 12/22/2020 8:09:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		John Ngo
-- Create date: 10/21/2014
-- Description:	SurveyGetRecredentialingRpt
-- =============================================
CREATE PROCEDURE [dbo].[SurveyGetRecredentialingRpt]
	-- Add the parameters for the stored procedure here
	@Programs NVARCHAR(MAX) = 'ManagedCare',
	@RecredentialingStatusID INT,
    @Options NVARCHAR(MAX)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
    -- Insert statements for procedure here
-- @RecredentialingStatusID is a binary number -
-- 0 All ManagedCare
-- 1 Pharmacies Completed Recredentialing Survey
-- 2 Pharmacies Completed Recredentialing Survey
IF @RecredentialingStatusID = 0 BEGIN
	SELECT DISTINCT s.*
	FROM dbo.[v_Survey_CA_StoreStatus] s
	WHERE s.IsStoreManagedCare = 1 
END 

IF @RecredentialingStatusID = 1 BEGIN

	SELECT DISTINCT s.*
	FROM [dbo].[v_Survey_CA_StoreStatus] s
		--INNER JOIN dbo.SurveyAnswer a on s.PMID = a.PMID
	WHERE s.IsStoreManagedCare = 1 
		  AND s.PMID IN
			(SELECT DISTINCT PMID 
			FROM dbo.surveyanswer a
			WHERE 
				a.IsSubmitted = 1 
				AND a.optionid in (select so.id from dbo.surveyoption so where so.questionid in (select DISTINCT sq.id from dbo.surveyquestion sq where sq.surveyid = 3)) 
			)
END 

IF @RecredentialingStatusID = 2 BEGIN

	SELECT DISTINCT s.*
	FROM -- dbo.v_CA_SurveyStoreStatus s
		dbo.[v_Survey_CA_StoreStatus] s
		--INNER JOIN dbo.SurveyAnswer a on s.PMID = a.PMID
	WHERE s.IsStoreManagedCare = 1 
		  AND s.PMID NOT IN
			(SELECT DISTINCT PMID 
			FROM dbo.surveyanswer a
			WHERE 
				a.IsSubmitted = 1 
				AND a.optionid in (select so.id from dbo.surveyoption so where so.questionid in (select DISTINCT sq.id from dbo.surveyquestion sq where sq.surveyid = 3)) 
			)
END 
-- ORDER BY isCompletedTraining


/****
-- SELECT * FROM dbo.SurveyAnswer

GO

DECLARE	@return_value int

EXEC	@return_value = [dbo].[SurveyGetRecredentialingRpt]
				@Programs  = 'ManagedCare',
				@RecredentialingStatusID = 1,
				@Options = ''

SELECT	'Return Value' = @return_value

SELECT * FROM PharmacyMaster..PM_ProgramStep  WHERE  ProgramID = 183
SELECT Top 1 * FROM PharmacyMaster..PM_ProgramStepMember  WHERE  ProgramID = 183 AND ProgramStepID = 3

*/
END

GO
