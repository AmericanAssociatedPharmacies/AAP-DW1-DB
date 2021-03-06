USE [DynamicsODS]
GO
/****** Object:  StoredProcedure [dbo].[usp_CRM_DeleteNonExistentPMID]    Script Date: 12/22/2020 6:59:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_CRM_DeleteNonExistentPMID]

AS

SET NOCOUNT ON;

BEGIN
BEGIN TRY

		--Get rows that need to be deleted.  PMID's will be deleted from Dynamics, this is the clean up process.
		SELECT dt.AddressKey, dt.APIKey, dt.CAHKey, dt.ProfitAmpKey, dt.ScanTossKey, dt.SysKey, dt.UserKey, dt.AttKey
		INTO #foo
		FROM(SELECT e.AddressKey, e.APIKey, e.CAHKey, e.ProfitAmpKey, e.ScanTossKey, e.SysKey, e.UserKey, e.AttKey, u.new_pmid
				FROM [dbo].[CRM_AccountEntity] AS e
				INNER JOIN [dbo].[CRM_AccountEntity_User] AS u ON e.userkey = u.userkey 
				WHERE u.new_pmid IS NOT NULL
				) AS dt
		WHERE NOT EXISTS(SELECT 1
							FROM ODSIntake.[Staging].[CRM_AccountEntity_User] AS s
							WHERE dt.new_pmid = s.new_pmid 
						)
		--Delete rows in the factless fact table.
		DELETE x
		FROM [dbo].[CRM_AccountEntity] AS x
		INNER JOIN #foo AS f ON x.userkey = f.userkey

		--Delete rows in the address table.
		DELETE x
		FROM [dbo].[CRM_AccountEntity_Address] AS x
		INNER JOIN #foo AS f ON x.AddressKey = f.AddressKey

		--Delete rows in the API table.
		DELETE x
		FROM [dbo].[CRM_AccountEntity_API] AS x
		INNER JOIN #foo AS f ON x.APIKey = f.APIKey

		--Delete rows in the CAH table.
		DELETE x
		FROM [dbo].[CRM_AccountEntity_CAH] AS x
		INNER JOIN #foo AS f ON x.CAHKey = f.CAHKey

		--Delete rows in the Profit Amp table.
		DELETE x
		FROM [dbo].[CRM_AccountEntity_ProfitAmp] AS x
		INNER JOIN #foo AS f ON x.ProfitAmpKey = f.ProfitAmpKey

		--Delete rows in the Scan Toss table.
		DELETE x
		FROM [dbo].[CRM_AccountEntity_ScanToss] AS x
		INNER JOIN #foo AS f ON x.ScanTossKey = f.ScanTossKey

		--Delete rows in the Sys table.
		DELETE x
		FROM [dbo].[CRM_AccountEntity_Sys] AS x
		INNER JOIN #foo AS f ON x.SysKey = f.SysKey

		--Delete rows in the User table.
		DELETE x
		FROM [dbo].[CRM_AccountEntity_User] AS x
		INNER JOIN #foo AS f ON x.UserKey = f.UserKey

		--Delete rows in the Attestation table.
		DELETE x
		FROM [dbo].[CRM_AccountEntity_Attestation] AS x
		INNER JOIN #foo AS f ON x.AttKey = f.AttKey
		WHERE x.AttKey > 0

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
