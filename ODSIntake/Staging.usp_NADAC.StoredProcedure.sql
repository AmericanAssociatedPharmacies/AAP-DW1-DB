USE [ODSIntake]
GO
/****** Object:  StoredProcedure [Staging].[usp_NADAC]    Script Date: 12/22/2020 7:30:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [Staging].[usp_NADAC]

AS

SET NOCOUNT ON

BEGIN

	DECLARE @p1 DATE
	, @p2 DATE

	SET @p1 = CONVERT(DATE,DATEADD(yy, DATEDIFF(yy, 0, GETDATE()) -1, 0),112)  -- 1st Day of Last Year
	SET @p2 = CONVERT(DATE, GETDATE())

	SELECT dt.NADACStartDate 
	, dt.NDC
	, dt.NADAC_Per_Unit AS NADACPricePerUnit
	, CONVERT(MONEY,(dt.NADAC_Per_Unit * dd.PackageSize * dd.PackageQuantity)) AS NADACPrice
	, dt.PriceStartDateKey
	, dt.PriceEndDateKey
	, dd.DrugKey
	FROM(SELECT DISTINCT CONVERT(DATE, [AsofDate]) AS NADACStartDate
		, CONVERT(DATE, DATEADD(wk, DATEDIFF(wk,0,CONVERT(DATE, [AsofDate])), 8)) AS PriceEndDate
		, CAST(CONVERT(VARCHAR(20),DATEADD(wk, DATEDIFF(wk,0,CONVERT(DATE, [AsofDate])), 2),112) as INT) AS PriceStartDateKey
		, CAST(CONVERT(VARCHAR(20),CONVERT(DATE, DATEADD(wk, DATEDIFF(wk,0,CONVERT(DATE, [AsofDate])), 8)),112) as INT) AS PriceEndDateKey
		, CONVERT(DECIMAL(10,5), REPLACE(NADACPerUnit, ';', '')) AS NADAC_Per_Unit
		, CONVERT(VARCHAR(13),NDC) AS NDC
		FROM ODSIntake.[Staging].[NADAC]
		WHERE CONVERT(DATE, [AsofDate]) BETWEEN @p1 AND @p2
		) AS dt
	INNER JOIN DrugMaster.dbo.DrugDim AS dd ON dd.NDC = dt.NDC
	WHERE dt.PriceStartDateKey BETWEEN dd.StartDateKey AND dd.EndDateKey 

END



/*

SELECT DISTINCT ca.DateKey
	, ca.DrugKey
	, ca.NADAC_Per_Unit
	, ca.NADACPrice
	FROM(SELECT DISTINCT CONVERT(DATE, [AsofDate]) AS StartDate
		, DATEADD(dd, 7, CONVERT(DATE, [AsofDate])) AS EndDate
		, CONVERT(DECIMAL(10,5), REPLACE(NADACPerUnit, ';', '')) AS NADAC_Per_Unit
		, NDC
		FROM [Staging].[NADAC]
		CROSS JOIN(SELECT CONVERT(DATE, convert(varchar(10), MAX(DateKey))) AS TheDate
					FROM Pricing.[dbo].[PriceFact] 		
					) AS cj
		WHERE CONVERT(DATE, [AsofDate]) > cj.TheDate
		) AS dt
	CROSS APPLY(SELECT DISTINCT da.DateKey
					, dd.DrugKey
					, dt.NADAC_Per_Unit
					, CONVERT(MONEY,(dt.NADAC_Per_Unit * PackageSize * dm.CSP)) AS NADACPrice
					FROM Pricing.dbo.DateDim AS da
					INNER JOIN Medispan.dbo.DrugMaster AS dm ON dt.NDC = dm.NDC
					CROSS JOIN Pricing.dbo.DrugDim AS dd
					WHERE dt.NDC = dd.NDC
					AND da.TheDate >= dt.StartDate
					AND da.TheDate < dt.EndDate
					) AS ca

*/








GO
