USE [WebDev]
GO
/****** Object:  StoredProcedure [dbo].[SurveyGetOwnerRelationship]    Script Date: 12/22/2020 8:09:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		John Ngo
-- Create date: 3/6/2015
-- Description:	SurveyGetOwnerRelationship
-- =============================================
CREATE PROCEDURE [dbo].[SurveyGetOwnerRelationship]
	-- Add the parameters for the stored procedure here
	@PMId INT,
    @CtrlEntityId INT = 0,
	@OwnerRelationshipId INT = 0,
    @Option NVARCHAR(250) = NULL
AS
BEGIN
	IF (@OwnerRelationshipId = 0)
		SET @OwnerRelationshipId = NULL;

	IF (@CtrlEntityId = 0)
		SET @CtrlEntityId = NULL;
	-- SET NOCOUNT ON added to prevent extra result sets from
	SET NOCOUNT ON;
	SELECT r.* FROM dbo.SurveyControlEntity i INNER JOIN dbo.SurveyOwnerRelationship r ON i.Id = r.SurveyControlEntityId 
		WHERE i.PMId = @PMId AND r.IsActive = 1 AND i.IsActive = 1 AND i.Id = ISNULL(@CtrlEntityId, i.Id) AND r.Id = ISNULL(@OwnerRelationshipId, r.Id)

/****

GO

DECLARE	@return_value int

EXEC	@return_value = [dbo].[SurveyGetOwnerRelationship]
		@PMId = 2

SELECT	'Return Value' = @return_value

GO
*/
END
GO
