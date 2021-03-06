USE [Medispan]
GO
/****** Object:  StoredProcedure [dbo].[usp_Load_DrugMaster]    Script Date: 12/22/2020 7:12:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[usp_Load_DrugMaster]

AS

SET NOCOUNT ON;

BEGIN

BEGIN TRY

	BEGIN TRAN

		TRUNCATE TABLE [Archive].[DrugMaster]

		ALTER TABLE [dbo].[DrugMaster]
		SWITCH TO [Archive].[DrugMaster]

		ALTER TABLE [Staging].[DrugMaster]
		SWITCH TO [dbo].[DrugMaster]

		UPDATE STATISTICS [dbo].[DrugMaster]

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
