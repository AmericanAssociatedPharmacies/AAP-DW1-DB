USE [WebDev]
GO
/****** Object:  StoredProcedure [dbo].[SurveyGetSurveyOption_20150325]    Script Date: 12/22/2020 8:09:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		John Ngo
-- Create date: 8/18/2014
-- Description:	SurveyGetSurveyOption
-- =============================================
CREATE PROCEDURE [dbo].[SurveyGetSurveyOption_20150325]
	-- Add the parameters for the stored procedure here
	@SurveyId INT, 
	@PMId INT = NULL,
    @CollectionId INT = 0,
    @Option NVARCHAR(200)= NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here

	SELECT 
		's' + CAST(@SurveyId AS NVARCHAR(50)) + 'q' + CAST(o.QuestionId AS NVARCHAR(20)) + 'op' + CAST(o.Id AS NVARCHAR(20)) opId,
		(CASE WHEN @PMID IS NULL OR @PMID = 0 OR SurveyId = 3  OR @Option = 'DefaultOpValue' THEN o.DefaultValue ELSE  dbo.fnSurveyGetAnswer(o.Id,@PMId,NULL,@SurveyId, q.Id, @CollectionId) END) opValue,
		-- (CASE WHEN @PMID IS NULL OR @PMID = 0 THEN o.DefaultValue ELSE  DefaultValue END) opValue,
		--NULL IsSelected,
		o.Id, o.QuestionId, o.Text, o.[Index], o.Html, o.Name, o.IsActive, o.IsTrackChange, o.IsReadOnly
		, o.DefaultValue, o.EnableQIds, o.DisableQIds, o.ScopeName, o.opFormat
		-- , (SELECT top 1 q.Section from dbo.surveyquestion q WHERE q.Id = o.QuestionId) Section
		, q.Section
		--, CAST((CASE WHEN o.DefaultValue LIKE 'select' THEN 1 ELSE 0 END) AS BIT) IsSelect
      
		--, (CASE WHEN [dbo].[fnSurveyGetSelectOpId](@PMId,NULL,@SurveyId, q.Id, @CollectionId) = o.ID THEN 1 ELSE 0 END) IsSelect
        --, [dbo].[fnSurveyGetIsSelect](o.Id,@PMId,NULL,@SurveyId, q.Id, @CollectionId) IsSelect 
        ,CONVERT(BIT,(CASE WHEN dbo.fnSurveyGetAnswer(o.Id,@PMId,NULL,@SurveyId, q.Id, @CollectionId) = CONVERT(NVARCHAR,o.Id) THEN 1 ELSE 0 END)) IsSelect
		, MaxLength
	FROM dbo.SurveyOption o	
		INNER JOIN dbo.SurveyQuestion q ON o.QuestionId = q.Id
	WHERE(o.IsActive IS NULL OR o.IsActive = 1)
	-- AND o.QuestionId IN (SELECT DISTINCT SQ.Id FROM dbo.SurveyQuestion SQ WHERE SQ.SurveyId = @SurveyId AND (SQ.IsActive IS NULL OR SQ.IsActive = 1))
	AND ( q.SurveyId = @SurveyId AND (	q.IsActive IS NULL OR q.IsActive = 1 ) )
	ORDER BY [Index], QuestionId

/****
USE webdev
GO

DECLARE	@return_value int

EXEC	@return_value = [dbo].[SurveyGetSurveyOption]
		@SurveyId = 17, @PMID = 104339, @CollectionId = 1

SELECT	'Return Value' = @return_value

dbo.fnSurveyGetAnswer(o.Id,@PMId,NULL,@SurveyId, q.Id, @CollectionId)

SELECT dbo.fnSurveyGetAnswer(423,104339,NULL,17, 260, 1)


GO
*/
END
GO
