USE [WebDev]
GO
/****** Object:  StoredProcedure [dbo].[SurveyGetCertificationByPMId]    Script Date: 12/22/2020 8:09:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		John Ngo
-- Create date: 3/9/2015
-- Description:	SurveyGetCertificationByPMId
-- =============================================
CREATE PROCEDURE [dbo].[SurveyGetCertificationByPMId]
	-- Add the parameters for the stored procedure here
	@PMId INT,
	@ControlEntityId INT = 0,
	@CertId INT = 0,
    @Option NVARCHAR(250) = NULL
AS
BEGIN

	IF (@PMId = 0)
		SET @PMId = NULL;

	IF (@ControlEntityId = 0)
		SET @ControlEntityId = NULL;

	IF (@CertId = 0)
		SET @CertId = NULL;

	-- SET NOCOUNT ON added to prevent extra result sets from
	SET NOCOUNT ON;
	SELECT e.PMID, r.Id CertId, r.*
	FROM dbo.SurveyControlEntityCert r
			INNER JOIN dbo.SurveyControlEntity e ON r.ControlEntityId = e.Id
	WHERE r.IsActive = 1 AND @PMId = e.PMId AND e.IsActive = 1
	Order BY e.PMID --, e.Id ControlEntityId, c.Id CertificationId

/****

GO

DECLARE	@return_value int

EXEC	@return_value = [dbo].[SurveyGetCertificationByPMId]
		@PMId = 100318

SELECT	'Return Value' = @return_value

GO
*/
END
GO
