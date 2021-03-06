USE [ClaimsDDS]
GO
/****** Object:  StoredProcedure [Staging].[usp_FDSComplianceReport_Load]    Script Date: 12/22/2020 6:54:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO








CREATE PROCEDURE [Staging].[usp_FDSComplianceReport_Load]

	

AS

SET NOCOUNT ON;

BEGIN
	 
	  DECLARE @StartDateKey INT
	 , @EndDateKey INT
	
	 
	 SELECT @StartDateKey = CAST(CONVERT(VARCHAR(20),DATEADD(day, -365, DATEADD(d, 0, DATEDIFF(d, 0, GETDATE()))),112) as INT)
	 , @EndDateKey = CAST(CONVERT(VARCHAR(20),GETDATE(),112) as INT)
	 FROM SalesDDS.dbo.DateDim

	TRUNCATE TABLE [Staging].[FDSComplianceReport]
	
		INSERT INTO [Staging].[FDSComplianceReport](PMID, GPI, Description, AWPPerDose, QuantityDispensed,IsGeneric,PrescriptionNumber,RefillNumber,TransactionDate, NDC, [Is340BClaim])	
		SELECT dt.PMID
		, GPI
		, Description
		, AWPPerDose
		, QuantityDispensed
		, IsGeneric
		, PrescriptionNumber
		, RefillNumber
		, TransactionDate
		, NDC
		, [Is340BClaim]	
		FROM(SELECT ROW_NUMBER() OVER(PARTITION BY t4.PMID, t1.DateOfServiceKey ,t3.[PrescriptionNumber], t1.RefillNumber ,t3.[ClaimStatusCode] ORDER BY t1.DateOfServiceKey DESC) AS RN
			, t4.PMID
			, t2.GPI
			, t2.Description		
			, t2.AWPPerDose
			, t1.QuantityDispensed 
			, CASE 
				WHEN t2.[MultiSourceCode] = 'Y' THEN 1
				ELSE 0
				END AS IsGeneric
			, t3.[PrescriptionNumber]
			, t1.[RefillNumber]
			, t3.[TransactionDate]
			, t2.NDC
			, t3.Is340BClaim			
			FROM ClaimsDDS.dbo.ClaimFactFDS AS t1
			INNER JOIN ClaimsDDS.dbo.DrugDim AS t2 ON t1.DrugKey = t2.DrugKey
			INNER JOIN ClaimsDDS.dbo.EventDimFDS AS t3 ON t1.EventKey = t3.EventKey
			INNER JOIN ClaimsDDS.dbo.PharmacyDim AS t4 ON t1.PharmacyKey = t4.PharmacyKey
			WHERE t1.DateOfServiceKey BETWEEN @StartDateKey AND @EndDateKey
			--AND t3.PayerSequence = 1
			AND t3.ClaimStatusCode IN('C', 'P')
			AND t1.QuantityDispensed BETWEEN 1 AND 9999			
			AND t4.PMID <> 0 -- 02/05/2020 Added by RSE to filter out unmapped PMID's
			AND t2.GPI <> 'UNKNOWN'		
			AND EXISTS(SELECT 1
							FROM(SELECT DISTINCT GPI 
								FROM DrugMaster.[dbo].[vwAPIandCAHCatalog]
								WHERE IsAPIActive = 1
								OR IsCAHActive = 1
								) AS ac
							WHERE t2.GPI= ac.GPI						
						)
			) AS dt
			WHERE dt.RN = 1
			

			UPDATE x
			SET ItemCode = 'A'	
			FROM Staging.FDSComplianceReport AS x
			INNER JOIN(SELECT DISTINCT GPI
							FROM SalesDDS.dbo.APIComplianceReport
							) AS a ON a.GPI = x.GPI	


			UPDATE x
			SET ItemCode = 'C'	
			FROM Staging.FDSComplianceReport AS x
			INNER JOIN(SELECT DISTINCT GPI
							FROM SalesDDS.dbo.CAHComplianceReport
							) AS a ON a.GPI = x.GPI	
			WHERE x.ItemCode <> 'A'



				
																		
		
		
		--SELECT dt.PMID
		--, GPI
		--, Description
		--, AWPPerDose
		--, QuantityDispensed
		--, IsGeneric
		--, PrescriptionNumber
		--, RefillNumber
		--, TransactionDate
		--, NDC
		--, [Is340BClaim]
		--, CONVERT(MONEY,(dt.AAPSell/dt.Doses)) AS InvoicePerDose
		--, CONVERT(CHAR(1), dt.ItemCode) AS ItemCode
		--, Doses
		--FROM(SELECT ROW_NUMBER() OVER(PARTITION BY t4.PMID, t3.[PrescriptionNumber], t1.RefillNumber ,t3.[ClaimStatusCode] ORDER BY t3.[TransactionDate] DESC) AS RN
		--	, t4.PMID
		--	, t2.GPI
		--	, t2.Description		
		--	, t2.AWPPerDose
		--	, t1.QuantityDispensed 
		--	, CASE 
		--		WHEN t2.[MultiSourceCode] = 'Y' THEN 1
		--		ELSE 0
		--		END AS IsGeneric
		--	, t3.[PrescriptionNumber]
		--	, t1.[RefillNumber]
		--	, t3.[TransactionDate]
		--	, t2.NDC
		--	, t3.Is340BClaim
		--	--, s.[CAHExtendedSales]
		--	--, (s.[CAHExtendedSales]/t1.QuantityDispensed) AS [InvoicePerDose]
		--	--, (ISNULL(s.[CAHInvoiceQuantity],0.00) * ISNULL(t2.PackageSize,0.00) * ISNULL(t2.PackageQuantity,0.00)) AS Doses
		--	, (ISNULL(s1.[CAHInvoiceQuantity],s2.[APIInvoiceQuantity]) * ISNULL(t2.PackageSize,0.00) * ISNULL(t2.PackageQuantity,0.00)) AS Doses
		--	, ISNULL(s1.CAHUnitAmount,s2.APIUnitAmount) AS AAPSell
		--	, CASE	
		--		WHEN s1.DrugKey IS NOT NULL THEN 'A'
		--		WHEN s2.DrugKey IS NOT NULL THEN 'C'
		--		WHEN s1.DrugKey IS NOT NULL AND s2.DrugKey IS NOT NULL THEN 'A'
		--		END 
		--		AS ItemCode
		--	FROM ClaimsDDS.dbo.ClaimFactFDS AS t1
		--	INNER JOIN ClaimsDDS.dbo.DrugDim AS t2 ON t1.DrugKey = t2.DrugKey
		--	INNER JOIN ClaimsDDS.dbo.EventDimFDS AS t3 ON t1.EventKey = t3.EventKey
		--	INNER JOIN ClaimsDDS.dbo.PharmacyDim AS t4 ON t1.PharmacyKey = t4.PharmacyKey
		--	LEFT OUTER JOIN(SELECT DISTINCT PharmacyKey, DateKey, DrugKey, [CAHInvoiceQuantity] AS CAHInvoiceQuantity, [CAHUnitAmount]
		--				FROM SalesDDS.[dbo].[SalesFact_CAH]
		--				WHERE DateKey BETWEEN @StartDateKey AND @EndDateKey
		--				AND DrugKey <> 0
		--				) AS s1 ON t3.DateKey = s1.[DateKey]
		--						 AND t1.DrugKey = s1.DrugKey
		--						 AND t4.PharmacyKey = s1.PharmacyKey
		--	LEFT OUTER JOIN(SELECT DISTINCT PharmacyKey, DateKey, DrugKey, [APIInvoiceQuantity] AS APIInvoiceQuantity,[APIUnitAmount] 
		--		FROM SalesDDS.[dbo].[SalesFact_API]
		--		WHERE DateKey BETWEEN @StartDateKey AND @EndDateKey
		--		AND DrugKey <> 0
		--		) AS s2 ON t3.DateKey = s2.[DateKey]
		--					AND t1.DrugKey = s2.DrugKey
		--					AND t4.PharmacyKey = s2.PharmacyKey
		--	WHERE t1.DateOfServiceKey BETWEEN @StartDateKey AND @EndDateKey
		--	--WHERE t1.DateOfServiceKey BETWEEN @StartDateKey AND @EndDateKey
		--	--AND t2.NDC <> 'UNKNOWN'	-- 01/15/2020 Removed per Dave	
		--	--AND t2.IsRX = 1 -- 01/15/2020 Removed per Dave
		--	--AND t2.IsOTC = 0 -- 01/15/2020 Removed per Dave
		--	--AND t2.Strength IS NOT NULL -- 01/15/2020 Removed per Dave
		--	AND t3.PayerSequence = 1
		--	AND t3.ClaimStatusCode IN('C', 'P')
		--	AND t1.QuantityDispensed <= 9999
		--	AND t1.QuantityDispensed > 0
		--	AND t4.PMID <> 0 -- 02/05/2020 Added by RSE to filter out unmapped PMID's
		--	AND t2.GPI <> 'UNKNOWN'
		--	AND (s1.DateKey IS NOT NULL
		--			OR s2.DateKey IS NOT NULL
		--		)
		--	AND (s1.DrugKey IS NOT NULL
		--			OR s2.DrugKey IS NOT NULL
		--		)
		--	AND (s1.PharmacyKey IS NOT NULL
		--			OR
		--			s2.PharmacyKey IS NOT NULL
		--		)
				
		--	--AND NOT EXISTS(SELECT 1
		--	--				FROM @C AS c
		--	--				WHERE c.PMID = t4.PMID
		--	--				)
		--	) AS dt
		--	--CROSS APPLY(SELECT ca.CorrectedNDCUPC
		--	--		, ca.AAPSell
		--	--		FROM(SELECT MAX(DateKey) AS MaxDateKey
		--	--			FROM CAHODS.[dbo].[CAH_FormularyFile]
		--	--			) AS dt
		--	--		CROSS APPLY CAHODS.[dbo].[CAH_FormularyFile] AS ca
		--	--		WHERE ca.DateKey = dt.MaxDateKey
		--	--		) AS ca
		--	WHERE dt.Doses > 0
		--	--AND ca.CorrectedNDCUPC = dt.NDC
		--	AND dt.RN = 1
		

END





















GO
