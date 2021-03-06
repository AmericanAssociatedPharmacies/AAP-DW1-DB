USE [Pricing]
GO
/****** Object:  StoredProcedure [Staging].[usp_Load_NADAC]    Script Date: 12/22/2020 7:32:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [Staging].[usp_Load_NADAC]


AS

SET NOCOUNT ON;

BEGIN

	INSERT INTO Pricing.Staging.NADAC(DateKey, DrugKey, [NADACPricePerUnit], NADACPrice)
	SELECT ca.DateKey
	, ca.DrugKey
	, CONVERT(MONEY, ca.NADACPerUnit) AS NADACPricePerUnit
	, CONVERT(MONEY, ca.NADACPrice) AS NADACPrice
	FROM(SELECT DISTINCT CONVERT(DATE, [AsofDate]) AS StartDate
		, DATEADD(dd, 7, CONVERT(DATE, [AsofDate])) AS EndDate
		, CASE		
			WHEN ISNUMERIC([NADACPerUnit]) = 1 THEN CONVERT(DECIMAL(10, 5),[NADACPerUnit])
			ELSE NULL
			END AS NADAC_Per_Unit
		, NDC
		FROM ODSIntake.Staging.[NADAC]
		WHERE 
		CONVERT(DATE, [AsofDate]) >= '20170801'
		) AS dt
	CROSS APPLY(SELECT DISTINCT da.DateKey
					, dd.DrugKey
					, dt.NADAC_Per_Unit AS NADACPerUnit
					, (dt.NADAC_Per_Unit * PackageSize) AS NADACPrice
					, dd.NDC
					FROM Pricing.dbo.DateDim AS da
					CROSS JOIN Pricing.dbo.DrugDim AS dd
					WHERE dt.NDC = dd.NDC
					AND da.TheDate >= dt.StartDate
					AND da.TheDate < dt.EndDate
					) AS ca
	WHERE dt.NDC = ca.NDC

END
GO
