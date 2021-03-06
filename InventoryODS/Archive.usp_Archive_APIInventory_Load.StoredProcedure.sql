USE [InventoryODS]
GO
/****** Object:  StoredProcedure [Archive].[usp_Archive_APIInventory_Load]    Script Date: 12/22/2020 7:02:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [Archive].[usp_Archive_APIInventory_Load]

AS

SET NOCOUNT ON;

BEGIN
BEGIN TRY

	UPDATE STATISTICS [Archive].[APIInventory]
	UPDATE STATISTICS [Staging].[APIInventory]


	INSERT INTO [Archive].[APIInventory](LPSROM, LPLZON, LPLCID, LPPRDC, LPBATC, LPFPUT, LPLPUT, LPLOQT, LPPIQT, LPSTTC, LPLIST, LPPIPR, LPPUPR, LPSDAT, LPLOCT, LPRQNC, LPUQNC, LPNCCN, LPSENC, LPORFN, LPORFL
										, LPLCRE, LPQCYN, LPTDCD, LPHLBA, RowversionID, ETLDateKey, ETLDate, ETLTime
										)
	SELECT s.LPSROM, s.LPLZON, s.LPLCID, s.LPPRDC, s.LPBATC, s.LPFPUT, s.LPLPUT, s.LPLOQT, s.LPPIQT, s.LPSTTC, s.LPLIST, s.LPPIPR, s.LPPUPR, s.LPSDAT, s.LPLOCT, s.LPRQNC, s.LPUQNC, s.LPNCCN, s.LPSENC, s.LPORFN, s.LPORFL
		, s.LPLCRE, s.LPQCYN, s.LPTDCD, s.LPHLBA, s.RowversionID, s.ETLDateKey, s.ETLDate, s.ETLTime
	FROM [Staging].[APIInventory] AS s
	LEFT OUTER JOIN [Archive].[APIInventory] AS a ON s.RowversionID = a.RowversionID
	WHERE a.RowversionID IS NULL
	ORDER BY s.RowversionID ASC

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
