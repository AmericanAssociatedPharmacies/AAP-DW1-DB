USE [Reports]
GO
/****** Object:  StoredProcedure [dbo].[usp_APISalesUnaudited_Monthly_Load]    Script Date: 12/22/2020 7:39:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_APISalesUnaudited_Monthly_Load]

AS

SET NOCOUNT ON;

BEGIN
BEGIN TRY

	BEGIN TRAN

	TRUNCATE TABLE [Archive].[APISalesUnaudited_Monthly]

	ALTER TABLE [dbo].[APISalesUnaudited_Monthly]
	SWITCH TO [Archive].[APISalesUnaudited_Monthly]
	
	ALTER TABLE [Staging].[APISalesUnaudited_Monthly]
	SWITCH TO [dbo].[APISalesUnaudited_Monthly]

	--Update stats
	UPDATE STATISTICS [dbo].[APISalesUnaudited_Monthly];

	COMMIT TRAN

END TRY
BEGIN CATCH

	ROLLBACK TRAN

	DECLARE @ErrorMessage NVARCHAR(4000)
        , @ErrorNumber INT
        , @ErrorSeverity INT
        , @ErrorState INT
        , @ErrorLine INT
        , @ErrorProcedure NVARCHAR(200)

		SELECT 
        @ErrorNumber = ERROR_NUMBER()
        , @ErrorSeverity = ERROR_SEVERITY()
        , @ErrorState = ERROR_STATE()
        , @ErrorLine = ERROR_LINE()
        , @ErrorProcedure = ISNULL(ERROR_PROCEDURE(), '-')
		, @ErrorMessage = ERROR_MESSAGE();

		RAISERROR 
        (@ErrorMessage 
        , @ErrorSeverity, 1               
        , @ErrorNumber    -- parameter: original error number.
        , @ErrorSeverity  -- parameter: original error severity.
        , @ErrorState     -- parameter: original error state.
        , @ErrorProcedure -- parameter: original error procedure name.
        , @ErrorLine       -- parameter: original error line number.
        );

END CATCH

END

GO
