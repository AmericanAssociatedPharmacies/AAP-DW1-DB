USE [SalesDDS]
GO
/****** Object:  StoredProcedure [dbo].[usp_Switch_StagingtoProd_SalesFact_Audited_old_20180817]    Script Date: 12/22/2020 7:55:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[usp_Switch_StagingtoProd_SalesFact_Audited_old_20180817]

AS

SET NOCOUNT ON;

BEGIN
BEGIN TRY

	BEGIN TRAN

		TRUNCATE TABLE [Archive].[SalesFact_Audited]	

		--Switch data from Prod into Archive
		ALTER TABLE [dbo].[SalesFact_Audited]
		SWITCH 
		TO [Archive].[SalesFact_Audited] 

		--Switch data from Staging into Prod
		ALTER TABLE [Staging].[SalesFact_Audited]
		SWITCH 
		TO [dbo].[SalesFact_Audited] 

		UPDATE STATISTICS [dbo].[SalesFact_Audited] 


	COMMIT TRAN

END TRY
BEGIN CATCH

		
	DECLARE 
        @ErrorMessage    NVARCHAR(4000),
        @ErrorNumber     INT,
        @ErrorSeverity   INT,
        @ErrorState      INT,
        @ErrorLine       INT,
        @ErrorProcedure  NVARCHAR(200);

		SELECT 
        @ErrorNumber = ERROR_NUMBER(),
        @ErrorSeverity = ERROR_SEVERITY(),
        @ErrorState = ERROR_STATE(),
        @ErrorLine = ERROR_LINE(),
        @ErrorProcedure = ISNULL(ERROR_PROCEDURE(), '-'),
		@ErrorMessage = ERROR_MESSAGE();

		RAISERROR 
        (
        @ErrorMessage, 
        @ErrorSeverity, 
        1,               
        @ErrorNumber,    -- parameter: original error number.
        @ErrorSeverity,  -- parameter: original error severity.
        @ErrorState,     -- parameter: original error state.
        @ErrorProcedure, -- parameter: original error procedure name.
        @ErrorLine       -- parameter: original error line number.
        );

		ROLLBACK TRAN
	

END CATCH

END






GO
