USE [SalesDDS]
GO
/****** Object:  StoredProcedure [dbo].[usp_CAHComplianceReport_Load]    Script Date: 12/22/2020 7:55:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO












CREATE PROCEDURE [dbo].[usp_CAHComplianceReport_Load]

AS

SET NOCOUNT ON;

BEGIN

        --Change of Ownership (COO) within current 90 days
        DECLARE @C TABLE (PMID INT PRIMARY KEY CLUSTERED);

  --      DECLARE @StartDateKey INT
		--	  , @EndDateKey INT;        
		--SELECT @StartDateKey = CAST(CONVERT(VARCHAR(20), DATEADD(day, -365, DATEADD(d, 0, DATEDIFF(d, 0, GETDATE()))), 112) AS INT), 
  --             @EndDateKey = CAST(CONVERT(VARCHAR(20), GETDATE(), 112) AS INT)
  --      FROM SalesDDS.dbo.DateDim;

		DECLARE @StartDateKey INT
			, @EndDateKey INT
			, @DateKeyLoop INT

 		
	DECLARE C1 CURSOR FOR 
	SELECT ca.DateKey
	FROM(SELECT DISTINCT CAST(CONVERT(VARCHAR(20), DATEADD(day, -365, DATEADD(d, 0, DATEDIFF(d, 0, GETDATE()))), 112) AS INT) AS StartDateKey
		, CAST(CONVERT(VARCHAR(20), GETDATE(), 112) AS INT) AS EndDateKey
		FROM SalesDDS.dbo.DateDim
		) AS dt
	CROSS APPLY SalesDDS.dbo.DateDim AS ca
	WHERE ca.DateKey BETWEEN dt.StartDateKey AND dt.EndDateKey
	ORDER BY ca.DateKey ASC

	OPEN C1

	FETCH NEXT
	FROM C1
	INTO @DateKeyLoop

    TRUNCATE TABLE [dbo].[CAHComplianceReport];

	WHILE @@FETCH_STATUS = 0
	BEGIN

        INSERT INTO [dbo].[CAHComplianceReport]
        ( PMID
		, GPI
		, Description
		, AWPPerDose
		, Doses
		, [IsGeneric]
		, NDC
		, InvoiceDate
		--, [InvoicePerDose]
		, CAHUnitAmount
		, InvoicePerDose2
        )
               
			   
		SELECT DISTINCT dt.PMID
		, dt.GPI
		, dt.Description
		, dt.AWPPerDose
		, dt.Doses
		, dt.[IsGeneric]
		, dt.NDC
		, dt.InvoiceDate
		--, (ca.AAPSell/dt.Doses) AS InvoicePerDose
		, dt.CAHUnitAmount
		, (dt.[CAHExtendedSales]/dt.Doses) AS InvoicePerDose2
		FROM(SELECT DISTINCT pd.PMID
			, d.GPI
			, d.Description
			, d.AWPPerDose
			, c.[CAHInvoiceQuantity] * d.PackageSize * d.PackageQuantity AS Doses
			, d.IsGeneric
			--, CASE
   --                 WHEN d.[MultiSourceCode] = 'Y'
   --                 THEN 1
   --                 ELSE 0
   --             END AS IsGeneric
			, e.NDC
			, CONVERT(DATE, e.InvoiceDate) AS InvoiceDate
			, c.[CAHUnitAmount]
			, c.[CAHExtendedSales]
			FROM SalesDDS.dbo.SalesFact_CAH AS c
			INNER JOIN SalesDDS.dbo.DrugDim AS d ON c.DrugKey = d.DrugKey
			INNER JOIN SalesDDS.dbo.EventDimCAH AS e ON c.[CAHEventKey] = e.EventKey
													AND c.CAHEventDateKey = e.DateKey
			INNER JOIN SalesDDS.dbo.PharmacyDim AS pd ON c.PharmacyKey = pd.PharmacyKey
			WHERE c.DateKey = @DateKeyLoop
			AND c.[CAHInvoiceQuantity] > 0
			AND pd.PMID > 0
			AND c.PharmacyKey <> 0
			AND e.ItemType = 'RX'
			) AS dt
		WHERE dt.Doses IS NOT NULL
	

		FETCH NEXT
		FROM C1
		INTO @DateKeyLoop

	END

	CLOSE C1
	DEALLOCATE C1

END











GO
