USE [ClaimsDDS]
GO
/****** Object:  StoredProcedure [dbo].[usp_ComplianceReportXref_Load]    Script Date: 12/22/2020 6:54:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







CREATE PROCEDURE [dbo].[usp_ComplianceReportXref_Load]

	@PMID INT

AS

SET NOCOUNT ON;

BEGIN


	DECLARE @StartDateKey INT
	, @EndDateKey INT

	SELECT @StartDateKey = CAST(CONVERT(VARCHAR(20),DATEADD(yy, DATEDIFF(yy, 0, GETDATE()) -1, 0),112) AS INT)
	, @EndDateKey = CAST(CONVERT(VARCHAR(20),GETDATE(),112) AS INT)
	FROM dbo.DateDim
	


	
			SELECT DISTINCT dt.EventKey
			FROM(SELECT MAX(t3.EventKey) AS EventKey, t4.PMID, t3.PrescriptionNumber, t1.RefillNumber, t3.AuthNumber, MAX(TransactionDate) AS TransactionDate
				FROM ClaimsDDS.dbo.ClaimFactFDS AS t1
				INNER JOIN ClaimsDDS.dbo.DrugDim AS t2 ON t1.DrugKey = t2.DrugKey
				INNER JOIN ClaimsDDS.dbo.EventDimFDS AS t3 ON t1.EventKey = t3.EventKey
				INNER JOIN ClaimsDDS.dbo.PharmacyDim AS t4 ON t1.PharmacyKey = t4.PharmacyKey
				WHERE t3.ClaimStatusCode IN('C', 'P')
				AND t1.QuantityDispensed <= 9999
				AND t1.QuantityDispensed > 0
				--AND t4.PMID <> 0 -- 02/05/2020 Added by RSE to filter out unmapped PMID's
				AND t2.DrugKey > 0
				AND EXISTS(SELECT 1
								FROM(SELECT DISTINCT GPI 
									FROM DrugMaster.[dbo].[vwAPIandCAHCatalog]
									--WHERE (IsAPIActive = 1	OR IsCAHActive = 1)
									) AS ac
								WHERE t2.GPI= ac.GPI						
							)
				AND t4.PMID = @PMID
				AND t3.EventKey = (t3.EventKey + 0)
				AND t1.DateofServiceKey = (t1.DateofServiceKey + 0)
				AND t2.MultiSourceCode IN('Y','M','N','O')
				AND t1.DateofServiceKey BETWEEN @StartDateKey AND @EndDateKey
				AND NOT EXISTS(SELECT 1
								FROM [dbo].[ComplianceReportXref] AS x
								WHERE t3.EventKey = x.EventKey
								)	
				GROUP BY t4.PMID, t3.PrescriptionNumber, t1.RefillNumber, t3.AuthNumber			             
				) AS dt
			LEFT OUTER JOIN(SELECT t3.EventKey, t4.PMID, t3.PrescriptionNumber, t1.RefillNumber, t3.AuthNumber, t3.TransactionDate
								FROM ClaimsDDS.dbo.ClaimFactFDS AS t1
								INNER JOIN ClaimsDDS.dbo.DrugDim AS t2 ON t1.DrugKey = t2.DrugKey
								INNER JOIN ClaimsDDS.dbo.EventDimFDS AS t3 ON t1.EventKey = t3.EventKey
								INNER JOIN ClaimsDDS.dbo.PharmacyDim AS t4 ON t1.PharmacyKey = t4.PharmacyKey
								WHERE t3.ClaimStatusCode IN('V', 'R')
								AND t1.QuantityDispensed <= 9999
								AND t1.QuantityDispensed > 0
								--AND t4.PMID <> 0 -- 02/05/2020 Added by RSE to filter out unmapped PMID's
								AND t2.DrugKey > 0
								AND EXISTS(SELECT 1
												FROM(SELECT DISTINCT GPI 
													FROM DrugMaster.[dbo].[vwAPIandCAHCatalog]
													--WHERE (IsAPIActive = 1	OR IsCAHActive = 1)
													) AS ac
												WHERE t2.GPI= ac.GPI						
											)
								AND t4.PMID = @PMID
								AND t3.EventKey = (t3.EventKey + 0)
								AND t1.DateofServiceKey = (t1.DateofServiceKey + 0)
								AND t2.MultiSourceCode IN('Y','M','N','O')
								AND t1.DateofServiceKey BETWEEN @StartDateKey AND @EndDateKey
								AND NOT EXISTS(SELECT 1
										FROM [dbo].[ComplianceReportXref] AS x
										WHERE t3.EventKey = x.EventKey
									)        
								) AS cj ON dt.PMID = cj.PMID
												AND dt.PrescriptionNumber = cj.PrescriptionNumber
												AND dt.RefillNumber = cj.RefillNumber
												AND ISNULL(dt.AuthNUmber, 'N\A') = ISNULL(cj.AuthNumber, 'N\A')
												AND dt.TransactionDate > ISNULL(cj.TransactionDate, '19000101')
			--WHERE dt.TransactionDate > ISNULL(cj.TransactionDate, '19000101')
			ORDER BY dt.EventKey ASC


	--INSERT INTO [dbo].[ComplianceReportXref](EventKey)
	--SELECT dt.EventKey
	--FROM(SELECT ROW_NUMBER() OVER(PARTITION BY t4.PMID, t3.[PrescriptionNumber], t1.RefillNumber ,t3.[ClaimStatusCode] ORDER BY t3.[TransactionDate] DESC) AS RN
	--			, t3.EventKey
	--			FROM ClaimsDDS.dbo.ClaimFactFDS AS t1
	--			INNER JOIN ClaimsDDS.dbo.DrugDim AS t2 ON t1.DrugKey = t2.DrugKey
	--			INNER JOIN ClaimsDDS.dbo.EventDimFDS AS t3 ON t1.EventKey = t3.EventKey
	--			INNER JOIN ClaimsDDS.dbo.PharmacyDim AS t4 ON t1.PharmacyKey = t4.PharmacyKey
	--			WHERE t3.PayerSequence = 1
	--			AND t3.ClaimStatusCode IN('C', 'P')
	--			AND t1.QuantityDispensed <= 9999
	--			AND t1.QuantityDispensed > 0
	--			AND t4.PMID <> 0 -- 02/05/2020 Added by RSE to filter out unmapped PMID's
	--			AND t2.DrugKey > 0
	--			--AND t2.GPI <> 'UNKNOWN'		
	--			AND EXISTS(SELECT 1
	--							FROM(SELECT DISTINCT GPI 
	--								FROM DrugMaster.[dbo].[vwAPIandCAHCatalog]
	--								WHERE (IsAPIActive = 1	OR IsCAHActive = 1)
	--								) AS ac
	--							WHERE t2.GPI= ac.GPI						
	--						)
	--			AND t4.PMID = @PMID
	--			AND t3.EventKey = (t3.EventKey + 0)
	--			AND t1.DateofServiceKey = (t1.DateofServiceKey + 0)
	--			AND t2.MultiSourceCode IN('Y','M','N','O')
	--			AND t1.DateofServiceKey BETWEEN @StartDateKey AND @EndDateKey
	--			AND NOT EXISTS(SELECT 1
	--					FROM [dbo].[ComplianceReportXref] AS x
	--					WHERE t3.EventKey = x.EventKey
	--				)
	--			) AS dt
	--WHERE dt.RN = 1





END






GO
