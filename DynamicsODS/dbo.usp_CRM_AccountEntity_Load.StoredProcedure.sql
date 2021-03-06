USE [DynamicsODS]
GO
/****** Object:  StoredProcedure [dbo].[usp_CRM_AccountEntity_Load]    Script Date: 12/22/2020 6:59:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[usp_CRM_AccountEntity_Load]

AS

SET NOCOUNT ON;

	
BEGIN
BEGIN TRY

	INSERT INTO [dbo].[CRM_AccountEntity]([AddressKey], [APIKey], [CAHKey], [ProfitAmpKey], [ScanTossKey], [SysKey], [UserKey], AttKey)
	SELECT AA.[AddressKey], API.[APIKey], CAH.[CAHKey], PA.[ProfitAmpKey], ST.[ScanTossKey], SY.[SysKey], U.[UserKey], ISNULL(att.AttKey,0) AS AttKey
	FROM [dbo].[CRM_AccountEntity_Address] AS AA 
	INNER JOIN [dbo].[CRM_AccountEntity_API] AS API ON AA.accountid = API.accountid
	INNER JOIN [dbo].[CRM_AccountEntity_CAH] AS CAH ON API.accountid = CAH.accountid
	INNER JOIN [dbo].[CRM_AccountEntity_ProfitAmp] AS PA ON CAH.accountid = PA.accountid
	INNER JOIN [dbo].[CRM_AccountEntity_ScanToss] AS ST ON PA.accountid = ST.accountid
	INNER JOIN [dbo].[CRM_AccountEntity_Sys] AS SY ON ST.accountid = SY.accountid
	INNER JOIN [dbo].[CRM_AccountEntity_User] AS U ON SY.accountid = U.accountid
	LEFT OUTER JOIN [dbo].[CRM_AccountEntity_Attestation] AS att ON u.accountid = att.accountid
	WHERE NOT EXISTS(SELECT 1
					 FROM [dbo].[CRM_AccountEntity] AS A
					 WHERE A.AddressKey = AA.AddressKey
					 AND A.APIKey = API.APIKey
					 AND A.CAHKey = CAH.CAHKey
					 AND A.ProfitAmpKey = PA.ProfitAmpKey
					 AND A.ScanTossKey = ST.ScanTossKey
					 AND A.SysKey = SY.SysKey
					 AND A.UserKey = U.UserKey
					 AND A.AttKey = ISNULL(att.AttKey,0)
					)
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
