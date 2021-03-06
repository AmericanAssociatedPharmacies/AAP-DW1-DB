USE [ODSIntake]
GO
/****** Object:  StoredProcedure [dbo].[usp_MedispanFileLog_Load]    Script Date: 12/22/2020 7:30:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[usp_MedispanFileLog_Load]

AS

SET NOCOUNT ON

BEGIN
BEGIN TRY

	DECLARE @DataDir VARCHAR(1000)
	, @ImagesDir VARCHAR(1000)

	SET @DataDir = '\\fs1.aap.local\Server\IT Department\Medispan\FTPDownload\Data\'
	SET @ImagesDir = '\\fs1.aap.local\Server\IT Department\Medispan\FTPDownload\Images\'

	INSERT INTO dbo.MedispanFileLog([FileName], FileSize, FileDowloadDateTime)
	SELECT FilePath, FileSize, FileCreateTime
	FROM [dbo].[mtvf_GetFileInfo](@DataDir)

	UNION ALL 

	SELECT FilePath, FileSize, FileCreateTime
	FROM [dbo].[mtvf_GetFileInfo](@ImagesDir)

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
