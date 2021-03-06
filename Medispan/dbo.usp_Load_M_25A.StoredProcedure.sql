USE [Medispan]
GO
/****** Object:  StoredProcedure [dbo].[usp_Load_M_25A]    Script Date: 12/22/2020 7:12:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[usp_Load_M_25A]

AS

SET NOCOUNT ON;

BEGIN

BEGIN TRY

	BEGIN TRAN

		TRUNCATE TABLE [Archive].[M25_A]

		ALTER TABLE [dbo].[M25_A]
		SWITCH TO [Archive].[M25_A]

		ALTER TABLE [Staging].[M25_A]
		SWITCH TO [dbo].[M25_A]

		UPDATE STATISTICS [dbo].[M25_A]

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
