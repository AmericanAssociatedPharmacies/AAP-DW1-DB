USE [SSRS]
GO
/****** Object:  StoredProcedure [dbo].[usp_Compliance_Beta_RSE]    Script Date: 12/22/2020 8:05:41 AM ******/
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

CREATE PROCEDURE [dbo].[usp_Compliance_Beta_RSE] @PMID      INT, 
                                            @StartDate DATETIME, 
                                            @EndDate   DATETIME 
                                         --   @BG        INT NULL
AS
     SET NOCOUNT ON;
    BEGIN
        DECLARE @TempAPI TABLE
        (GPI               VARCHAR(20) INDEX CPK1 CLUSTERED, 
         Description       VARCHAR(250), 
         [Purchase Qty]    DECIMAL(18, 2), 
         [Purchases @ IP] DECIMAL(18, 2),
		 InvoicePerDose MONEY -- Added by RSE
        );
        DECLARE @TempCAH TABLE
        (GPI               VARCHAR(20) INDEX CPK2 CLUSTERED, 
         Description       VARCHAR(250), 
         [Purchase Qty]    DECIMAL(18, 2), 
         [Purchases @ IP] DECIMAL(18, 2),
		 InvoicePerDose MONEY -- Added by RSE
        );
        DECLARE @TempFDS TABLE
        (GPI              VARCHAR(20) INDEX CPK3 CLUSTERED, 
         Description      VARCHAR(250), 
         [Dispense Qty]   DECIMAL(18, 2), 
         [Dispense @ IP] DECIMAL(18, 2),
		 QuantityDispensed INT -- Added by RSE
        );


	DECLARE @StartDateKey INT
	, @EndDateKey INT

	SET @StartDateKey =  CAST(CONVERT(VARCHAR(20),@StartDate,112) as INT)
	SET @EndDateKey =  CAST(CONVERT(VARCHAR(20),@EndDate,112) as INT)

        -- API --
        INSERT INTO @TempAPI
        (GPI, 
         Description, 
         [Purchase Qty], 
         [Purchases @ IP],
		 InvoicePerDose -- Added by RSE
        )
               SELECT DISTINCT 
                      z.GPI, 
                      z.Description, 
                      SUM(z.[Dispense Qty]) AS [Dispense Qty], 
                      SUM(z.[Dispense @ IP]) AS [Dispense @ IP],
					  AVG(z.InvoicePerDose) AS InvoicePerDose -- Added by RSE
               FROM
               (
                   SELECT DISTINCT 
                          GPI, 
                          Description, 
                          SUM(Doses) AS [Dispense Qty], 
                          CAST(SUM(Doses) * (InvoicePerDose) AS DECIMAL(18, 2)) AS [Dispense @ IP],
						  AVG(InvoicePerDose) AS InvoicePerDose -- Added by RSE
                   FROM SalesDDS.[dbo].[APIComplianceReport]
                   WHERE PMID = @PMID
				   AND InvoiceDate BETWEEN @StartDate AND @EndDate
                   --AND IsGeneric = @BG
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
         [Purchases @ IP],
		 InvoicePerDose -- Added by RSE
        )
               SELECT DISTINCT 
                      z.GPI, 
                      z.Description, 
                      SUM(z.[Dispense Qty]) AS [Dispense Qty], 
                      SUM(z.[Dispense @ IP]) AS [Dispense @ IP],
					  AVG(InvoicePerDose) AS InvoicePerDose  -- Added by RSE
               FROM
               (
                   SELECT DISTINCT 
                          GPI, 
                          Description, 
                          SUM(Doses) AS [Dispense Qty], 
                          CAST(SUM(Doses) * (InvoicePerDose2) AS DECIMAL(18, 2)) AS [Dispense @ IP],
						  AVG(InvoicePerDose2) AS InvoicePerDose -- Added by RSE
                   FROM SalesDDS.[dbo].[CAHComplianceReport]
                   WHERE PMID = @PMID
					AND InvoiceDate BETWEEN @StartDate AND @EndDate
					--AND IsGeneric = @BG
                   GROUP BY GPI, 
                            Description, 
                            --InvoicePerDose,
							InvoicePerDose2
               ) AS z
               GROUP BY z.GPI, 
                        z.Description;
        -- FDS -- 
        INSERT INTO @TempFDS
        (GPI, 
        Description, 
         [Dispense Qty], 
         --[Dispense @ IP]
		 QuantityDispensed-- Added by RSE
        )
               SELECT DISTINCT 
                      z.GPI, 
                      z.Description, 
                      SUM(z.[Dispense Qty]) AS [Dispense Qty], 
                      --SUM(z.[Dispense @ IP]) AS [Dispense @ IP],
					  SUM(QuantityDispensed) AS QuantityDispensed -- Added by RSE
               FROM
               (
                   SELECT DISTINCT 
                          GPI, 
                          Description, 
                          SUM(QuantityDispensed) AS [Dispense Qty], 
                          --CAST(SUM(QuantityDispensed) * (InvoicePerDose) AS DECIMAL(18, 2)) AS [Dispense @ IP],
						  SUM(QuantityDispensed) AS QuantityDispensed -- Added by RSE
                   FROM ClaimsDDS.[dbo].[FDSComplianceReport] --WITH(INDEX(NCI_FDSComplianceReport_PMID_Is340BClaim_DateKey))
                   WHERE PMID = @PMID
				   AND TransactionDate BETWEEN @StartDate AND @EndDate
				   --AND DateKey BETWEEN @StartDateKey AND @EndDateKey
                   -- AND IsGeneric = 1
					 AND Is340BClaim = 0
                   GROUP BY GPI, 
                            Description
                           
               ) AS z
               GROUP BY z.GPI
                     , z.Description
			ORDER BY z.GPI ASC

		-- Added by RSE
		UPDATE x
		SET [Dispense @ IP] = CONVERT(DECIMAL(18,2), (x.QuantityDispensed * ISNULL(a.InvoicePerDose,c.InvoicePerDose)))
		FROM @TempFDS AS x
		LEFT OUTER JOIN @TempAPI AS a ON x.GPI = a.GPI
		LEFT OUTER JOIN @TempCAH AS c ON x.GPI = c.GPI

		UPDATE x
		SET [Dispense @ IP] = CONVERT(DECIMAL(18,2), (x.QuantityDispensed * PricePerUnit))
		FROM @TempFDS AS x		
		INNER JOIN(SELECT ISNULL(a.GPI,cah.GPI)AS GPI, ISNULL(a.APIPricePerUnit,cah.CAHPricePerUnit) AS PricePerUnit
					FROM  @TempFDS AS dt
					LEFT OUTER JOIN(SELECT dd.GPI
										, MIN(a.APIPricePerUnit) AS APIPricePerUnit
										FROM ODSIntake.[dbo].[vwAPIPricing] AS a
										INNER JOIN DrugMaster.dbo.DrugDim AS dd ON a.NDC = dd.NDC
										INNER JOIN DrugMaster.dbo.APICatalog AS ac ON ac.NDC = dd.NDC
										INNER JOIN @TempFDS AS f ON f.GPI = dd.GPI
										WHERE ac.[ProductHandlingStatusCode] = 'Active'
										GROUP BY dd.GPI
									) AS a ON a.GPI = dt.GPI
					LEFT OUTER JOIN(SELECT dd.GPI
									, MIN(CONVERT(DECIMAL(10,4), c.InvoicePrice/(dd.PackageSize*dd.PackageQuantity))) AS CAHPricePerUnit
									FROM CAHODS.dbo.CardinalComplete AS c
									INNER JOIN DrugMaster.dbo.DrugDim AS dd ON c.NDC = dd.NDC
									INNER JOIN @TempFDS ON c.GPI = dd.GPI
									GROUP BY dd.GPI
									) AS cah ON dt.GPI = cah.GPI
					WHERE a.GPI IS NOT NULL
					OR cah.GPI IS NOT NULL													
					) AS pf ON x.GPI = pf.GPI	
		WHERE x.[Dispense @ IP] IS NULL

						
       -- Combined --
        SELECT a.GPI, 
               a.Description, 
               ISNULL(b.[Purchase Qty], 0) + ISNULL(c.[Purchase Qty], 0) AS [Purchase Qty], 
               ISNULL(b.[Purchases @ IP], 0) + ISNULL(c.[Purchases @ IP], 0) AS [Purchases @ IP], 
               a.[Dispense Qty], 
               ISNULL(a.[Dispense @ IP],0.00) AS [Dispense @ IP], 
               (ISNULL(b.[Purchase Qty], 0) + ISNULL(c.[Purchase Qty], 0)) - a.[Dispense Qty] AS [Leakage Quantity], 
               (ISNULL(b.[Purchases @ IP], 0) + ISNULL(c.[Purchases @ IP], 0)) - ISNULL(a.[Dispense @ IP],0) AS [Leakage @ IP]
		FROM @TempFDS AS a
             LEFT JOIN @TempAPI AS b ON a.GPI = b.GPI
             LEFT JOIN @TempCAH AS c ON a.GPI = c.GPI
        WHERE a.GPI IS NOT NULL
	    ORDER BY a.GPI ASC;

    END;













GO
