USE [SSRS]
GO
/****** Object:  StoredProcedure [dbo].[usp_Compliance_Beta]    Script Date: 12/22/2020 8:05:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


/*
Author: Scott Edwards
Create Date: 12/18/2019
Description: Compliance Report Base Version 

Updates
12/30/2019 : Added date paramaters to sproc and in each WHERE cuase.
1/13/2019 : Added Clause to WHERE for FDS to exclude 340B claims from Analysis
2/26/202 : Changed AWP per dose to Invoice per Dose

*/

CREATE PROCEDURE [dbo].[usp_Compliance_Beta] @PMID      INT, 
                                            @StartDate DATETIME, 
                                            @EndDate   DATETIME, 
                                            @BG        INT NULL
AS
     SET NOCOUNT ON;
    BEGIN
        DECLARE @TempAPI TABLE
        (GPI               VARCHAR(20), 
         Description       VARCHAR(250), 
         [Purchase Qty]    DECIMAL(18, 2), 
         [Purchases @ IP] DECIMAL(18, 2)
        );
        DECLARE @TempCAH TABLE
        (GPI               VARCHAR(20), 
         Description       VARCHAR(250), 
         [Purchase Qty]    DECIMAL(18, 2), 
         [Purchases @ IP] DECIMAL(18, 2)
        );
        DECLARE @TempFDS TABLE
        (GPI              VARCHAR(20), 
         Description      VARCHAR(250), 
         [Dispense Qty]   DECIMAL(18, 2), 
         [Dispense @ IP] DECIMAL(18, 2)
        );

        -- API --
        INSERT INTO @TempAPI
        (GPI, 
         Description, 
         [Purchase Qty], 
         [Purchases @ IP]
        )
               SELECT DISTINCT 
                      z.GPI, 
                      z.Description, 
                      SUM(z.[Dispense Qty]) AS [Dispense Qty], 
                      SUM(z.[Dispense @ IP]) AS [Dispense @ IP]
               FROM
               (
                   SELECT DISTINCT 
                          GPI, 
                          Description, 
                          SUM(Doses) AS [Dispense Qty], 
                          CAST(SUM(Doses) * (InvoicePerDose) AS DECIMAL(18, 2)) AS [Dispense @ IP]
                   FROM SalesDDS.[dbo].[APIComplianceReport]
                   WHERE PMID = @PMID
                         AND InvoiceDate >= @StartDate
                         AND InvoiceDate < @EndDate
                         AND IsGeneric = @BG
                   GROUP BY GPI, 
                            Description, 
                            InvoicePerDose
               ) AS z
               GROUP BY z.GPI, 
                        z.Description;
        --CAH--
        INSERT INTO @TempCAH
        (GPI, 
         Description, 
         [Purchase Qty], 
         [Purchases @ IP]
        )
               SELECT DISTINCT 
                      z.GPI, 
                      z.Description, 
                      SUM(z.[Dispense Qty]) AS [Dispense Qty], 
                      SUM(z.[Dispense @ IP]) AS [Dispense @ IP]
               FROM
               (
                   SELECT DISTINCT 
                          GPI, 
                          Description, 
                          SUM(Doses) AS [Dispense Qty], 
                          CAST(SUM(Doses) * (InvoicePerDose) AS DECIMAL(18, 2)) AS [Dispense @ IP]
                   FROM SalesDDS.[dbo].[CAHComplianceReport]
                   WHERE PMID = @PMID
                         AND InvoiceDate >= @StartDate
                         AND InvoiceDate < @EndDate
                         AND IsGeneric = @BG
                   GROUP BY GPI, 
                            Description, 
                            InvoicePerDose
               ) AS z
               GROUP BY z.GPI, 
                        z.Description;
        -- FDS -- 
        INSERT INTO @TempFDS
        (GPI, 
         Description, 
         [Dispense Qty], 
         [Dispense @ IP]
        )
               SELECT DISTINCT 
                      z.GPI, 
                      z.Description, 
                      SUM(z.[Dispense Qty]) AS [Dispense Qty], 
                      SUM(z.[Dispense @ IP]) AS [Dispense @ IP]
               FROM
               (
                   SELECT DISTINCT 
                          GPI, 
                          Description, 
                          SUM(QuantityDispensed) AS [Dispense Qty], 
                          CAST(SUM(QuantityDispensed) * (InvoicePerDose) AS DECIMAL(18, 2)) AS [Dispense @ IP]
                   FROM ClaimsDDS.[dbo].[FDSComplianceReport]
                   WHERE PMID = @PMID
                         AND TransactionDate >= @StartDate
                         AND TransactionDate < @EndDate
                         AND IsGeneric = @BG
						 AND Is340BClaim = 0
                   GROUP BY GPI, 
                            Description, 
                            InvoicePerDose
               ) AS z
               GROUP BY z.GPI, 
                        z.Description;
						
       -- Combined --
        SELECT a.GPI, 
               a.Description, 
               ISNULL(b.[Purchase Qty], 0) + ISNULL(c.[Purchase Qty], 0) AS [Purchase Qty], 
               ISNULL(b.[Purchases @ IP], 0) + ISNULL(c.[Purchases @ IP], 0) AS [Purchases @ IP], 
               a.[Dispense Qty], 
               a.[Dispense @ IP], 
               (ISNULL(b.[Purchase Qty], 0) + ISNULL(c.[Purchase Qty], 0)) - a.[Dispense Qty] AS [Leakage Quantity], 
               (ISNULL(b.[Purchases @ IP], 0) + ISNULL(c.[Purchases @ IP], 0)) - a.[Dispense @ IP] AS [Leakage @ IP]
        FROM @TempFDS AS a
             LEFT JOIN @TempAPI AS b ON a.GPI = b.GPI
             LEFT JOIN @TempCAH AS c ON a.GPI = c.GPI
        WHERE a.GPI IS NOT NULL
        ORDER BY a.GPI ASC;

    END;
GO
