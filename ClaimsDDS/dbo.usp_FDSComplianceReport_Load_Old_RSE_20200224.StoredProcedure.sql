USE [ClaimsDDS]
GO
/****** Object:  StoredProcedure [dbo].[usp_FDSComplianceReport_Load_Old_RSE_20200224]    Script Date: 12/22/2020 6:54:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO









CREATE PROCEDURE [dbo].[usp_FDSComplianceReport_Load_Old_RSE_20200224]

AS

SET NOCOUNT ON;

BEGIN
	 
	 
	 --Change of Ownership (COO) within current 90 days
	 DECLARE @C TABLE(PMID INT PRIMARY KEY CLUSTERED)

	  DECLARE @StartDateKey INT
	 , @EndDateKey INT
	 , @DateKeyLoop INT

	 SELECT @StartDateKey = CAST(CONVERT(VARCHAR(20),DATEADD(day, -365, DATEADD(d, 0, DATEDIFF(d, 0, GETDATE()))),112) as INT)
	 , @EndDateKey = CAST(CONVERT(VARCHAR(20),GETDATE(),112) as INT)
	 FROM SalesDDS.dbo.DateDim

	 DECLARE C1 CURSOR FOR
	 SELECT DateKey
	 FROM SalesDDS.dbo.DateDim
	 WHERE DateKey BETWEEN @StartDateKey AND @EndDateKey
	 ORDER BY DateKey ASC

	 OPEN C1

	 FETCH NEXT
	 FROM C1
	 INTO @DateKeyLoop

	--;WITH cte
	--AS(SELECT DISTINCT PMID
	--	FROM DynamicsODS.[dbo].[vwCAHAccount]
	--	CROSS JOIN(SELECT MIN(DateKey) AS StartDateKey
	--				FROM SalesDDS.dbo.DateDim
	--				WHERE DateKey BETWEEN @StartDateKey AND @EndDateKey
	--				) AS cj
	--	WHERE AAPEffectiveDateKey >= cj.StartDateKey 
	--	AND PreviousMemberPMID IS NOT NULL
	--	AND PMID IS NOT NULL
	
	--	UNION ALL

	--	SELECT a.PreviousMemberPMID AS PMID
	--	FROM cte AS c
	--	INNER JOIN DynamicsODS.[dbo].[vwCAHAccount] AS a  ON a.PMID = c.PMID
	--	)
	--INSERT INTO @C
	--SELECT DISTINCT PMID
	--FROM cte
	--WHERE PMID IS NOT NULL
	
	TRUNCATE TABLE [dbo].[FDSComplianceReport]

	WHILE @@FETCH_STATUS = 0
	BEGIN
	
	
		INSERT INTO [dbo].[FDSComplianceReport](PMID, GPI, Description, AWPPerDose, QuantityDispensed,IsGeneric,PrescriptionNumber,RefillNumber,TransactionDate, NDC, [Is340BClaim],[InvoicePerDose])	
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
		, (ca.AAPSell/dt.Doses) AS InvoicePerDose
		FROM(SELECT DISTINCT t4.PMID
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
			, LTRIM(RTRIM(t3.[DispensedProductID])) AS NDC
			, t3.Is340BClaim
			--, s.[CAHExtendedSales]
			--, (s.[CAHExtendedSales]/t1.QuantityDispensed) AS [InvoicePerDose]
			, (s.[CAHInvoiceQuantity] * t2.PackageSize * t2.PackageQuantity) AS Doses
			FROM ClaimsDDS.dbo.ClaimFactFDS AS t1
			INNER JOIN ClaimsDDS.dbo.DrugDim AS t2 ON t1.DrugKey = t2.DrugKey
			INNER JOIN ClaimsDDS.dbo.EventDimFDS AS t3 ON t1.EventKey = t3.EventKey
			INNER JOIN ClaimsDDS.dbo.PharmacyDim AS t4 ON t1.PharmacyKey = t4.PharmacyKey
			INNER JOIN(SELECT DateKey, DrugKey, [CAHInvoiceQuantity] AS CAHInvoiceQuantity
						FROM SalesDDS.[dbo].[SalesFact_CAH]
						WHERE DateKey = @DateKeyLoop
						AND DrugKey <> 0
						) AS s ON t3.DateKey = s.[DateKey]
								 AND t1.DrugKey = s.DrugKey
			WHERE t1.DateOfServiceKey = @DateKeyLoop
			--WHERE t1.DateOfServiceKey BETWEEN @StartDateKey AND @EndDateKey
			--AND t2.NDC <> 'UNKNOWN'	-- 01/15/2020 Removed per Dave	
			--AND t2.IsRX = 1 -- 01/15/2020 Removed per Dave
			--AND t2.IsOTC = 0 -- 01/15/2020 Removed per Dave
			--AND t2.Strength IS NOT NULL -- 01/15/2020 Removed per Dave
			AND t3.PayerSequence = 1
			AND t3.ClaimStatusCode IN('C', 'P')
			AND t1.QuantityDispensed <= 9999
			AND t1.QuantityDispensed > 0
			AND t4.PMID <> 0 -- 02/05/2020 Added by RSE to filter out unmapped PMID's
			AND t2.GPI <> 'UNKNOWN'
			AND s.CAHInvoiceQuantity IS NOT NULL-- Added to filter to avoid issue related to divided by zero
			AND s.CAHInvoiceQuantity > 0
			AND t2.PackageSize IS NOT NULL
			AND t2.PackageSize > 0
			AND t2.PackageQuantity IS NOT NULL
			AND t2.PackageQuantity > 0
			--AND NOT EXISTS(SELECT 1
			--				FROM @C AS c
			--				WHERE c.PMID = t4.PMID
			--				)
			) AS dt
			CROSS APPLY(SELECT ca.CorrectedNDCUPC
					, ca.AAPSell
					FROM(SELECT MAX(DateKey) AS MaxDateKey
						FROM CAHODS.[dbo].[CAH_FormularyFile]
						) AS dt
					CROSS APPLY CAHODS.[dbo].[CAH_FormularyFile] AS ca
					WHERE ca.DateKey = dt.MaxDateKey
					) AS ca
			WHERE dt.Doses > 0---IS NOT NULL
			AND ca.CorrectedNDCUPC = dt.NDC


		 FETCH NEXT
		 FROM C1
		 INTO @DateKeyLoop

	END

	CLOSE C1
	DEALLOCATE C1

END














GO
