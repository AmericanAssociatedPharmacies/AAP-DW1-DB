USE [SalesDDS]
GO
/****** Object:  StoredProcedure [dbo].[usp_APIComplianceReport_Load_20200115]    Script Date: 12/22/2020 7:55:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_APIComplianceReport_Load_20200115]
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
        TRUNCATE TABLE SalesDDS.[dbo].[APIComplianceReport];
        INSERT INTO SalesDDS.[dbo].[APIComplianceReport]
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
                      dd.GPI, 
                      dd.Description, 
                      dd.AWPPerDose, 
                      a.[APIInvoiceQuantity] * dd.PackageSize * dd.PackageQuantity AS Doses,
                      CASE
                          WHEN dd.[MultiSourceCode] = 'Y'
                          THEN 1
                          ELSE 0
                      END AS IsGeneric, 
                      e.NDC, 
                      CONVERT(DATE, e.InvoiceDate) AS InvoiceDate
               FROM SalesDDS.dbo.SalesFact_API AS a
                    INNER JOIN SalesDDS.dbo.EventDimAPI AS e ON a.[APIEventKey] = e.EventKey
                                                                AND a.[APIEventDateKey] = e.DateKey
                    INNER JOIN SalesDDS.dbo.PharmacyDim AS pd ON a.PharmacyKey = pd.PharmacyKey
                    INNER JOIN SalesDDS.dbo.DrugDim AS dd ON a.DrugKey = dd.DrugKey
               WHERE a.DateKey BETWEEN @StartDateKey AND @EndDateKey
                     AND e.Type IN('Generic', 'Brand')
                    AND [ItemDescription] NOT LIKE '%CREDIT%';
    END;
GO
