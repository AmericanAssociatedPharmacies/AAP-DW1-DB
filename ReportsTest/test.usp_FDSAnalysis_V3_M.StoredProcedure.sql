USE [ReportsTest]
GO
/****** Object:  StoredProcedure [test].[usp_FDSAnalysis_V3_M]    Script Date: 12/22/2020 7:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



/*
Author: David Bohler 
Create Date: 11/21/2018 
Update Date 01/07/2018
Description: FDS Data Analysis Network Level 
*/

CREATE PROCEDURE [test].[usp_FDSAnalysis_V3_M]
	--------------
	--Parameters--
	--------------
	@MnthKey INT
	, @PMID    INT
	, @Year INT

AS

SET NOCOUNT ON;

BEGIN
         


	---------------
	--TEMP TABLES--
	---------------

    DECLARE @TempDose TABLE
	(PMID        INT
	, Mnth        INT
	, NDC         VARCHAR(20)
	, Description VARCHAR(100)
	, Sales       DECIMAL(18, 2)
	, Units       INT
	, Doses       DECIMAL(18, 2)
	);

    DECLARE @TempClaim TABLE
	(PMID        INT
	, Mnth        INT
	, NDC         VARCHAR(20)
	, Description VARCHAR(100)
	, Scripts     INT
	, Dispensed   DECIMAL(10, 3)
	, Cost        DECIMAL(18, 2)
	);

    DECLARE @TempDoseCAH TABLE
	(PMID        INT
	, Mnth        INT
	, NDC         VARCHAR(20)
	, Description VARCHAR(100)
	, Sales       DECIMAL(18, 2)
	, Units       INT
	, Doses       DECIMAL(18, 2)
	);


---------------------------
-- API Sales Information -- 
---------------------------
    INSERT INTO @TempDose
    SELECT a.PMID
    , a.Mnth
    , a.NDC
    , a.Description
    , SUM(a.TotalSales) AS Sales
    , SUM(a.TotalUnits) AS Units
    , SUM(a.TotalDoses) AS Doses
    FROM(SELECT t2.NDC
        , t4.PMID
        , t2.Description
        , MONTH(dd.TheDate) AS Mnth
        , SUM(t1.APIInvoiceQuantity) AS TotalUnits
        , SUM(t1.APIExtendedAmount) AS TotalSales
        , t2.PackageSize
        , (SUM(t1.APIInvoiceQuantity) * t2.PackageSize) AS TotalDoses
		FROM SalesDDS.dbo.SalesFact_API AS t1
        INNER JOIN SalesDDS.dbo.DateDim AS dd ON t1.DateKey = dd.DateKey
        INNER JOIN SalesDDS.dbo.DrugDim AS t2 ON t1.DrugKey = t2.DrugKey
        INNER JOIN SalesDDS.dbo.EventDimAPI AS t3 ON t1.APIEventKey = t3.EventKey
                                                      AND t1.APIEventDateKey = t3.DateKey
        INNER JOIN SalesDDS.dbo.PharmacyDim AS t4 ON t1.PharmacyKey = t4.PharmacyKey
		WHERE 
	   dd.Year = @Year
        AND t3.Type = 'Generic'
        AND t3.IsCredit = 0
        AND t3.IsOrderFee = 0
        AND t2.NDC <> 'UNKNOWN'
        AND t4.PMID = @PMID
		GROUP BY t2.NDC
        , t2.Description
        , t4.PMID
        , MONTH(dd.TheDate)
        , t2.PackageSize
		) AS a
    GROUP BY a.PMID
     , a.Mnth
     , a.NDC
     , a.Description
    ORDER BY a.Mnth;

-- Temp Table Check 
--SELECT *
--FROM @TempDose;

