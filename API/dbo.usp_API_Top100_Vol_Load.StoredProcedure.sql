USE [API]
GO
/****** Object:  StoredProcedure [dbo].[usp_API_Top100_Vol_Load]    Script Date: 12/22/2020 6:09:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[usp_API_Top100_Vol_Load]

AS

SET NOCOUNT ON;

BEGIN

BEGIN TRY

	BEGIN TRAN

		TRUNCATE TABLE [Archive].[API_Top100_Vol]

		ALTER TABLE [dbo].[API_Top100_Vol]
		SWITCH TO [Archive].[API_Top100_Vol]

		ALTER TABLE [Staging].[API_Top100_Vol]
		SWITCH TO [dbo].[API_Top100_Vol]

		UPDATE STATISTICS [dbo].[API_Top100_Vol]

	COMMIT TRAN

END TRY
BEGIN CATCH

	IF @@TRANCOUNT > 0

	ROLLBACK TRAN

	    DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE()
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY()
        DECLARE @ErrorState INT = ERROR_STATE()

    -- Use RAISERROR inside the CATCH block to return error  
    -- information about the original error that caused  
    -- execution to jump to the CATCH block.  
    RAISERROR (@ErrorMessage, -- Message text.  
               @ErrorSeverity, -- Severity.  
               @ErrorState -- State.  
               );

END CATCH


END

GO
