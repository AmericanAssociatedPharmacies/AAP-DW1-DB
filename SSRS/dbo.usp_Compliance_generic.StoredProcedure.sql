USE [SSRS]
GO
/****** Object:  StoredProcedure [dbo].[usp_Compliance_generic]    Script Date: 12/22/2020 8:05:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
Author: Scott Edwards
Create Date: 12/18/2019
Description: Compliance Report Base Version 
*/

CREATE PROCEDURE [dbo].[usp_Compliance_generic] @PMID INT
AS
     SET NOCOUNT ON;
    BEGIN
        DECLARE @TempAPI TABLE
        (GPI               VARCHAR(20), 
         Description       VARCHAR(250), 
         [Purchase Qty]    DECIMAL(18, 2), 
         [Purchases @ AWP] DECIMAL(18, 2)
        );
        DECLARE @TempCAH TABLE
        (GPI               VARCHAR(20), 
         Description       VARCHAR(250), 
         [Purchase Qty]    DECIMAL(18, 2), 
         [Purchases @ AWP] DECIMAL(18, 2)
        );
        DECLARE @TempFDS TABLE
        (GPI              VARCHAR(20), 
         Description      VARCHAR(250), 
         [Dispense Qty]   DECIMAL(18, 2), 
         [Dispense @ AWP] DECIMAL(18, 2)
        );

        -- API --
        INSERT INTO @TempAPI
        (GPI, 
         Description, 
         [Purchase Qty], 
         [Purchases @ AWP]
        )
               SELECT DISTINCT 
                      z.GPI, 
                      z.Description, 
                      SUM(z.[Dispense Qty]) AS [Dispense Qty], 
                      SUM(z.[Dispense @ AWP]) AS [Dispense @ AWP]
               FROM
               (
                   SELECT DISTINCT 
                          GPI, 
                          Description, 
                          SUM(Doses) AS [Dispense Qty], 
                          CAST(SUM(Doses) * (AWPPerDose) AS DECIMAL(18, 2)) AS [Dispense @ AWP]
                   FROM SalesDDS.[dbo].[APIComplianceReport]
                   WHERE PMID = @PMID
				   AND IsGeneric	= 1 
                   GROUP BY GPI, 
                            Description, 
                            AWPPerDose
               ) AS z
               GROUP BY z.GPI, 
                        z.Description;
        --CAH--
        INSERT INTO @TempCAH
        (GPI, 
         Description, 
         [Purchase Qty], 
         [Purchases @ AWP]
        )
               SELECT DISTINCT 
                      z.GPI, 
                      z.Description, 
                      SUM(z.[Dispense Qty]) AS [Dispense Qty], 
                      SUM(z.[Dispense @ AWP]) AS [Dispense @ AWP]
               FROM
               (
                   SELECT DISTINCT 
                          GPI, 
                          Description, 
                          SUM(Doses) AS [Dispense Qty], 
                          CAST(SUM(Doses) * (AWPPerDose) AS DECIMAL(18, 2)) AS [Dispense @ AWP]
                   FROM SalesDDS.[dbo].[CAHComplianceReport]
                   WHERE PMID = @PMID
				    AND IsGeneric	= 1 
                   GROUP BY GPI, 
                            Description, 
                            AWPPerDose
               ) AS z
               GROUP BY z.GPI, 
                        z.Description;
        -- FDS -- 
        INSERT INTO @TempFDS
        (GPI, 
         Description, 
         [Dispense Qty], 
         [Dispense @ AWP]
        )
               SELECT DISTINCT 
                      z.GPI, 
                      z.Description, 
                      SUM(z.[Dispense Qty]) AS [Dispense Qty], 
                      SUM(z.[Dispense @ AWP]) AS [Dispense @ AWP]
               FROM
               (
                   SELECT DISTINCT 
                          GPI, 
                          Description, 
                          SUM(QuantityDispensed) AS [Dispense Qty], 
                          CAST(SUM(QuantityDispensed) * (AWPPerDose) AS DECIMAL(18, 2)) AS [Dispense @ AWP]
                   FROM ClaimsDDS.[dbo].[FDSComplianceReport]
                   WHERE PMID = @PMID
				    AND IsGeneric	= 1 
                   GROUP BY GPI, 
                            Description, 
                            AWPPerDose
               ) AS z
               GROUP BY z.GPI, 
                        z.Description;
        --Combined --
        SELECT a.GPI, 
               a.Description, 
               ISNULL(b.[Purchase Qty], 0) + ISNULL(c.[Purchase Qty], 0) AS [Purchase Qty], 
               ISNULL(b.[Purchases @ AWP], 0) + ISNULL(c.[Purchases @ AWP], 0) AS [Purchases @ AWP], 
               a.[Dispense Qty], 
               a.[Dispense @ AWP], 
               (ISNULL(b.[Purchase Qty], 0) + ISNULL(c.[Purchase Qty], 0)) - a.[Dispense Qty] AS [Leakage Quantity], 
               (ISNULL(b.[Purchases @ AWP], 0) + ISNULL(c.[Purchases @ AWP], 0)) - a.[Dispense @ AWP] AS [Leakage @ AWP]
        FROM @TempFDS AS a
             LEFT JOIN @TempAPI AS b ON a.GPI = b.GPI
             LEFT JOIN @TempCAH AS c ON a.GPI = c.GPI
        WHERE a.GPI IS NOT NULL
        ORDER BY a.GPI ASC;
    END;
GO