----------------
-- FDS Claims --
----------------
    INSERT INTO @TempClaim
    SELECT b.PMID
    , b.Mnth
    , b.NDC
    , b.Description
    , b.Scripts
    , b.Dispensed
    , b.Cost
    FROM(SELECT t4.PMID
        , t2.NDC
        , t2.Description
        , MONTH(dd.TheDate) AS Mnth
        , SUM(t1.ContractCost) AS Cost
        , SUM(t1.QuantityDispensed) AS Dispensed
		--, COUNT(t3.EventKey) AS Scripts
        , COUNT(t1.TransactionCount) AS Scripts
		FROM ClaimsDDS.dbo.ClaimFactFDS AS t1
        INNER JOIN ClaimsDDS.dbo.DateDim AS dd ON t1.DateofServiceKey = dd.DateKey
        INNER JOIN ClaimsDDS.dbo.DrugDim AS t2 ON t1.DrugKey = t2.DrugKey
        INNER JOIN ClaimsDDS.dbo.EventDimFDS AS t3 ON t1.EventKey = t3.EventKey
                                                       AND t1.DateofServiceKey = t3.DateKey
        INNER JOIN ClaimsDDS.dbo.PharmacyDim AS t4 ON t1.PharmacyKey = t4.PharmacyKey
		WHERE 
	   dd.Year = @Year
        AND t2.MultiSourceCode = 'Y'
        AND t4.PMID = @PMID
		GROUP BY t4.PMID
        , MONTH(dd.TheDate)
        , t2.NDC
        , t2.Description
		) AS b
    ORDER BY b.Mnth;

---------------------------
-- CAH Sales Information -- 
---------------------------
    INSERT INTO @TempDoseCAH
    SELECT c.PMID
    , c.Mnth
    , c.NDC
    , c.Description
    , SUM(c.TotalSales) AS CAHSales
    , SUM(c.TotalUnits) AS CAHUnits
    , SUM(c.TotalDoses) AS CAHDoses
    FROM(SELECT t2.NDC
        , t4.PMID
        , t2.Description
        , MONTH(dd.TheDate) AS Mnth
        , SUM(t1.CAHInvoiceQuantity) AS TotalUnits
        , SUM(t1.CAHExtendedSales) AS TotalSales
        , t2.PackageSize
        , (SUM(t1.CAHInvoiceQuantity) * t2.PackageSize) AS TotalDoses
		FROM SalesDDS.dbo.SalesFact_CAH AS t1
        INNER JOIN SalesDDS.dbo.DateDim AS dd ON t1.DateKey = dd.DateKey
        INNER JOIN SalesDDS.dbo.DrugDim AS t2 ON t1.DrugKey = t2.DrugKey
        INNER JOIN SalesDDS.dbo.PharmacyDim AS t4 ON t1.PharmacyKey = t4.PharmacyKey
		WHERE 
	dd.Year = @Year
        AND t2.MultiSourceCode = 'Y'
        AND t2.NDC <> 'UNKNOWN'
        AND t4.PMID = @PMID
		GROUP BY t2.NDC
        , t2.Description
        , t4.PMID
        , MONTH(dd.TheDate)
        , t2.PackageSize
		) AS c
    GROUP BY c.PMID
    , c.Mnth
    , c.NDC
    , c.Description
    ORDER BY c.Mnth;

-- Temp Table Check 
--SELECT *
--FROM @TempDoseCAH

