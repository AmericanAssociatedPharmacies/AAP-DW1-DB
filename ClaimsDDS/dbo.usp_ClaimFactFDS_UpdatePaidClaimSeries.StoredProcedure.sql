USE [ClaimsDDS]
GO
/****** Object:  StoredProcedure [dbo].[usp_ClaimFactFDS_UpdatePaidClaimSeries]    Script Date: 12/22/2020 6:54:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_ClaimFactFDS_UpdatePaidClaimSeries]

AS

SET NOCOUNT ON;

BEGIN
BEGIN TRY


	TRUNCATE TABLE [Staging].[ClaimFactFDSIsPaidClaim]

	--Get the rows for the entire series we need to UPDATE. For the purposes of this load, a "series" is the: PMID, PrescriptionNumber, and RefillNumber
	INSERT INTO [Staging].[ClaimFactFDSIsPaidClaim]([DateofServiceKey], [PharmacyKey], [DrugKey], [EventKey], [IsPaidClaim])
	SELECT f.DateofServiceKey, f.PharmacyKey, f.DrugKey, f.EventKey, f.IsPaidClaim
	FROM dbo.ClaimFactFDS AS f 
	INNER JOIN dbo.PharmacyDim AS pd ON f.PharmacyKey = pd.PharmacyKey
	WHERE pd.PMID > 0
	AND f.QuantityDispensed BETWEEN 1 AND 9999
	AND f.DrugKey > 0
	AND EXISTS(SELECT 1
				FROM [Staging].[FDS] AS s
				INNER JOIN dbo.EventDimFDS AS e ON e.PrescriptionNumber = s.PrescriptionNumber
												AND s.CorrectedPMID = e.PMID
				WHERE f.RefillNumber = s.RefillNumber		
				AND e.EventKey = f.EventKey										
				) 
	ORDER BY f.DateofServiceKey ASC, f.PharmacyKey ASC, f.DrugKey ASC, f.EventKey ASC

	UPDATE STATISTICS [Staging].[ClaimFactFDSIsPaidClaim];

	--Update the series in the Staging table
	UPDATE x
	SET IsPaidClaim = ISNULL(lj.IsPaidClaim,0)
	FROM [Staging].[ClaimFactFDSIsPaidClaim] AS x
	LEFT OUTER JOIN dbo.vwFDSPaidClaimsETL AS lj ON x.EventKey = lj.EventKey
											AND lj.DateofServiceKey = x.DateofServiceKey	
	
	--Update the prod table with the new values in the series.
	UPDATE x
	SET IsPaidClaim = s.IsPaidClaim
	FROM [dbo].[ClaimFactFDS] AS x
	INNER JOIN [Staging].[ClaimFactFDSIsPaidClaim] AS s ON s.DateofServiceKey = x.DateOfServiceKey
														AND s.PharmacyKey = x.PharmacyKey
														AND s.DrugKey = x.DrugKey
														AND s.EventKey = x.EventKey

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
