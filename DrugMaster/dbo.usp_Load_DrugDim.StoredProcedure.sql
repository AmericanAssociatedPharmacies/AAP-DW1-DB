USE [DrugMaster]
GO
/****** Object:  StoredProcedure [dbo].[usp_Load_DrugDim]    Script Date: 12/22/2020 6:57:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[usp_Load_DrugDim]

AS

SET NOCOUNT ON;

BEGIN

	
	--INSERT any new rows
	INSERT INTO DrugMaster.[dbo].[DrugDim](NDC, GPI, GPPC, DrugName, Description, Manufacturer, DrugType, UnitofMeasure, Form, PackageSize, IsRX, IsOTC, Strength, StrengthUnitMeasure
		  , ControlledDrugClass, WACPackagePrice, WACPerDose, AWPPackagePrice, AWPPerDose, IsUnitDose, DrugTypeLongDescription, DrugTypeShortDescription, [IsGenericNonOTC],[IsBrandNonOTC]
		  , MultiSourceCode, MultiSourceCodeDescription, IsMultiSourceBrandNoGenerics, IsSingleSourceBrandNoGenerics, IsOriginalBrandWithGenerics, IsGeneric, StartDateKey, EndDateKey
		  , PackageQuantity, GPIKey
		  )
	SELECT NDC, d.GPI, GPPC, DrugName, Description, Manufacturer, DrugType, UnitofMeasure, Form, PackageSize, IsRX, IsOTC, Strength, StrengthUnitMeasure
		  , ControlledDrugClass, WACPackagePrice, WACPerDose, AWPPackagePrice, AWPPerDose, IsUnitDose, [DrugTypeLongDescription], [DrugTypeShortDescription], [IsGenericNonOTC],[IsBrandNonOTC]
		  , MultiSourceCode, MultiSourceCodeDescription, IsMultiSourceBrandNoGenerics, IsSingleSourceBrandNoGenerics, IsOriginalBrandWithGenerics, IsGeneric, 19000101 AS StartDateKey, 29991231 AS EndDateKey
		  , PackageQuantity, ISNULL(dt.GPIKey,0) AS GPIKey
	FROM Medispan.[dbo].[vwDrugDim] AS d
	LEFT OUTER JOIN(SELECT DISTINCT GPI, GPIKey 
						FROM [dbo].[DrugDim]
						WHERE GPIKey > 0
						) AS dt ON d.GPI = dt.GPI
	WHERE NOT EXISTS(SELECT 1
						FROM DrugMaster.dbo.DrugDim AS dd
						WHERE d.NDC = dd.NDC
						AND d.GPPC = dd.GPPC
						)
	ORDER BY d.NDC ASC, d.GPPC ASC

	
	--Correct EndDateKey values where a new row has been inserted and more than NDC row exist already
	SELECT CONVERT(INT, ROW_NUMBER() OVER(PARTITION BY a.NDC ORDER BY a.[NDC] ASC, a.DrugKey ASC)) AS SeqNo
	, a.DrugKey, a.NDC, ISNULL(a.StartDateKey, 19000101) AS StartDateKey, a.EndDateKey, a.RowCreatedDate
	, CAST(CONVERT(varchar(20),DATEADD(DAY,-1,LEAD(RowCreatedDate,1) OVER(PARTITION BY a.NDC ORDER BY a.NDC ASC, a.DrugKey ASC)),112) as INT) AS NewEndDateKey
	INTO #foo
	FROM dbo.DrugDim AS a
	INNER JOIN (SELECT NDC   
				, COUNT(*) AS C1
				FROM dbo.DrugDim
				GROUP BY NDC
			) AS dt ON a.NDC = dt.NDC
	WHERE dt.C1 > 1

	UPDATE x
	SET EndDateKey = ISNULL(f.NewEndDateKey, 29991231)
	FROM dbo.DrugDim AS x
	INNER JOIN #foo AS f ON x.DrugKey = f.DrugKey


	--Update for IsGenericCAH column

	--Generics
	UPDATE x
	SET IsCAHGeneric =  1
	FROM [dbo].[DrugDim] AS x
	INNER JOIN CAHODS.[dbo].[CAH_NDC] AS c ON x.NDC = c.NDC
	WHERE c.Brand = 'N'

	--Brands
	UPDATE x
	SET IsCAHGeneric =  0
	FROM [dbo].[DrugDim] AS x
	INNER JOIN CAHODS.[dbo].[CAH_NDC] AS c ON x.NDC = c.NDC
	WHERE c.Brand = 'B'

	--Set new GPIKey for new GPI's
	SELECT ROW_NUMBER() OVER(ORDER BY GPI ASC) + cj.MaxGPIKey AS GPIKey              
    , GPI
    INTO #GPIKey
    FROM(SELECT DISTINCT GPI
            FROM dbo.DrugDim 
            WHERE DrugKey > 0
			AND GPIKey = 0            
            ) AS dt
	CROSS JOIN(SELECT MAX(GPIKey) AS MaxGPIKey
				 FROM dbo.DrugDim 
			   ) AS cj

	UPDATE d
	SET GPIKey = f.GPIKey
	FROM dbo.DrugDim AS d
	INNER JOIN #GPIKey AS f ON d.GPI = f.GPI
				
	
END


/******************************************************************************************************************************************************************

							Old SQL Code

--Correct EndDateKey values where a new row has been inserted and more than NDC row exist already
	SELECT CONVERT(INT, ROW_NUMBER() OVER(PARTITION BY a.NDC ORDER BY a.[NDC] ASC, a.StartDateKey ASC)) AS SeqNo
	, a.DrugKey, a.NDC, ISNULL(a.StartDateKey, 19000101) AS StartDateKey, a.EndDateKey
	INTO #foo
	FROM dbo.DrugDim AS a
	INNER JOIN (SELECT NDC   
				, COUNT(*) AS C1
				FROM dbo.DrugDim
				GROUP BY NDC
			) AS dt ON a.NDC = dt.NDC
	WHERE dt.C1 > 1

	--Declare table varaible
	DECLARE @T TABLE(SeqNo INT
						, DrugKey INT NOT NULL PRIMARY KEY CLUSTERED
						, NDC VARCHAR(15) NOT NULL
						, StartDateKey INT NOT NULL
						, EndDateKey INT NOT NULL
						)
 
	; WITH cte
	AS (SELECT a.SeqNo, a.DrugKey, a.NDC, a.StartDateKey, a.EndDateKey	
		FROM(SELECT NDC
					, MIN(SeqNo) AS SeqNo
					FROM #foo
					GROUP BY NDC
					) AS dt
		INNER JOIN #foo AS a ON dt.SeqNo = a.SeqNo
								AND dt.NDC = a.NDC
 
		UNION ALL
 
		SELECT b.SeqNo, b.DrugKey, b.NDC, b.StartDateKey, a.StartDateKey AS EndDateKey
		FROM cte AS a
		INNER JOIN #foo AS b ON a.NDC = b.NDC
							AND b.SeqNo = a.SeqNo + 1
 
				)
	INSERT INTO @T
	SELECT *
	FROM cte

	--Set the EndDateKey to -1 Day to the StartDateKey value of the next row
	UPDATE x
	SET EndDateKey = CAST(CONVERT(varchar(20),DATEADD(DAY, -1 ,CONVERT(datetime, convert(varchar(10), dt.EndDateKey))),112) as INT)
	FROM dbo.DrugDim AS x
	INNER JOIN(SELECT DrugKey, EndDateKey
				FROM @T
				WHERE SeqNo > 1
				) AS dt ON x.DrugKey = dt.DrugKey

********************************************************************************************************************************************************************/















GO
