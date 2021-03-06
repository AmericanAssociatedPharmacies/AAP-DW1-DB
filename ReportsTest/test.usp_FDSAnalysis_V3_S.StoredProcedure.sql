USE [ReportsTest]
GO
/****** Object:  StoredProcedure [test].[usp_FDSAnalysis_V3_S]    Script Date: 12/22/2020 7:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
Author: David Bohler 
Create Date: 11/21/2018 
Update Date 01/16/2019
Description: FDS Data Analysis
*/

CREATE PROCEDURE [test].[usp_FDSAnalysis_V3_S]
--------------
--Parameters--
--------------
@PMID INT
, @Year INT
--------------

AS
     SET NOCOUNT ON;
    BEGIN
        ---------------
        --TEMP TABLES--
        ---------------

        DECLARE @TempDose TABLE
        (PMID  INT
       , Mnth  INT
       , Sales DECIMAL(18, 2)
       , Units INT
       , Doses DECIMAL(18, 2)
        );
        DECLARE @TempClaim TABLE
        (PMID      INT
       , Mnth      INT
       , Scripts   INT
       , Dispensed DECIMAL(10, 3)
       , Cost      DECIMAL(18, 2)
        );
        DECLARE @TempDoseCAH TABLE
        (PMID  INT
       , Mnth  INT
       , Sales DECIMAL(18, 2)
       , Units INT
       , Doses DECIMAL(18, 2)
        );

        ---------------------------
        -- API Sales Information -- 
        ---------------------------
        INSERT INTO @TempDose
               SELECT a.PMID
                    , a.Mnth
                    , SUM(a.TotalSales) AS Sales
                    , SUM(a.TotalUnits) AS Units
                    , SUM(a.TotalDoses) AS Doses
               FROM
               (
                   SELECT t2.NDC
                        , t4.PMID
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
                   WHERE dd.Year = @Year
                         --AND t3.Type = 'Generic'
                         AND t3.IsCredit = 0
                         AND t3.IsOrderFee = 0
                         AND t2.NDC <> 'UNKNOWN'
                         AND t4.PMID = @PMID
                   GROUP BY t2.NDC
                          , t4.PMID
                          , MONTH(dd.TheDate)
                          , t2.PackageSize
               ) AS a
               GROUP BY a.PMID
                      , a.Mnth
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
                    , b.Scripts
                    , b.Dispensed
                    , b.Cost
               FROM
               (
                   SELECT t4.PMID
                        , MONTH(dd.TheDate) AS Mnth
                        , SUM(t1.ContractCost) AS Cost
                        , SUM(t1.QuantityDispensed) AS Dispensed
                        , SUM(t1.TransactionCount) AS Scripts
                   FROM ClaimsDDS.dbo.ClaimFactFDS AS t1
                        INNER JOIN ClaimsDDS.dbo.DateDim AS dd ON t1.DateofServiceKey = dd.DateKey
                        INNER JOIN ClaimsDDS.dbo.DrugDim AS t2 ON t1.DrugKey = t2.DrugKey
                        INNER JOIN ClaimsDDS.dbo.EventDimFDS AS t3 ON t1.EventKey = t3.EventKey
                                                                      AND t1.DateofServiceKey = t3.DateKey
                        INNER JOIN ClaimsDDS.dbo.PharmacyDim AS t4 ON t1.PharmacyKey = t4.PharmacyKey
                   WHERE dd.Year = @Year
						AND t3.ClaimStatusCode IN('C', 'P')
						--AND t2.DrugType <> 'SINGLE-SOURCE BRAND'
						--AND t3.BIN IS NOT NULL
						--AND t3.PCN IS NOT NULL
						AND t3.PayerSequence = 1
                   GROUP BY t4.PMID
                          , MONTH(dd.TheDate)
               ) AS b
               ORDER BY b.Mnth;

        ---------------------------
        -- CAH Sales Information -- 
        ---------------------------
        INSERT INTO @TempDoseCAH
               SELECT c.PMID
                    , c.Mnth
                    , SUM(c.TotalSales) AS CAHSales
                    , SUM(c.TotalUnits) AS CAHUnits
                    , SUM(c.TotalDoses) AS CAHDoses
               FROM
               (
                   SELECT t2.NDC
                        , t4.PMID
                        , MONTH(dd.TheDate) AS Mnth
                        , SUM(t1.CAHInvoiceQuantity) AS TotalUnits
                        , SUM(t1.CAHExtendedSales) AS TotalSales
                        , t2.PackageSize
                        , (SUM(t1.CAHInvoiceQuantity) * t2.PackageSize) AS TotalDoses
                   FROM SalesDDS.dbo.SalesFact_CAH AS t1
                        INNER JOIN SalesDDS.dbo.DateDim AS dd ON t1.DateKey = dd.DateKey
                        INNER JOIN SalesDDS.dbo.DrugDim AS t2 ON t1.DrugKey = t2.DrugKey
                        INNER JOIN SalesDDS.dbo.PharmacyDim AS t4 ON t1.PharmacyKey = t4.PharmacyKey
                   WHERE dd.Year = @Year
                         --AND t2.MultiSourceCode = 'Y'
                         AND t2.NDC <> 'UNKNOWN'
                         AND t4.PMID = @PMID
                   GROUP BY t2.NDC
                          , t4.PMID
                          , MONTH(dd.TheDate)
                          , t2.PackageSize
               ) AS c
               GROUP BY c.PMID
                      , c.Mnth
               ORDER BY c.Mnth;

        -- Temp Table Check 
        --SELECT *
        --FROM @TempDoseCAH
        ----------------------------------
        -----------RESULT TABLE-----------
        ----------------------------------

        SELECT t1.PMID
             , t1.Mnth
             , (t1.Sales + t3.Sales) AS Sales
             , t2.Cost AS Cost
             , (t1.Units + t3.Units) AS Units
             , (t1.Doses + t3.Doses) AS Doses
             , t2.Scripts AS Scripts
             , t2.Dispensed AS Dispensed
             , CASE
                   WHEN((t1.Doses + t3.Doses) / t2.Dispensed) >= 1
                   THEN 1
                   ELSE((t1.Doses + t3.Doses) / t2.Dispensed)
               END AS Compliance
             , CASE
                   WHEN((t1.Sales + t3.Sales) / t2.Cost) >= 1
                   THEN 1
                   ELSE((t1.Sales + t3.Sales) / t2.Cost)
               END AS DollarCompliance
        FROM @TempDose AS t1
             INNER JOIN @TempClaim AS t2 ON t1.PMID = t2.PMID
                                            AND t1.mnth = t2.Mnth
             INNER JOIN @TempDoseCAH AS t3 ON t1.PMID = t3.PMID
                                              AND t1.mnth = t3.Mnth
        ORDER BY t1.PMID
               , t1.Mnth;
    END;
GO
