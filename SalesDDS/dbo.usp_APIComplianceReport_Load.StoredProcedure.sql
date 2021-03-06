USE [SalesDDS]
GO
/****** Object:  StoredProcedure [dbo].[usp_APIComplianceReport_Load]    Script Date: 12/22/2020 7:55:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[usp_APIComplianceReport_Load]

AS

SET NOCOUNT ON;

BEGIN

    --Change of Ownership (COO) within current 90 days
    DECLARE @C TABLE (PMID INT PRIMARY KEY CLUSTERED);

    DECLARE @StartDateKey INT
			, @EndDateKey INT
			, @DateKeyLoop INT

    --SELECT @StartDateKey = CAST(CONVERT(VARCHAR(20), DATEADD(day, -365, DATEADD(d, 0, DATEDIFF(d, 0, GETDATE()))), 112) AS INT), 
    --       @EndDateKey = CAST(CONVERT(VARCHAR(20), GETDATE(), 112) AS INT)
    --FROM SalesDDS.dbo.DateDim;

		
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

    TRUNCATE TABLE SalesDDS.[dbo].[APIComplianceReport];

	WHILE @@FETCH_STATUS = 0
	BEGIN

		INSERT INTO SalesDDS.[dbo].[APIComplianceReport]
		(PMID
		, GPI
		, Description
		, AWPPerDose
		, Doses
		, [IsGeneric]
		, NDC
		, InvoiceDate
		, [InvoicePerDose]
		, [APIUnitAmount]
		)
		
		SELECT dt.PMID
		, dt.GPI
		, dt.Description
		, dt.AWPPerDose
		, dt.Doses
		, dt.[IsGeneric]
		, dt.NDC
		, dt.InvoiceDate
		--, (dt.APICustomerInvoicePrice/dt.Doses) AS [InvoicePerDose]
		, (dt.APIExtendedAmount/dt.Doses) AS [InvoicePerDose]
		, dt.[APIUnitAmount]
		FROM(SELECT DISTINCT pd.PMID
			, dd.GPI
			, dd.Description
			, dd.AWPPerDose
			, a.[APIInvoiceQuantity] * dd.PackageSize * dd.PackageQuantity AS Doses
			, dd.IsGeneric
			--, CASE
			--		WHEN dd.[MultiSourceCode] = 'Y'
			--		THEN 1
			--		ELSE 0
			--	END AS IsGeneric
			, e.NDC
			, CONVERT(DATE, e.InvoiceDate) AS InvoiceDate
			, (a.[APIExtendedAmount]/a.APIInvoiceQuantity) AS APICustomerInvoicePrice
			, a.[APIUnitAmount]
			, a.APIExtendedAmount
			FROM SalesDDS.dbo.SalesFact_API AS a
			INNER JOIN SalesDDS.dbo.EventDimAPI AS e ON a.[APIEventKey] = e.EventKey
													AND a.[APIEventDateKey] = e.DateKey
			INNER JOIN SalesDDS.dbo.PharmacyDim AS pd ON a.PharmacyKey = pd.PharmacyKey
			INNER JOIN SalesDDS.dbo.DrugDim AS dd ON a.DrugKey = dd.DrugKey
			WHERE a.DateKey = @DateKeyLoop
			--AND e.Type IN('Generic', 'Brand')
			--AND e.Type = 'Generic'
			AND [ItemDescription] NOT LIKE '%CREDIT%'
			AND a.[APIInvoiceQuantity] > 0
			AND pd.PMID > 0
			AND a.PharmacyKey <> 0
			AND a.APIInvoiceQuantity IS NOT NULL --added the following 3 filters
			AND dd.PackageSize IS NOT NULL
			AND dd.PackageQuantity IS NOT NULL 
			) AS dt
		--INNER JOIN ODSIntake.Staging.vwAPIPricing AS s ON dt.NDC = dt.NDC
		WHERE dt.Doses IS NOT NULL

		FETCH NEXT
		FROM C1
		INTO @DateKeyLoop

	END

	CLOSE C1 
	DEALLOCATE C1

END












GO
