USE [WebDev]
GO
/****** Object:  UserDefinedFunction [dbo].[fnSurveyGetAnswer_back]    Script Date: 12/22/2020 8:08:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE FUNCTION [dbo].[fnSurveyGetAnswer_back]
(
	@OptionId INT,
	@PMId INT, 
	--@ScopeName NVARCHAR(500), 
	@Opt NVARCHAR(50) = '',  -- withDefault '' load from other table, '1' load from answer only
	@SurveyId INT = 0,
	@QuestionId INT = 0,
    @CollectionId INT = 0
)
RETURNS NVARCHAR(MAX)
WITH EXECUTE AS CALLER
AS
BEGIN
DECLARE @answer NVARCHAR(MAX), @ScopeName NVARCHAR(500), @DefaultValue NVARCHAR(500), @OptionHtml NVARCHAR(500)

IF (@OptionId IS NULL OR @OptionId = 0 AND @QuestionId > 0 ) BEGIN
    --SELECT * FROM dbo.SurveyOption o INNER JOIN dbo.SurveyAnswer a ON o.Id = a.OptionId WHERE o.QuestionId = @QuestionId AND o.IsActive = 1 AND a.CollectionId = @CollectionId AND a.PMId = @PMId
	SELECT TOP 1 @OptionId = o.Id, @OptionHtml = o.Html 
		FROM dbo.SurveyOption o INNER JOIN dbo.SurveyAnswer a ON o.Id = a.OptionId 
			WHERE o.QuestionId = @QuestionId AND o.IsActive = 1 AND a.CollectionId = @CollectionId AND a.PMId = @PMId
		ORDER BY DateTimeEnter DESC
END ELSE BEGIN
	SELECT TOP 1 @OptionHtml = o.Html 
		FROM dbo.SurveyOption o INNER JOIN dbo.SurveyAnswer a ON o.Id = a.OptionId 
			WHERE o.Id = @OptionId AND o.IsActive = 1 AND a.CollectionId = @CollectionId AND a.PMId = @PMId
    ORDER BY DateTimeEnter DESC
END 

	SELECT @answer =( SELECT TOP 1 (CASE WHEN @OptionHtml = 'radio' THEN AnswerText ELSE AnswerInput END)
							-- SELECT *
							FROM webdev..surveyanswer 
							WHERE pmid = @PMId AND OptionId = @OptionId AND CollectionId = @CollectionId
							ORDER BY DateTimeEnter DESC	
						),
			@ScopeName = ( SELECT TOP 1 ScopeName
							-- SELECT *
							FROM webdev..SurveyOption 
							WHERE Id = @OptionId
						);

IF (@answer IS NULL OR @answer = '') AND @SurveyId = 11 BEGIN
	-- participatedate
	-- ud_president
	-- loadsqldata
	IF ( @ScopeName = 'participatedate' ) BEGIN
		SET @answer = (SELECT TOP 1 CONVERT(VARCHAR(10), StartDate, 101)  FROM PharmacyMaster..PM_ProgramStepMember WHERE ProgramID = 183 AND ProgramStepID = 4 AND @PMId = PMID )
	END

	IF (@ScopeName = 'ud_president' ) BEGIN
		SET @answer = (SELECT TOP 1 [Value] FROM dbo.SurveySetting WHERE [Name] = @ScopeName )
	END

	IF (@ScopeName = 'pharmacyname' ) BEGIN
		SET @answer = (SELECT TOP 1 AccountName FROM PharmacyMaster.dbo.v_PM_AllWithAffiliates WHERE PMID = @PMId	)
	END
END

IF (@answer IS NULL OR @answer = '') AND (@SurveyId = 17 OR @SurveyId = 26 OR @SurveyId = 31 OR @SurveyId = 32 OR @SurveyId = 33) AND @CollectionId > 0 AND @Opt <> '1' BEGIN
	SELECT @answer =(CASE WHEN @ScopeName = 'ControlEntityTitle' THEN c.Title 
						WHEN @ScopeName = 'Type' THEN c.Type
						WHEN @ScopeName = 'LocationType' THEN c.LocationType
						WHEN @ScopeName = 'npi' THEN c.npi
						WHEN @ScopeName = 'Title' THEN c.Title
						WHEN @ScopeName = 'EffectiveDate' THEN c.EffectiveDate
						WHEN @ScopeName = 'PercentOwnership' THEN c.PercentOwnership
						WHEN @ScopeName = 'PharmacistLicense' THEN c.PharmacistLicense
						WHEN @ScopeName = 'StateIssueLicense' THEN c.StateIssueLicense
						WHEN @ScopeName = 'LicenseExpirationDate' THEN c.LicenseExpirationDate
						WHEN @ScopeName = 'Entity' THEN c.Entity
						WHEN @ScopeName = 'DBA' THEN c.DBA
						WHEN @ScopeName = 'FName' THEN c.FName
						WHEN @ScopeName = 'MName' THEN c.MName
						WHEN @ScopeName = 'LName' THEN c.LName
						WHEN @ScopeName = 'SSN' THEN c.SSN
						WHEN @ScopeName = 'FEIN' THEN c.FEIN
						WHEN @ScopeName = 'DOB' THEN c.DOB
						WHEN @ScopeName = 'Address' THEN c.Address
						WHEN @ScopeName = 'Address2' THEN c.Address2
						WHEN @ScopeName = 'City' THEN c.City
						WHEN @ScopeName = 'State' THEN c.State
						WHEN @ScopeName = 'Zip' THEN c.Zip
						WHEN @ScopeName = 'IsActive' THEN c.IsActive
						WHEN @ScopeName = 'CriminalOffense' THEN c.CriminalOffense
						WHEN @ScopeName = 'HasOwnershipWithOtherStore' THEN c.HasOwnershipWithOtherStore
						WHEN @ScopeName = 'HasRelationshipWithOtherOwner' THEN c.HasRelationshipWithOtherOwner
						WHEN @ScopeName = 'IsPIC' THEN c.IsPIC
						WHEN @ScopeName = 'IsControlEntity' THEN c.IsControlEntity
						WHEN @ScopeName = 'IsTechnician' THEN c.IsTechnician
						WHEN @ScopeName = 'IsCertifiedTechnician' THEN c.IsCertifiedTechnician
						WHEN @ScopeName = 'IsPharmacist' THEN c.IsPharmacist
						WHEN @ScopeName = 'IsStoreManager' THEN c.IsStoreManager
						WHEN @ScopeName = 'PharState' THEN c.PharState
						WHEN @ScopeName = 'PharExpDate' THEN c.PharExpDate
						WHEN @ScopeName = 'StateLicNo' THEN c.StateLicNo

					END) 
	FROM dbo.SurveyControlEntity c WHERE c.Id = @CollectionId
END 
			
RETURN @answer
END;
-- usage:
-- dbo.[dbo].[fnSurveyGetDate] (2, 123123, '')

GO
