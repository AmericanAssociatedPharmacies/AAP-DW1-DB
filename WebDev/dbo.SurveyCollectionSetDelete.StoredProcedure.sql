USE [WebDev]
GO
/****** Object:  StoredProcedure [dbo].[SurveyCollectionSetDelete]    Script Date: 12/22/2020 8:09:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		John Ngo
-- Create date: 3/4/2015
-- Description:	SurveyCollectionSetDelete
-- =============================================
CREATE PROCEDURE [dbo].[SurveyCollectionSetDelete]
	-- Add the parameters for the stored procedure here
	@SurveyId INT,
	@PMId INT, 
	@Login NVARCHAR(50),
    @CollectionId INT,
	@Option NVARCHAR(MAX) -- default is ncpdp and base on surveyid to have different 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @StatusMsg NVARCHAR(MAX), @NCPDP NVARCHAR(15)  
	DECLARE @StatusId INT   -- 1. Yes, Can Create Survey now, 2. Survey Submitted, 
							-- 3. Not Time Expired, 4. not time yet -- any other constrains that limit from survey to display or create now
							-- 5. go to page with @StatusMsg = url
                            -- 6. Deleted Confirm
							-- 7. not able to delete
--- check status 
--SET @NCPDP = (SELECT TOP 1 NCPDP FROM dbo.v_CA_PM_AllWithAffiliates WHERE pmid = @PMId)
SELECT 	@StatusId = 7,@StatusMsg = 'Unable to Delete'  -- not able to delete


IF @SurveyId = 17 AND (@CollectionId > 0) BEGIN -- update control entity
	UPDATE [dbo].[SurveyControlEntity]
	   SET IsControlEntity = 0
	 WHERE Id = @CollectionId;

	SELECT 	@StatusId = 6,@StatusMsg = 'Delete Confirm'  -- confirm delete
END -- IsControlEntity

IF @SurveyId = 26 AND (@CollectionId > 0) BEGIN -- update control entity

	UPDATE [dbo].[SurveyControlEntity]
	   SET IsTechnician = 0,IsActive = 0
	 WHERE Id = @CollectionId;

	SELECT 	@StatusId = 6,@StatusMsg = 'Delete Confirm'  -- confirm delete

END -- IsTechnician

IF @SurveyId = 31 AND (@CollectionId > 0) BEGIN -- update control entity

		UPDATE [dbo].[SurveyControlEntity]
		   SET [IsOwner] = 0
		 WHERE Id = @CollectionId;

		SELECT 	@StatusId = 6,@StatusMsg = 'Delete Confirm'  -- confirm delete
END -- IsOwner

IF @SurveyId = 32 AND (@CollectionId > 0) BEGIN -- update control entity

	UPDATE [dbo].[SurveyControlEntity]
	   SET IsStoreManager = 0
	 WHERE Id = @CollectionId;

	SELECT 	@StatusId = 6,@StatusMsg = 'Delete Confirm'  -- confirm delete

END -- IsStoreManager

IF @SurveyId = 33 AND (@CollectionId > 0) BEGIN -- update control entity

	UPDATE [dbo].[SurveyControlEntity]
	   SET IsPharmacist = 0, IsPIC = 0
	 WHERE Id = @CollectionId;

	SELECT 	@StatusId = 6,@StatusMsg = 'Delete Confirm'  -- confirm delete
		
END -- IsPharmacist

IF (    (@SurveyId = 17 OR @SurveyId = 31 OR @SurveyId = 32 OR @SurveyId = 33) 
		AND (@CollectionId > 0)
	) BEGIN -- update control entity

		UPDATE [dbo].[SurveyControlEntity]
		   SET IsActive = CONVERT(BIT,( CASE WHEN (IsControlEntity = 1							
							OR [IsOwner] = 1
							OR IsStoreManager = 1
							OR IsPharmacist = 1) THEN 1 ELSE 0 END
						   ))
		 WHERE Id = @CollectionId;
		 
		 SELECT 	@StatusId = 6,@StatusMsg = 'Delete Confirm'  -- confirm delete
	
END -- IsActive


IF @SurveyId = 27 OR @SurveyId = 28 BEGIN -- Update a control entity in the collection
	IF (@CollectionId > 0) BEGIN -- update control entity

		UPDATE dbo.SurveyControlEntityCert
		   SET [IsActive] = 0
		 WHERE Id = @CollectionId;

		SELECT 	@StatusId = 6,@StatusMsg = 'Delete Confirm'  -- confirm delete

	END
END -- end survey 27

IF @SurveyId = 23 BEGIN -- Update a ownership
	IF (@CollectionId > 0) BEGIN -- update ownership

		UPDATE dbo.SurveyOwnership
		   SET [IsActive] = 0
		 WHERE Id = @CollectionId;

		SELECT 	@StatusId = 6,@StatusMsg = 'Delete Confirm'  -- confirm delete

	END
END -- end survey 23

IF @SurveyId = 24 BEGIN -- Update a ownerRelationship
	IF (@CollectionId > 0) BEGIN -- update ownerRelationship

		UPDATE dbo.SurveyOwnerRelationship
		   SET [IsActive] = 0
		 WHERE Id = @CollectionId;

		SELECT 	@StatusId = 6,@StatusMsg = 'Delete Confirm'  -- confirm delete

	END
END -- end survey 24



	SELECT @StatusId StatusId, @StatusMsg StatusMsg, @@Error Errors
/****
-- SELECT * FROM dbo.SurveyAnswer

GO

DECLARE	@return_value int

EXEC	@return_value = [dbo].[SurveyCollectionSetDelete]
			@SurveyId = 31,
			@PMId =104339,
			@Login = 'itdev3',
			@CollectionId = 1118,
			@Option = ''

SELECT	'Return Value' = @return_value

SELECT Top 1 * FROM PharmacyMaster..PM_ProgramStepMember  WHERE  ProgramID = 183 AND ProgramStepID = 3

*/
END

GO
