USE [WebDev]
GO
/****** Object:  StoredProcedure [dbo].[SurveyGetBuildSurvey]    Script Date: 12/22/2020 8:09:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		John Ngo
-- Create date: 8/18/2014
-- Description:	<SurveyGetBuildSurvey
-- =============================================
CREATE PROCEDURE [dbo].[SurveyGetBuildSurvey]
	-- Add the parameters for the stored procedure here
	@SurveyId INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @tmpOpIds VARCHAR(MAX);
	SET @tmpOpIds = '';

    -- Insert statements for procedure here
	SELECT 
		SQ.Id as QuestionId,
		SQ.[Name],
		SQ.[Type],
		'' + 's' + CAST(@SurveyId AS NVARCHAR(20)) + 'q' + CAST(SQ.Id AS NVARCHAR(20)) + '' qId, 
		SQ.Title,
		SQ.IsMultipleAnswers,
		'q' + CAST(SQ.Id AS NVARCHAR(20)) AS RadioName,
		OpIds= STUFF((
          SELECT ',' + CAST(op.Id AS NVARCHAR(50))
          FROM dbo.SurveyOption op
          WHERE op.QuestionId = SQ.Id AND op.IsActive = 1
          FOR XML PATH(''), TYPE).value('.', 'NVARCHAR(MAX)'), 1, 1, ''),
		SQ.ChildIds,

(SELECT Top 1 op.EnableQIds 
			FROM dbo.SurveyOption op WHERE op.QuestionId = SQ.Id AND (op.Html = 'text' OR op.Html = 'checkbox' OR (op.[Name] = 'Yes' AND op.Html = 'radio'))  AND op.IsActive = 1) opEnableQIds,
(SELECT Top 1 op.DisableQIds 
			FROM dbo.SurveyOption op WHERE op.QuestionId = SQ.Id AND (op.Html = 'text' OR op.Html = 'checkbox' OR (op.[Name] = 'Yes' AND op.Html = 'radio'))  AND op.IsActive = 1) opDisableQIds,


		SQ.ParentId, 
		-- CAST((CASE WHEN SQ.IsRequired = NULL OR SQ.IsRequired = 0 OR SQ.IsEnable = 0 OR ParentId > 0 THEN 1 else 0 END) AS BIT) IsValid,
		CAST((CASE WHEN SQ.IsRequired = NULL OR SQ.IsRequired = 0 OR SQ.IsEnable = 0 THEN 1 else 0 END) AS BIT) IsValid,
		SQ.IsRequired,
		SQ.RequiredValue,
		SQ.IsEnable, 
		'EnableOption(''' + CAST(SQ.ShowSurveyOptionId AS NVARCHAR(20)) + ''')' EnableFunction, 
--		NULL SelectedOpIds,
--		NULL SelectedOpValues,
		SQ.[Index], SQ.ShowFunction, SQ.ValidateFunction, SQ.ShowSurveyOptionId, SQ.Section
--		OpIdsJSON = '"opIds":[' + STUFF((
--          SELECT ',{"opId":' + CAST(op.Id AS NVARCHAR(50)) + '}'
--          FROM dbo.SurveyOption op
--          WHERE op.QuestionId = SQ.Id AND op.IsActive = 1
--          FOR XML PATH(''), TYPE).value('.', 'NVARCHAR(MAX)'), 1, 1, '') + ']',

--(SELECT @tmpOpIds = @tmpOpIds + CAST(op.Id AS NVARCHAR(50)) + ',' FROM dbo.SurveyOption op WHERE op.QuestionId = SQ.Id AND op.IsActive = 1) OpIds,
		--'' YesOpId,
		--(SELECT Top 1 op.Id FROM dbo.SurveyOption op Where op.QuestionId = SQ.Id AND op.Html = 'checkbox' AND op.IsActive = 1) chkBoxId,
		--(SELECT Top 1 op.Id FROM dbo.SurveyOption op Where op.QuestionId = SQ.Id AND op.[Name] = 'No' AND op.Html = 'radio'  AND op.IsActive = 1) NoId,
		--(SELECT Top 1 op.EnableQIds FROM dbo.SurveyOption op Where op.QuestionId = SQ.Id AND op.[Name] = 'No' AND op.Html = 'radio'  AND op.IsActive = 1) NoEnableQIds,
		--(SELECT Top 1 op.DisableQIds FROM dbo.SurveyOption op Where op.QuestionId = SQ.Id AND op.[Name] = 'No' AND op.Html = 'radio'  AND op.IsActive = 1) NoDisableQIds,
		--(SELECT Top 1 op.RemoveAnswerOpIds FROM dbo.SurveyOption op Where op.QuestionId = SQ.Id AND op.[Name] = 'No' AND op.Html = 'radio'  AND op.IsActive = 1) NoRemoveAnswerOpIds,
		--(SELECT Top 1 qc.Id FROM dbo.SurveyQuestion qc Where qc.ParentId = SQ.Id AND qc.Type Like 'Child%') qTxtId,
		--(SELECT Top 1 qc.Title FROM dbo.SurveyQuestion qc Where qc.ParentId = SQ.Id AND qc.Type Like 'Child%') qTxtTitle,
--		(SELECT Top 1 op.Id 
--			FROM dbo.SurveyOption op WHERE op.QuestionId = SQ.Id AND (op.Html = 'text' OR op.Html = 'checkbox' OR (op.[Name] = 'Yes' AND op.Html = 'radio'))  AND op.IsActive = 1) OpId,
--		(SELECT Top 1 op.Name FROM dbo.SurveyOption op WHERE op.QuestionId = SQ.Id AND (op.Html = 'text' OR op.Html = 'checkbox' OR (op.[Name] = 'Yes' AND op.Html = 'radio'))  AND op.IsActive = 1) opName,
--		(SELECT Top 1 op.html 
--			FROM dbo.SurveyOption op WHERE op.QuestionId = SQ.Id AND (op.Html = 'text' OR op.Html = 'checkbox' OR (op.[Name] = 'Yes' AND op.Html = 'radio'))  AND op.IsActive = 1) opHtml,
--		(SELECT Top 1 op.DefaultValue 
--			FROM dbo.SurveyOption op WHERE op.QuestionId = SQ.Id AND (op.Html = 'text' OR op.Html = 'checkbox' OR (op.[Name] = 'Yes' AND op.Html = 'radio'))  AND op.IsActive = 1) OpValue,
--(SELECT Top 1 op.RemoveAnswerOpIds FROM dbo.SurveyOption op WHERE op.QuestionId = SQ.Id AND (op.Html = 'text' OR op.Html = 'checkbox' OR (op.[Name] = 'Yes' AND op.Html = 'radio'))  AND op.IsActive = 1) opRemoveAnswerOpIds,
	FROM dbo.SurveyQuestion SQ
	WHERE SQ.SurveyId = @SurveyId AND (SQ.IsActive IS NULL OR SQ.IsActive = 1)
	ORDER BY [Index] ASC

	/*SELECT 'q' + CAST(o.QuestionId AS NVARCHAR(20)) + 'op' + CAST(o.Id AS NVARCHAR(20)) OpId, o.*
	FROM dbo.SurveyOption o
	WHERE o.QuestionId IN (SELECT DISTINCT SQ.Id FROM dbo.SurveyQuestion SQ WHERE SQ.SurveyId = @SurveyId AND (SQ.IsActive IS NULL OR SQ.IsActive = 1)) 
		AND (o.IsActive IS NULL OR o.IsActive = 1)
	ORDER BY QuestionId, [Index]*/

/****

GO

DECLARE	@return_value int

EXEC	@return_value = [dbo].[SurveyGetBuildSurvey]
		@SurveyId = 2

SELECT	'Return Value' = @return_value

GO
*/
END
GO
