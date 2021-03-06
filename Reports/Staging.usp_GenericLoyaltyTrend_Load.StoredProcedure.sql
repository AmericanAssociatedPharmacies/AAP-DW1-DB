USE [Reports]
GO
/****** Object:  StoredProcedure [Staging].[usp_GenericLoyaltyTrend_Load]    Script Date: 12/22/2020 7:39:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO









CREATE PROCEDURE [Staging].[usp_GenericLoyaltyTrend_Load]

AS

SET NOCOUNT ON;
SET ANSI_WARNINGS OFF;
SET CONCAT_NULL_YIELDS_NULL OFF;

BEGIN
BEGIN TRY

	DECLARE @StartYear DATETIME
       , @CurrentDate DATETIME
       , @GenLoyalty MONEY
       , @Qrtr INT
	   , @EndYear DATETIME
 
       SET @StartYear = DATEADD(yy, DATEDIFF(yy, 0, GETDATE()), 0)
	   SET @EndYear = DATEADD(year, DATEDIFF(year, -1, GETDATE()), 0)
       SET @CurrentDate = DATEADD(DAY, 0, DATEDIFF(DAY, 0, GETDATE()))
       SET @GenLoyalty = 36000.00

	DECLARE @T TABLE(PMID INT, Date DATETIME, APIAccountNo VARCHAR(15), CurrentSales MONEY)

	--This will roll up amounts to most current PMID by APIAccountNo, which is per Wayne's request.
	INSERT INTO @T(PMID, Date, APIAccountNo, CurrentSales)	
	SELECT pd.PMID, dt.Date, pd.APINumber, dt.CurrentSales
	FROM(SELECT Date, PMID, SUM(APIGenericSales) AS CurrentSales
			FROM Reports.[dbo].[vw_APISales] AS AV
			WHERE Date >= @StartYear
			AND Date <= @EndYear
			AND PMID IS NOT NULL
			GROUP BY PMID, Date
		) AS dt
	INNER JOIN RXMaster.dbo.PharmacyDim AS pd ON dt.PMID = pd.PMID
	WHERE pd.APIQuitDate = '29991231'



	TRUNCATE TABLE [Staging].[GenericLoyaltyTrend]

	--Get YTD GLT amount. 
	INSERT INTO [Staging].[GenericLoyaltyTrend](PMID, [CurrentGenericSales])
	SELECT PMID, IIF(dt.CurrentSales >= @GenLoyalty, 0.00, dt.CurrentSales - @GenLoyalty) AS CurrentGenericSales
	FROM(SELECT PMID, APIAccountNo, SUM(CurrentSales) AS CurrentSales
			FROM @T
			GROUP BY PMID, APIAccountNo
		) AS dt
	WHERE dt.PMID IS NOT NULL
	ORDER BY dt.PMID ASC

	MERGE [Archive].[GenericLoyaltyTrend] AS TARGET
	USING(SELECT PMID, APIAccountNo, Date, CurrentSales, CONVERT(DATE, GETDATE()) AS RowCreatedDate
			FROM @T
			) AS SOURCE ON (TARGET.PMID=SOURCE.PMID) 
						AND CONVERT(DATE, TARGET.RowCreatedDate) = CONVERT(DATE, source.RowCreatedDate)
						AND target.date = source.date

	WHEN MATCHED THEN
	UPDATE
	SET  target.CurrentGenericSales = source.CurrentSales 

	WHEN NOT MATCHED THEN
	INSERT (PMID,Date,[CurrentGenericSales])
	VALUES (SOURCE.PMID, SOURCE.Date,SOURCE.CurrentSales);
	

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
