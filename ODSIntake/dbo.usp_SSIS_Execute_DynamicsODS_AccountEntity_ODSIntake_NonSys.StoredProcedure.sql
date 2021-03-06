USE [ODSIntake]
GO
/****** Object:  StoredProcedure [dbo].[usp_SSIS_Execute_DynamicsODS_AccountEntity_ODSIntake_NonSys]    Script Date: 12/22/2020 7:30:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_SSIS_Execute_DynamicsODS_AccountEntity_ODSIntake_NonSys]

AS

SET NOCOUNT ON;

BEGIN
BEGIN TRY

	TRUNCATE TABLE [Staging].[CRM_AccountEntity_Address];
	TRUNCATE TABLE [Staging].[CRM_AccountEntity_API];
	TRUNCATE TABLE [Staging].[CRM_AccountEntity_CAH];
	TRUNCATE TABLE [Staging].[CRM_AccountEntity_ProfitAmp];
	TRUNCATE TABLE [Staging].[CRM_AccountEntity_ScanToss];
	TRUNCATE TABLE [Staging].[CRM_AccountEntity_User];


	Declare @execution_id bigint

	EXEC [SSISDB].[catalog].[create_execution] 
	@package_name=N'DynamicsODS_AccountEntity_ODSIntake_NonSys.dtsx'
	, @execution_id=@execution_id OUTPUT
	, @folder_name=N'DynamicsODS'
	, @project_name=N'DynamicsODS'
	, @use32bitruntime=False
	, @reference_id=Null

	Select @execution_id
	DECLARE @var0 smallint = 1
	EXEC [SSISDB].[catalog].[set_execution_parameter_value] @execution_id
	, @object_type=50
	, @parameter_name=N'LOGGING_LEVEL'
	, @parameter_value=@var0

	EXEC [SSISDB].[catalog].[start_execution] @execution_id

END TRY
BEGIN CATCH
	

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