----------------------------------
-----------RESULT TABLE-----------
----------------------------------
--         SELECT CAST(d.PMID AS INT) AS PMID
--              , d.NDC
--              , d.Description
--              , CAST(SUM(d.Sales) AS FLOAT) AS TotalSales
--              , CAST(SUM(d.Cost) AS FLOAT) AS TotalCost
--              , CAST(SUM(d.Units) AS INT) AS TotalUnits
--              , CAST(SUM(d.Doses) AS INT) AS TotalDoses
--              , CAST(SUM(d.Scripts) AS INT) AS TotalScripts
--              , CAST(SUM(d.Dispensed) AS INT) AS TotalDispensed
--              , CASE
--                    WHEN CAST((SUM(d.Doses) / SUM(d.Dispensed)) AS FLOAT) >= 1
--                    THEN 1
--                    ELSE CAST((SUM(d.Doses) / SUM(d.Dispensed)) AS FLOAT)
--                END AS TotalCompliance
--              , CASE
--                    WHEN CAST((SUM(d.Sales) / SUM(d.Cost)) AS FLOAT) >= 1
--                    THEN 1
--                    ELSE CAST((SUM(d.Sales) / SUM(d.Cost)) AS FLOAT)
--                END AS TotalDollarCompliance
--         FROM
--(
--    SELECT t1.PMID
--         , t1.Mnth
--         , t1.NDC
--         , t1.Description
--         , (t1.Sales + t3.Sales) AS Sales
--         , t2.Cost AS Cost
--         , (t1.Units + t3.Units) AS Units
--         , (t1.Doses + t3.Doses) AS Doses
--         , t2.Scripts AS Scripts
--         , t2.Dispensed AS Dispensed
--         , CASE
--               WHEN CAST(((t1.Doses + t3.Doses) / t2.Dispensed) AS FLOAT) >= 1
--               THEN 1
--               ELSE CAST(((t1.Doses + t3.Doses) / t2.Dispensed) AS FLOAT)
--           END AS Compliance
--         , CASE
--               WHEN CAST(((t1.Sales + t3.Sales) / t2.Cost) AS FLOAT) >= 1
--               THEN 1
--               ELSE CAST(((t1.Sales + t3.Sales) / t2.Cost) AS FLOAT)
--           END AS DollarCompliance
--    FROM @TempDose AS t1
--         FULL OUTER JOIN @TempClaim AS t2 ON t1.PMID = t2.PMID
--                                       AND t1.mnth = t2.Mnth
--                                       AND t1.NDC = t2.NDC
--         FULL OUTER JOIN @TempDoseCAH AS t3 ON t1.PMID = t3.PMID
--                                          AND t1.mnth = t3.Mnth
--                                          AND t1.NDC = t3.NDC
--) AS d
--         WHERE d.Mnth = @MnthKey
--         GROUP BY d.PMID
--                , d.Mnth
--                , d.NDC
--                , d.Description
--         ORDER BY d.Description;
--     END;

----------------------------------
-----------RESULT TABLE II--------
----------------------------------

		SELECT t1.PMID
		,t1.mnth
		,t1.NDC
		,t1.Description
		,t1.Scripts
		,t1.Dispensed
		,t1.Cost
		,(ISNULL(t2.Sales,0) + ISNULL(t3.Sales,0)) AS Sales
		,(ISNULL(t2.Units,0) + ISNULL(t3.Units,0)) AS Units
		,(ISNULL(T2.Doses,0) + ISNULL(t3.Doses,0)) AS Doses
		--,CASE
		--   WHEN CAST(((ISNULL(T2.Doses,0) + ISNULL(t3.Doses,0)) / t1.Dispensed) AS FLOAT) >= 1
		--   THEN 1
		--   ELSE CAST(((ISNULL(T2.Doses,0) + ISNULL(t3.Doses,0)) / t1.Dispensed) AS FLOAT)
		-- END AS Compliance
		-- , CASE
		--       WHEN CAST(((ISNULL(t2.Sales,0) + ISNULL(t3.Sales,0)) / t1.Cost) AS FLOAT) >= 1
		--       THEN 1
		--       ELSE CAST(((ISNULL(t2.Sales,0) + ISNULL(t3.Sales,0)) / t1.Cost) AS FLOAT)
		-- END AS DollarCompliance
		FROM @TempClaim AS t1
		     LEFT JOIN @TempDose AS t2 ON t1.NDC = t2.NDC
		                                  AND t1.Mnth = t2.Mnth
		     LEFT JOIN @TempDoseCAH AS t3 ON t1.NDC = t3.NDC
                                     AND t1.Mnth = t3.Mnth

END;
GO
