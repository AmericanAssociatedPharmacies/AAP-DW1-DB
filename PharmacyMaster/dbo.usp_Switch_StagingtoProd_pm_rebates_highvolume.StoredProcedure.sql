USE [PharmacyMaster]
GO
/****** Object:  StoredProcedure [dbo].[usp_Switch_StagingtoProd_pm_rebates_highvolume]    Script Date: 12/22/2020 7:35:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE PROCEDURE [dbo].[usp_Switch_StagingtoProd_pm_rebates_highvolume]

AS

SET NOCOUNT ON;

BEGIN
BEGIN TRY

	BEGIN TRAN

		TRUNCATE TABLE [Archive].[pm_rebates_highvolume_New]

		--Switch data from Prod into Archive
		ALTER TABLE [dbo].[pm_rebates_highvolume_New]
		SWITCH 
		TO [Archive].[pm_rebates_highvolume_New]

		--Switch data from Staging into Prod
		ALTER TABLE [Staging].[pm_rebates_highvolume_New]
		SWITCH 
		TO [dbo].[pm_rebates_highvolume_New]

		UPDATE STATISTICS [dbo].[pm_rebates_highvolume_New]


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
