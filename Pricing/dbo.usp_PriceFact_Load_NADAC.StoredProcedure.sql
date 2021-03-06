USE [Pricing]
GO
/****** Object:  StoredProcedure [dbo].[usp_PriceFact_Load_NADAC]    Script Date: 12/22/2020 7:32:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[usp_PriceFact_Load_NADAC]

AS

SET NOCOUNT ON;

BEGIN

	DECLARE @p1 INT
	, @p2 INT

	SET @p1 = CAST(CONVERT(VARCHAR(20),CONVERT(DATE,DATEADD(yy, DATEDIFF(yy, 0, GETDATE()) -1, 0),112),112) as INT)  -- 1st Day of Last Year
	SET @p2 = CAST(CONVERT(VARCHAR(20),GETDATE(),112) as INT)

	UPDATE [dbo].[PriceFact]
		SET [NADACPrice] =  s.[NADACPrice]
		, [NADACPricePerUnit] = s.[NADACPricePerUnit]
		FROM [dbo].[PriceFact] AS x
		INNER JOIN(SELECT DateKey
					, DrugKey
					FROM [dbo].[PriceFact]
					WHERE NADACPrice IS NULL
					AND NADACPricePerUnit IS NULL
					AND DateKey BETWEEN @p1 AND @p2				
					) AS dt ON x.DateKey = dt.DateKey
								AND x.DrugKey = dt.DrugKey
		INNER JOIN [Staging].[NADAC] AS s ON x.DateKey BETWEEN s.PriceStartDateKey AND s.PriceEndDateKey
											AND x.DrugKey = s.DrugKey

	--UPDATE [dbo].[PriceFact]
	--SET [NADACPrice] =  s.[NADACPrice]
	--, [NADACPricePerUnit] = s.[NADACPricePerUnit]
	--FROM [dbo].[PriceFact] AS x
	--INNER JOIN [Staging].[NADAC] AS s ON x.DateKey = s.DateKey
	--									AND x.DrugKey = s.DrugKey
	--WHERE x.NADACPrice IS NULL
	--AND x.NADACPricePerUnit IS NULL

END

GO
