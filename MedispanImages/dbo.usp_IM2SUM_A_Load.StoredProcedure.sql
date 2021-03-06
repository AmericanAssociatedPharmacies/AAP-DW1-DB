USE [MedispanImages]
GO
/****** Object:  StoredProcedure [dbo].[usp_IM2SUM_A_Load]    Script Date: 12/22/2020 7:20:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_IM2SUM_A_Load]

AS

SET NOCOUNT ON;

BEGIN
BEGIN TRY

	BEGIN TRAN

	TRUNCATE TABLE [Archive].[IM2SUM_A];

	ALTER TABLE [dbo].[IM2SUM_A]
	SWITCH TO [Archive].[IM2SUM_A]


	INSERT INTO [dbo].[IM2SUM_A](Record_Type, Reserve_1, Sequence_Number, Reserve_2, Comment_Marker, Data_or_Comment)
	SELECT Record_Type, Reserve_1, Sequence_Number, Reserve_2, Comment_Marker, Data_or_Comment
	FROM Staging.vw_IM2SUM_A

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
