USE [DynamicsODS]
GO
/****** Object:  StoredProcedure [dbo].[usp_CRM_AccountEntity_Attestation_Load]    Script Date: 12/22/2020 6:59:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[usp_CRM_AccountEntity_Attestation_Load]

AS 

SET NOCOUNT ON;

BEGIN
BEGIN TRY

	MERGE [dbo].[CRM_AccountEntity_Attestation] AS t
	USING ODSIntake.[Staging].[CRM_AccountEntity_Attestation] AS s
																ON t.accountid = s.accountid

	WHEN MATCHED THEN
	UPDATE 
	SET new_primaryattestation = s.new_primaryattestation
	, new_primaryattestationrequired = ISNULL(s.new_primaryattestationrequired,0)
	, new_primaryattestationrequiredname = s.new_primaryattestationrequiredname
	, new_primaryattestationsent = s.new_primaryattestationsent
	, DateKey = s.DateKey


	WHEN NOT MATCHED THEN

	INSERT(accountid, new_primaryattestation, new_primaryattestationrequired, new_primaryattestationrequiredname, new_primaryattestationsent, DateKey)
	VALUES(s.accountid, s.new_primaryattestation, ISNULL(s.new_primaryattestationrequired,0), s.new_primaryattestationrequiredname, s.new_primaryattestationsent, s.DateKey);


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
