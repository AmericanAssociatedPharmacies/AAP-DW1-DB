USE [Pricing]
GO
/****** Object:  StoredProcedure [dbo].[usp_CardinalsalesYTDAWPreport_Update]    Script Date: 12/22/2020 7:32:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_CardinalsalesYTDAWPreport_Update]

AS

SET NOCOUNT ON;

BEGIN
BEGIN TRY

	SELECT i.NDC, i.NADACPerUnit
	INTO #foo
	FROM(SELECT NDC
		, MAX(EffectiveDate) AS EffectiveDate
		FROM [ODSIntake].[Staging].[NADAC]
		GROUP BY NDC
		) AS dt
	INNER JOIN [ODSIntake].[Staging].[NADAC] AS I ON dt.NDC = i.NDC
											AND dt.EffectiveDate = i.EffectiveDate

	
	UPDATE x
	SET [NADACPricePerUnit] = dt.NADACPricePerUnit
	FROM [dbo].[CardinalsalesYTDAWPreport] AS x
	INNER JOIN(SELECT DISTINCT A.CIN, ca.NADACPricePerUnit
				FROM [dbo].[CardinalsalesYTDAWPreport] AS A
				LEFT OUTER JOIN(SELECT NDC
								, NADACPerUnit
								FROM #foo
								) AS B ON A.NDC = B.NDC
				CROSS APPLY(SELECT CAST(CASE WHEN ISNUMERIC(B.NADACPerUnit) = 1
								 THEN B.NADACPerUnit
								 ELSE NULL END AS MONEY) AS [NADACPricePerUnit]
								) AS ca
				) AS dt ON x.CIN = dt.CIN


	--Run this second
	UPDATE x
	SET AWP = B.AWPPkg
	FROM [dbo].[CardinalsalesYTDAWPreport] AS X
	LEFT OUTER JOIN Medispan.dbo.DrugMaster AS B ON X.NDC = B.NDC

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
