USE [WebDev]
GO
/****** Object:  StoredProcedure [dbo].[SurveyGetSurveyOption_20150409]    Script Date: 12/22/2020 8:09:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		John Ngo
-- Create date: 8/18/2014
-- Description:	SurveyGetSurveyOption_20150409
-- =============================================
CREATE PROCEDURE [dbo].[SurveyGetSurveyOption_20150409]
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
    -- if there are no data in surveyanswer then load the data from table
    --, else load from surveyanswer which (@CollectionId = 0)
    IF EXISTS (SELECT a.Id
		FROM dbo.SurveyAnswer a 
		WHERE a.PMId = @PMId 
			AND a.CollectionId = @CollectionId 
			AND OptionId IN (SELECT TOP 10 o.Id FROM dbo.SurveyOption o INNER JOIN dbo.SurveyQuestion q 
								ON o.QuestionId = q.Id 
								WHERE q.SurveyId =  @SurveyId
							) 
		) BEGIN
		
		SELECT @Option = '1';  -- do not load data from table
    
    END
--------------    
CREATE TABLE #AnswerTbl (
    		opId INT,
    		opValue VARCHAR(MAX)
    );

CREATE INDEX OpIndex ON #AnswerTbl (opId);

INSERT #AnswerTbl
SELECT o.Id, dbo.fnSurveyGetAnswer(o.Id,@PMId,@Option,@SurveyId, q.Id, @CollectionId)
FROM dbo.SurveyOption o	
		INNER JOIN dbo.SurveyQuestion q ON o.QuestionId = q.Id
WHERE (o.IsActive IS NULL OR o.IsActive = 1) 
	AND q.SurveyId = @SurveyId 
	AND ( q.IsActive IS NULL OR q.IsActive = 1 ) 

--SELECT u.OptionId, dbo.fnSurveyGetAnswer(u.OptionId,@PMId,@Option,@SurveyId, NULL, @CollectionId) -- u.AnswerInput
--FROM
--(SELECT a.OptionId, Max(Id) MaxId
--FROM dbo.SurveyAnswer a
--WHERE a.PMId = @PMId AND CollectionId = ISNULL(@CollectionId,CollectionId) 
--	AND a.OptionId IN (SELECT o.Id FROM dbo.SurveyOption o INNER JOIN dbo.SurveyQuestion q 
--								ON o.QuestionId = q.Id 
--								WHERE q.SurveyId =  @SurveyId AND o.IsActive = 1 AND (	q.IsActive IS NULL OR q.IsActive = 1 ))
--Group By a.OptionId) inn INNER JOIN dbo.SurveyAnswer u ON inn.MaxId = u.Id

-- SELECT * FROM #AnswerTbl

------------------------
	SELECT
		's' + CAST(@SurveyId AS NVARCHAR(50)) + 'q' + CAST(o.QuestionId AS NVARCHAR(20)) + 'op' + CAST(o.Id AS NVARCHAR(20)) opId,
		--a.opValue,
        --(CASE WHEN @PMID IS NULL OR @PMID = 0 OR SurveyId = 3  OR @Option = 'DefaultOpValue' THEN o.DefaultValue ELSE  dbo.fnSurveyGetAnswer(o.Id,@PMId,@Option,@SurveyId, q.Id, @CollectionId) END) opValue,
		 (CASE WHEN @PMID IS NULL OR @PMID = 0 OR SurveyId = 3  OR @Option = 'DefaultOpValue' THEN o.DefaultValue ELSE  a.opValue END) opValue,
		-- (CASE WHEN @PMID IS NULL OR @PMID = 0 THEN o.DefaultValue ELSE  DefaultValue END) opValue,
		--NULL IsSelected,
		o.Id, o.QuestionId, o.Text, o.[Index], o.Html, o.Name, o.IsActive, o.IsTrackChange, o.IsReadOnly
		, o.DefaultValue, o.EnableQIds, o.DisableQIds, o.ScopeName, o.opFormat
		-- , (SELECT top 1 q.Section from dbo.surveyquestion q WHERE q.Id = o.QuestionId) Section
		, q.Section
		--, CAST((CASE WHEN o.DefaultValue LIKE 'select' THEN 1 ELSE 0 END) AS BIT) IsSelect
      
		--, (CASE WHEN [dbo].[fnSurveyGetSelectOpId](@PMId,NULL,@SurveyId, q.Id, @CollectionId) = o.ID THEN 1 ELSE 0 END) IsSelect
        --, [dbo].[fnSurveyGetIsSelect](o.Id,@PMId,NULL,@SurveyId, q.Id, @CollectionId) IsSelect 
--        ,CONVERT(BIT,(CASE WHEN
--						(dbo.fnSurveyGetAnswer(o.Id,@PMId,@Option,@SurveyId, q.Id, @CollectionId) 
--								= CONVERT(NVARCHAR,o.Id) 
--						) OR (
--						   dbo.fnSurveyGetAnswer(o.Id,@PMId,@Option,@SurveyId, q.Id, @CollectionId) = 'true'								
--						)
--					THEN 1 ELSE 0 END)) IsSelect
        ,CONVERT(BIT,(CASE WHEN
						(a.opValue = CONVERT(NVARCHAR,o.Id) 
						) OR (
						   a.opValue = 'true'								
						) 
--						OR (
--						   (a.opValue IS NULL OR a.opValue = '') AND o.DefaultValue LIKE 'select%'								
--						)
					THEN 1 ELSE 0 END)) IsSelect
		, MaxLength
	FROM dbo.SurveyOption o	
		INNER JOIN dbo.SurveyQuestion q ON o.QuestionId = q.Id
		LEFT JOIN #AnswerTbl a ON o.Id = a.opId
	WHERE(o.IsActive IS NULL OR o.IsActive = 1)
	-- AND o.QuestionId IN (SELECT DISTINCT SQ.Id FROM dbo.SurveyQuestion SQ WHERE SQ.SurveyId = @SurveyId AND (SQ.IsActive IS NULL OR SQ.IsActive = 1))
	AND ( q.SurveyId = @SurveyId AND (	q.IsActive IS NULL OR q.IsActive = 1 ) )
	ORDER BY [Index], QuestionId


IF OBJECT_ID('tempdb..#AnswerTbl') IS NOT NULL
	Drop TABLE #AnswerTbl

/****
USE webdev
GO

DECLARE	@return_value int

EXEC	@return_value = [dbo].[SurveyGetSurveyOption_20150409]
		@SurveyId = 10, @PMID = 102279, @CollectionId = 0

SELECT	'Return Value' = @return_value

dbo.fnSurveyGetAnswer(o.Id,@PMId,NULL,@SurveyId, q.Id, @CollectionId)

SELECT dbo.fnSurveyGetAnswer(423,104339,NULL,17, 260, 1)


GO
*/
END
GO
