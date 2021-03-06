USE [DynamicsODS]
GO
/****** Object:  StoredProcedure [dbo].[usp_ActivitiesUser_Xref_Load]    Script Date: 12/22/2020 6:59:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_ActivitiesUser_Xref_Load]

AS

SET NOCOUNT ON;

BEGIN
BEGIN TRY

	INSERT INTO dbo.Activities_User_Xref(ActivitiesKey,UserKey)
	SELECT c.ActivitiesKey, u.UserKey
	FROM [dbo].[CRM_Activities] AS c
	INNER JOIN [dbo].[CRM_AccountEntity_User] AS u ON c.Regardingobjectid = u.accountid
	WHERE NOT EXISTS(SELECT 1
						FROM dbo.Activities_User_Xref AS x
						WHERE c.ActivitiesKey = x.ActivitiesKey
						AND u.UserKey =  x.UserKey
						)
	ORDER BY c.Activitieskey ASC, u.UserKey ASC


END TRY
BEGIN CATCH

	ROLLBACK TRAN

	----Make sure to close and deallocate CURSOR
	--CLOSE C1
	--DEALLOCATE C1

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
