USE [SSRS]
GO
/****** Object:  StoredProcedure [Staging].[usp_Compliance_RSE_20191015]    Script Date: 12/22/2020 8:05:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO








/*
Author: David Bohler 
Create Date: 08/27/2019 
Description: Compliance Report V5
*/

CREATE PROCEDURE [Staging].[usp_Compliance_RSE_20191015] 

@PMID INT

AS

SET NOCOUNT ON;

BEGIN

     DECLARE @TempAPI TABLE
     (GPI               VARCHAR(20)
    , Description       VARCHAR(250)
    , [Purchase Qty]    DECIMAL(18, 2)
    , [Purchases @ AWP] DECIMAL(18, 2)
     );

     DECLARE @TempCAH TABLE
     (GPI               VARCHAR(20)
    , Description       VARCHAR(250)
    , [Purchase Qty]    DECIMAL(18, 2)
    , [Purchases @ AWP] DECIMAL(18, 2)
     );

     DECLARE @TempFDS TABLE
     (GPI              VARCHAR(20)
    , Description      VARCHAR(250)
    , [Dispense Qty]   DECIMAL(18, 2)
    , [Dispense @ AWP] DECIMAL(18, 2)
     );


	 --DECLARE @StartDateKey INT
	 --, @EndDateKey INT

	 --SELECT @StartDateKey = CAST(CONVERT(VARCHAR(20),DATEADD(day, -91, DATEADD(d, 0, DATEDIFF(d, 0, GETDATE()))),112) as INT)
	 --, @EndDateKey = CAST(CONVERT(VARCHAR(20),GETDATE(),112) as INT)
	 --FROM SalesDDS.dbo.DateDim

	-- --Change of Ownership (COO) within current 90 days
	-- DECLARE @C TABLE(PMID INT PRIMARY KEY CLUSTERED)

	--;WITH cte
	--AS(SELECT DISTINCT PMID
	--	FROM DynamicsODS.[dbo].[vwCAHAccount]
	--	CROSS JOIN(SELECT MIN(DateKey) AS StartDateKey
	--				FROM SalesDDS.dbo.DateDim
	--				WHERE DateKey BETWEEN @StartDateKey AND @EndDateKey
	--				) AS cj
	--	WHERE AAPEffectiveDateKey >= cj.StartDateKey 
	--	AND PreviousMemberPMID IS NOT NULL
	--	AND PMID = @PMID

	--	UNION ALL

	--	SELECT a.PreviousMemberPMID AS PMID
	--	FROM cte AS c
	--	INNER JOIN DynamicsODS.[dbo].[vwCAHAccount] AS a  ON a.PMID = c.PMID
	--	)
	--INSERT INTO @C
	--SELECT DISTINCT PMID
	--FROM cte




	 ----Get linked PMID's and exclude COO
	 --DECLARE @T TABLE (PMID INT)

	 --INSERT INTO @T(PMID)	 
	 --SELECT DISTINCT e.PMID
	 --FROM(SELECT ca.PMID
		--  FROM(SELECT u.new_PMID AS PMID
		--		FROM DynamicsODS.[dbo].[CRM_AccountEntity_User] AS u
		--		INNER JOIN DynamicsODS.[dbo].[CRM_AccountEntity_API] AS A ON u.[accountid] = a.[accountid]
		--		WHERE new_pmid = @PMID
		--	 ) AS dt
		--CROSS APPLY(SELECT u.new_PMID AS PMID
		--			FROM DynamicsODS.[dbo].[CRM_AccountEntity_User] AS u
		--			INNER JOIN DynamicsODS.[dbo].[CRM_AccountEntity_API] AS A ON u.[accountid] = a.[accountid]
		--			) AS ca
		--) AS e
	 --WHERE NOT EXISTS(SELECT 1
		--				FROM @c AS c
		--			 WHERE e.PMID = c.PMID
		--		     )


 --   INSERT INTO @TempAPI(GPI, Description, [Purchase Qty], [Purchases @ AWP])
	--SELECT x.GPI
	--, x.Description
	--, SUM(x.[Purchase Qty]) AS [Purchase Qty]
	--, SUM(x.[Purchases @ AWP]) AS [Purchases @ AWP]
	--FROM(SELECT d.GPI
	--	, d.Description
	--	, SUM(d.Doses) AS [Purchase Qty]
	--	, SUM(d.Doses) * d.AWPPerDose AS [Purchases @ AWP]
	--	FROM(SELECT a.NDC
	--		, b.GPI
	--		, b.Description
	--		, a.InvDate
	--		, a.InvNbr
	--		, CASE
	--			WHEN a.ExtSales < 0
	--			THEN(a.Qty * -1)
	--			ELSE a.Qty
	--		END AS Qty
	--		, b.PackageSize
	--		, b.PackageQuantity
	--		, CASE
	--			WHEN a.ExtSales < 0
	--			THEN(a.Qty * -1) * b.PackageSize * b.PackageQuantity
	--			ELSE a.Qty * b.PackageSize * b.PackageQuantity
	--		END AS Doses
	--		, b.AWPPerDose
	--		FROM API.dbo.APISalesDetail AS a
	--		INNER JOIN(SELECT t1.NDC
	--			, t1.GPI
	--			, t1.Description
	--			, t1.PackageSize
	--			, t1.PackageQuantity
	--			, t1.AWPPerDose
	--			FROM SalesDDS.dbo.DrugDim AS t1
	--			WHERE t1.Strength IS NOT NULL
	--			) AS b ON a.NDC = b.NDC
	--		INNER JOIN(SELECT t2.TheDate
	--			FROM SalesDDS.dbo.DateDim AS T2
	--			WHERE t2.TheDate >= DATEADD(day, -91, DATEADD(d, 0, DATEDIFF(d, 0, GETDATE())))
	--				AND t2.TheDate <= GETDATE()
	--			) AS c ON a.InvDate = c.TheDate
	----INNER JOIN(SELECT DISTINCT t3.PMID
	----			, t3.APINumber
	----			FROM RXMaster.dbo.PharmacyDim AS t3
	----			WHERE t3.PMID = @PMID
	----			) AS d ON a.WHAccountID = d.APINumber
	--		WHERE a.Type IN('Generic', 'Brand')
	--		AND EXISTS(SELECT 1
	--					FROM @T AS t
	--					WHERE a.WHAccountID = t.APIAccount			
	--					)
	--		) AS d
	--GROUP BY d.GPI
	--, d.Description
	--, d.AWPPerDose
	--) AS x
	--GROUP BY x.GPI
	--, x.Description;

	--SELECT GPI
	--, Description
	--, AWPPerDose
	--, Doses
	--INTO #fooAPI
	--FROM SalesDDS.[dbo].[APIComplianceReport]
	--WHERE PMID = @PMID

	
	--SELECT DISTINCT dd.GPI
	--, dd.Description
	--, dd.AWPPerDose
	--, a.[APIInvoiceQuantity] * dd.PackageSize * dd.PackageQuantity AS Doses
	----INTO #fooAPI
	--FROM SalesDDS.dbo.SalesFact_API AS a
	--INNER JOIN SalesDDS.dbo.EventDimAPI AS e ON a.[APIEventKey] = e.EventKey
	--											AND a.[APIEventDateKey] = e.DateKey
	--INNER JOIN SalesDDS.dbo.PharmacyDim AS pd ON a.PharmacyKey = pd.PharmacyKey
	--INNER JOIN SalesDDS.dbo.DrugDim AS dd ON a.DrugKey = dd.DrugKey
	--WHERE a.DateKey BETWEEN @StartDateKey AND @EndDateKey
	--AND e.Type IN ('Generic', 'Brand')	
	--AND dd.Strength IS NOT NULL
	--AND pd.PMID = @PMID
	--AND NOT EXISTS(SELECT 1
	--				FROM @C AS c
	--				WHERE c.PMID = pd.PMID
	--				)


	INSERT INTO @TempAPI(GPI, Description, [Purchase Qty], [Purchases @ AWP])
	SELECT DISTINCT z.GPI
    , z.Description
    , SUM(z.[Dispense Qty]) AS [Dispense Qty]
    , SUM(z.[Dispense @ AWP]) AS [Dispense @ AWP]
    FROM(SELECT DISTINCT GPI
		, Description
		, SUM(Doses) AS [Dispense Qty]
		, CAST(SUM(Doses) * (AWPPerDose) AS DECIMAL(18, 2)) AS [Dispense @ AWP]
		FROM SalesDDS.[dbo].[APIComplianceReport]
		WHERE PMID = @PMID
		GROUP BY GPI
		, Description
		, AWPPerDose
		) AS z
    GROUP BY z.GPI
    , z.Description;

	

	----CAH
	--SELECT DISTINCT d.GPI
	--, d.Description
	--, d.AWPPerDose
	--, c.[CAHInvoiceQuantity] * d.PackageSize * d.PackageQuantity AS Doses
	--INTO #fooCAH
	--FROM SalesDDS.dbo.SalesFact_CAH AS c
	----INNER JOIN(SELECT DateKey
	----				FROM ClaimsDDS.dbo.DateDim
	----				WHERE TheDate >= DATEADD(day, -91, DATEADD(d, 0, DATEDIFF(d, 0, GETDATE())))
	----			) AS dd ON c.DateKey = dd.DateKey
	--INNER JOIN SalesDDS.dbo.DrugDim AS d ON c.DrugKey = d.DrugKey
	--INNER JOIN SalesDDS.dbo.EventDimCAH AS e ON c.[CAHEventKey] = e.EventKey
	--INNER JOIN SalesDDS.dbo.PharmacyDim AS pd ON c.PharmacyKey = pd.PharmacyKey 
	--WHERE c.DateKey BETWEEN @StartDateKey AND @EndDateKey
	--AND d.Strength IS NOT NULL
	--AND e.[ItemType] = 'Rx'
	--AND NOT EXISTS(SELECT 1
	--				FROM @C AS c
	--				WHERE c.PMID = pd.PMID
	--				)


	INSERT INTO @TempCAH(GPI, Description, [Purchase Qty], [Purchases @ AWP])
	SELECT DISTINCT z.GPI
    , z.Description
    , SUM(z.[Dispense Qty]) AS [Dispense Qty]
    , SUM(z.[Dispense @ AWP]) AS [Dispense @ AWP]
    FROM(SELECT DISTINCT GPI
		, Description
		, SUM(Doses) AS [Dispense Qty]
		, CAST(SUM(Doses) * (AWPPerDose) AS DECIMAL(18, 2)) AS [Dispense @ AWP]
		FROM SalesDDS.[dbo].[CAHComplianceReport]
		WHERE PMID = @PMID
		GROUP BY GPI
		, Description
		, AWPPerDose
		) AS z
    GROUP BY z.GPI
    , z.Description;



 --    --CAH--
	--INSERT INTO @TempCAH
	--SELECT y.GPI
	--, y.Description
	--, SUM(y.[Purchase Qty]) AS [Purchase Qty]
	--, SUM(y.[Purchases @ AWP]) AS [Purchases @ AWP]
	--FROM(SELECT d.GPI
	--	, d.Description
	--	, SUM(d.Doses) AS [Purchase Qty]
	--	, SUM(d.Doses) * d.AWPPerDose AS [Purchases @ AWP]
	--	FROM(SELECT a.NDC
	--		, b.GPI
	--		, b.Description
	--		, a.INV_DATE
	--		, a.INVOICE_NO
	--		, a.SHIP_QTY AS Qty
	--		, b.PackageSize
	--		, b.PackageQuantity
	--		,  a.SHIP_QTY * b.PackageSize * b.PackageQuantity AS Doses
	--		, b.AWPPerDose
	--		, a.DateKey
	--		FROM Purchases.dbo.CHPH_AAP AS a
	--		INNER JOIN(SELECT t1.NDC
	--					, t1.GPI
	--					, t1.Description
	--					, t1.PackageSize
	--					, t1.PackageQuantity
	--					, t1.AWPPerDose
	--					FROM SalesDDS.dbo.DrugDim AS t1
	--					--ReMoves coumpounding Rxs 10/14
	--					WHERE t1.Strength IS NOT NULL
	--					) AS b ON a.NDC = b.NDC
	--		INNER JOIN(SELECT t2.DateKey
	--					FROM SalesDDS.dbo.DateDim AS T2
	--					WHERE t2.TheDate >= DATEADD(day, -91, DATEADD(d, 0, DATEDIFF(d, 0, GETDATE())))
	--					) AS c ON a.DateKey = c.DateKey
	--		WHERE 
	--		--a.PMID = @PMID
	--		--AND 
	--		a.ITEM_TYPE = 'Rx'
	--		AND EXISTS(SELECT 1
	--					FROM @T AS t 
	--					WHERE a.PMID = t.PMID			
	--				   )
	--		) AS d
	--GROUP BY d.GPI
	--, d.Description
	--, d.AWPPerDose
	--) AS y
	--GROUP BY y.GPI
	--, y.Description;


	--SELECT dt.GPI	
	--, dt.Description
	--, dt.QuantityDispensed 
	--, dt.AWPPerDose
	--INTO #fooFDS
	--FROM(SELECT ROW_NUMBER() OVER(PARTITION BY t3.fillDate, t3.[ServiceProviderIDQualifier], t3.[DispensedProductID] ,t1.[RefillNumber], t3.PrescriptionNumber  ORDER BY t3.EventKey ASC) AS RN
	--	, t2.GPI
	--	, t2.Description
	--	, t1.QuantityDispensed 
	--	, t2.AWPPerDose
	--	FROM ClaimsDDS.dbo.ClaimFactFDS AS t1
	--	INNER JOIN(SELECT DateKey
	--				FROM ClaimsDDS.dbo.DateDim
	--				WHERE TheDate >= DATEADD(day, -91, DATEADD(d, 0, DATEDIFF(d, 0, GETDATE())))
	--				) AS dd ON t1.DateofServiceKey = dd.DateKey
	--	INNER JOIN ClaimsDDS.dbo.DrugDim AS t2 ON t1.DrugKey = t2.DrugKey
	--	INNER JOIN ClaimsDDS.dbo.EventDimFDS AS t3 ON t1.EventKey = t3.EventKey
	--	INNER JOIN ClaimsDDS.dbo.PharmacyDim AS t4 ON t1.PharmacyKey = t4.PharmacyKey
	--	WHERE t2.NDC <> 'UNKNOWN'
	--	--AND t4.PMID = @PMID
	--	AND t2.IsRX = 1
	--	AND t2.IsOTC = 0
	--	AND t2.Strength IS NOT NULL
	--	AND t3.PayerSequence = 1
	--	AND t3.ClaimStatusCode IN('C', 'P')
	--	AND t1.QuantityDispensed <= 9999
	--	AND EXISTS(SELECT 1
	--				FROM @T AS t
	--				WHERE t4.PMID = t.PMID		
	--			   )
	--   ) AS dt
	--WHERE dt.RN = 1


	     -- FDS -- 
    INSERT INTO @TempFDS(GPI, Description, [Dispense Qty], [Dispense @ AWP])
    SELECT DISTINCT z.GPI
    , z.Description
    , SUM(z.[Dispense Qty]) AS [Dispense Qty]
    , SUM(z.[Dispense @ AWP]) AS [Dispense @ AWP]
    FROM(SELECT DISTINCT GPI
		, Description
		, SUM(QuantityDispensed) AS [Dispense Qty]
		, CAST(SUM(QuantityDispensed) * (AWPPerDose) AS DECIMAL(18, 2)) AS [Dispense @ AWP]
		FROM ClaimsDDS.[Staging].[FDSComplianceReport]
		WHERE PMID = @PMID
		GROUP BY GPI
		, Description
		, AWPPerDose
		) AS z
	GROUP BY z.GPI
    , z.Description

 --    -- FDS -- 
 --   INSERT INTO @TempFDS
 --   SELECT DISTINCT z.GPI
 --   , z.Description
 --   , SUM(z.[Dispense Qty]) AS [Dispense Qty]
 --   , SUM(z.[Dispense @ AWP]) AS [Dispense @ AWP]
 --   FROM(SELECT DISTINCT GPI
	--	, Description
	--	, SUM(QuantityDispensed) AS [Dispense Qty]
	--	, CAST(SUM(QuantityDispensed) * (AWPPerDose) AS DECIMAL(18, 2)) AS [Dispense @ AWP]
	--	FROM #fooFDS
	--	--FROM ClaimsDDS.dbo.ClaimFactFDS AS t1
	--	--INNER JOIN(SELECT DateKey
	--	--			FROM ClaimsDDS.dbo.DateDim
	--	--			WHERE TheDate >= DATEADD(day, -91, DATEADD(d, 0, DATEDIFF(d, 0, GETDATE())))
	--	--			) AS dd ON t1.DateofServiceKey = dd.DateKey
	--	--INNER JOIN ClaimsDDS.dbo.DrugDim AS t2 ON t1.DrugKey = t2.DrugKey
	--	--INNER JOIN ClaimsDDS.dbo.EventDimFDS AS t3 ON t1.EventKey = t3.EventKey
	--	--INNER JOIN ClaimsDDS.dbo.PharmacyDim AS t4 ON t1.PharmacyKey = t4.PharmacyKey
	--	--WHERE t2.NDC <> 'UNKNOWN'
	--	--AND t4.PMID = @PMID
	--	--AND t2.IsRX = 1
	--	--AND t2.IsOTC = 0
	--	--AND t2.Strength IS NOT NULL
	--	--AND t3.PayerSequence = 1
	--	--AND t3.ClaimStatusCode IN('C', 'P')
	--	--AND t1.QuantityDispensed <= 9999
	--	GROUP BY GPI
	--			, Description
	--			, AWPPerDose
	--	) AS z
 --   GROUP BY z.GPI
 --   , z.Description;

     --Combined --
     SELECT a.GPI
    , a.Description
    , ISNULL(b.[Purchase Qty], 0) + ISNULL(c.[Purchase Qty], 0) AS [Purchase Qty]
    , ISNULL(b.[Purchases @ AWP], 0) + ISNULL(c.[Purchases @ AWP], 0) AS [Purchases @ AWP]
    , a.[Dispense Qty]
    , a.[Dispense @ AWP]
    , (ISNULL(b.[Purchase Qty], 0) + ISNULL(c.[Purchase Qty], 0)) - a.[Dispense Qty] AS [Leakage Quantity]
    , (ISNULL(b.[Purchases @ AWP], 0) + ISNULL(c.[Purchases @ AWP], 0)) - a.[Dispense @ AWP] AS [Leakage @ AWP]
     FROM @TempFDS AS a
    LEFT JOIN @TempAPI AS b ON a.GPI = b.GPI
    LEFT JOIN @TempCAH AS c ON a.GPI = c.GPI
     WHERE a.GPI IS NOT NULL
	 ORDER BY a.GPI ASC;

END 





GO
