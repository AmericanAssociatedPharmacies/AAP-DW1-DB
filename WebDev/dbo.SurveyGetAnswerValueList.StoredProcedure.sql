USE [WebDev]
GO
/****** Object:  StoredProcedure [dbo].[SurveyGetAnswerValueList]    Script Date: 12/22/2020 8:09:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		John Ngo
-- Create date: 10/20/2014
-- Description:	SurveyGetAnswerValueList
-- =============================================
CREATE PROCEDURE [dbo].[SurveyGetAnswerValueList]
	-- Add the parameters for the stored procedure here
	@SurveyId INT,
	@QuestionId INT = 0,
	@OptionId INT = 0,
	@SurveyEntityId INT,  -- pmid for now
	@CollectionId INT = 0
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	IF ( @SurveyId < 1 )
		SET @SurveyId = NULL;

	IF ( @QuestionId < 1 )
		SET @QuestionId = NULL;

	IF ( @OptionId < 1 )
		SET @OptionId = NULL;

	SET NOCOUNT ON;
    -- Insert statements for procedure here
	SELECT q.id questionid, o.id optionid
	, ISNULL(a.AnswerInput, [dbo].[fnSurveyGetAnswer](o.id,@SurveyEntityId,'', @SurveyId,@QuestionId, @CollectionId)) answer
	--, '' answer
	, o.name [name], o.scopename scopename -- , a.*	
	FROM dbo.SurveyQuestion q 
			INNER JOIN dbo.SurveyOption o on q.id = o.QuestionId
			LEFT JOIN dbo.SurveyAnswer a on o.id = a.OptionId
	WHERE		q.SurveyId = ISNULL(@SurveyId, q.SurveyId) 
			AND q.id = ISNULL(@QuestionId,q.id)
			AND o.id = ISNULL(@OptionId,o.id)
			AND a.pmid = ISNULL(@SurveyEntityId, a.pmid)
			AND ISNULL(a.AnswerInput, [dbo].[fnSurveyGetAnswer](o.id,@SurveyEntityId,'', @SurveyId,@QuestionId, @CollectionId )) IS NOT NULL
	ORDER BY q.[Index] ASC, o.[Index] ASC

/****
-- SELECT * FROM dbo.SurveyAnswer
GO

GO

DECLARE	@return_value int

EXEC	@return_value = [dbo].[SurveyGetAnswerValueList]
		@SurveyId = 9, 
		@QuestionId = 0,
	@OptionId = 0,
	@SurveyEntityId= '104339'  -- pmid for now

SELECT	'Return Value' = @return_value

GO
*/
END

GO
