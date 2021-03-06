USE [SalesDDS]
GO
/****** Object:  StoredProcedure [dbo].[usp_CAHComplianceReport_Load_20200115]    Script Date: 12/22/2020 7:55:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_CAHComplianceReport_Load_20200115]
AS
     SET NOCOUNT ON;
    BEGIN

        --Change of Ownership (COO) within current 90 days
        DECLARE @C TABLE
        (PMID INT
         PRIMARY KEY CLUSTERED
        );
        DECLARE @StartDateKey INT, @EndDateKey INT;
        SELECT @StartDateKey = CAST(CONVERT(VARCHAR(20), DATEADD(day, -365, DATEADD(d, 0, DATEDIFF(d, 0, GETDATE()))), 112) AS INT), 
               @EndDateKey = CAST(CONVERT(VARCHAR(20), GETDATE(), 112) AS INT)
        FROM SalesDDS.dbo.DateDim;
        TRUNCATE TABLE [dbo].[CAHComplianceReport];
        INSERT INTO [dbo].[CAHComplianceReport]
        (PMID, 
         GPI, 
         Description, 
         AWPPerDose, 
         Doses, 
         [IsGeneric], 
         NDC, 
         InvoiceDate
        )
               SELECT DISTINCT 
                      pd.PMID, 
                      d.GPI, 
                      d.Description, 
                      d.AWPPerDose, 
                      c.[CAHInvoiceQuantity] * d.PackageSize * d.PackageQuantity AS Doses,
                      CASE
                          WHEN d.[MultiSourceCode] = 'Y'
                          THEN 1
                          ELSE 0
                      END AS IsGeneric, 
                      e.NDC, 
                      CONVERT(DATE, e.InvoiceDate) AS InvoiceDate
               FROM SalesDDS.dbo.SalesFact_CAH AS c
                    INNER JOIN SalesDDS.dbo.DrugDim AS d ON c.DrugKey = d.DrugKey
                    INNER JOIN SalesDDS.dbo.EventDimCAH AS e ON c.[CAHEventKey] = e.EventKey
                                                                AND c.CAHEventDateKey = e.DateKey
                    INNER JOIN SalesDDS.dbo.PharmacyDim AS pd ON c.PharmacyKey = pd.PharmacyKey
               WHERE c.DateKey BETWEEN @StartDateKey AND @EndDateKey
    END;
GO
