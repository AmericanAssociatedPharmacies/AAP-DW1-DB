USE [ClaimsDDS]
GO
/****** Object:  StoredProcedure [dbo].[usp_MapPMIDs_ClaimFactFDS]    Script Date: 12/22/2020 6:54:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[usp_MapPMIDs_ClaimFactFDS]

AS

SET NOCOUNT ON;

BEGIN
BEGIN TRY

	--Update EventDimFDS
	UPDATE t
	SET CorrectedPMID = s.CorrectedPMID
	FROM dbo.EventDimFDS AS t
	INNER JOIN(SELECT e.EventKey
				, ISNULL(pd1.PMID, pd2.PMID) AS CorrectedPMID
				FROM dbo.EventDimFDS AS e 
				LEFT OUTER JOIN dbo.PharmacyDim AS pd1 ON e.PMID = pd1.PreviousMemberPMID
												AND e.Datekey BETWEEN pd1.AAPEffectiveDateKey AND pd1.AAPQuitDateKey
				LEFT OUTER JOIN dbo.PharmacyDim AS pd2 ON e.PMID = pd2.PMID
														AND e.Datekey BETWEEN pd2.AAPEffectiveDateKey AND pd2.AAPQuitDateKey
				WHERE (pd1.PMID IS NOT NULL	
							OR pd2.PMID IS NOT NULL
						)
				AND e.CorrectedPMID = 0
				) AS s ON t.EventKey = s.EventKey

	--Update ClaimFactFDS
	UPDATE c
	SET [PharmacyKey] = dt.[PharmacyKey]
	FROM dbo.ClaimFactFDS AS c 
	INNER JOIN(SELECT c.DateofServiceKey, c.EventKey, pd.PharmacyKey, e.CorrectedPMID
				FROM dbo.ClaimFactFDS AS c 
				INNER JOIN dbo.EventDimFDS AS e ON c.EventKey = e.EventKey
				INNER JOIN dbo.PharmacyDim AS pd ON e.CorrectedPMID = pd.PMID
				WHERE c.PharmacyKey = 0
				AND e.CorrectedPMID > 0
				) AS dt ON c.DateofServiceKey = dt.DateofServiceKey
							AND c.EventKey = dt.EventKey
		
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
