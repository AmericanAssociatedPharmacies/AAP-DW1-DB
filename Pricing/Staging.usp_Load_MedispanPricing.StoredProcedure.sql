USE [Pricing]
GO
/****** Object:  StoredProcedure [Staging].[usp_Load_MedispanPricing]    Script Date: 12/22/2020 7:32:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [Staging].[usp_Load_MedispanPricing]


AS


SET NOCOUNT ON;

BEGIN

	--Empty table
	TRUNCATE TABLE [Staging].[MedispanPricing]

	--Load table
	INSERT INTO [Staging].[MedispanPricing]	(NDC, DateKey, DrugKey)
	SELECT DISTINCT A.NDC_UPC_HRI
	, CONVERT(INT, A.Last_Change_Date) AS DateKey
	, dd.DrugKey
	FROM [Medispan_Staging].[dbo].[MF2PRC_M] AS A
	INNER JOIN Pricing.dbo.DrugDim AS dd ON LTRIM(RTRIM(A.NDC_UPC_HRI)) = dd.NDC
	
	--Load AWP data 
	MERGE [Staging].[MedispanPricing] AS t
	USING(SELECT ca.DateKey
					, ca.DrugKey
					, NULLIF(ca.AWP, 0.00) AS AWP
					, ca.NDC
					FROM(SELECT [NDC_UPC_HRI] AS NDC
							, CONVERT(DATETIME, CONVERT(VARCHAR(8), Last_Change_Date), 120) AS StartDate
							, DATEADD(DAY, 7, CONVERT(DATETIME, CONVERT(VARCHAR(8), Last_Change_Date), 120)) AS EndDate
							, CONVERT(MONEY, Package_Price) AS AWP
							FROM [Medispan_Staging].[dbo].[MF2PRC_M]
							WHERE Price_Code = 'A'		
						) AS dt
					CROSS APPLY(SELECT DISTINCT da.DateKey
									, dd.DrugKey
									, dt.AWP
									, dd.NDC
									FROM Pricing.dbo.DateDim AS da
									CROSS JOIN Pricing.dbo.DrugDim AS dd
									WHERE dt.NDC = dd.NDC
									AND da.TheDate >= dt.StartDate
									AND da.TheDate < dt.EndDate
									) AS ca
					WHERE dt.NDC = ca.NDC
			 ) AS s(DateKey, DrugKey, AWP, NDC)
			  ON t.[DrugKey] = s.DrugKey AND t.DateKey = s.DateKey

		WHEN MATCHED THEN
		UPDATE 
			SET DrugKey = s.DrugKey
			, AWP = s.AWP

		WHEN NOT MATCHED THEN
		INSERT(DrugKey
				, DateKey
				, AWP	
				)
		VALUES(s.DrugKey
				, s.DateKey
				, s.AWP	
				);

	--Load DirectPricing data 
	MERGE [Staging].[MedispanPricing] AS t
	USING(SELECT ca.DateKey
					, ca.DrugKey
					, NULLIF(ca.DirectPrice, 0.00) AS DirectPrice
					, ca.NDC
					FROM(SELECT [NDC_UPC_HRI] AS NDC
							, CONVERT(DATETIME, CONVERT(VARCHAR(8), Last_Change_Date), 120) AS StartDate
							, DATEADD(DAY, 7, CONVERT(DATETIME, CONVERT(VARCHAR(8), Last_Change_Date), 120)) AS EndDate
							, CONVERT(MONEY, Package_Price) AS [DirectPrice]
							FROM [Medispan_Staging].[dbo].[MF2PRC_M]
							WHERE Price_Code = 'D'		
						) AS dt
					CROSS APPLY(SELECT DISTINCT da.DateKey
									, dd.DrugKey
									, dt.DirectPrice
									, dd.NDC
									FROM Pricing.dbo.DateDim AS da
									CROSS JOIN Pricing.dbo.DrugDim AS dd
									WHERE dt.NDC = dd.NDC
									AND da.TheDate >= dt.StartDate
									AND da.TheDate < dt.EndDate
									) AS ca
					WHERE dt.NDC = ca.NDC
			 ) AS s(DateKey, DrugKey, DirectPrice, NDC)
			  ON t.[DrugKey] = s.DrugKey AND t.DateKey = s.DateKey

		WHEN MATCHED THEN
		UPDATE 
			SET DrugKey = s.DrugKey
			, DirectPrice = s.DirectPrice

		WHEN NOT MATCHED THEN
		INSERT(DrugKey
				, DateKey
				, DirectPrice	
				)

		VALUES(s.DrugKey
				, s.DateKey
				, s.DirectPrice
				);

	--Load CMSFUL data 
	MERGE [Staging].[MedispanPricing] AS t
	USING(SELECT ca.DateKey
					, ca.DrugKey
					, NULLIF(ca.CMSFUL, 0.00) AS CMSFUL
					, ca.NDC
					FROM(SELECT [NDC_UPC_HRI] AS NDC
							, CONVERT(DATETIME, CONVERT(VARCHAR(8), Last_Change_Date), 120) AS StartDate
							, DATEADD(DAY, 7, CONVERT(DATETIME, CONVERT(VARCHAR(8), Last_Change_Date), 120)) AS EndDate
							, CONVERT(MONEY, Package_Price) AS CMSFUL
							FROM [Medispan_Staging].[dbo].[MF2PRC_M]
							WHERE Price_Code = 'H'		
						) AS dt
					CROSS APPLY(SELECT DISTINCT da.DateKey
									, dd.DrugKey
									, dt.CMSFUL
									, dd.NDC
									FROM Pricing.dbo.DateDim AS da
									CROSS JOIN Pricing.dbo.DrugDim AS dd
									WHERE dt.NDC = dd.NDC
									AND da.TheDate >= dt.StartDate
									AND da.TheDate < dt.EndDate
									) AS ca
					WHERE dt.NDC = ca.NDC
			 ) AS s(DateKey, DrugKey, CMSFUL, NDC)
			  ON t.[DrugKey] = s.DrugKey AND t.DateKey = s.DateKey

		WHEN MATCHED THEN
		UPDATE 
			SET DrugKey = s.DrugKey
			, CMSFUL = s.CMSFUL

		WHEN NOT MATCHED THEN
		INSERT(DrugKey
				, DateKey
				, CMSFUL	
				)
		VALUES(s.DrugKey
				, s.DateKey
				, s.CMSFUL
				);
				
	--Load WAC data 
	MERGE [Staging].[MedispanPricing] AS t
	USING(SELECT ca.DateKey
					, ca.DrugKey
					, NULLIF(ca.WAC, 0.00) AS WAC
					, ca.NDC
					FROM(SELECT [NDC_UPC_HRI] AS NDC
							, CONVERT(DATETIME, CONVERT(VARCHAR(8), Last_Change_Date), 120) AS StartDate
							, DATEADD(DAY, 7, CONVERT(DATETIME, CONVERT(VARCHAR(8), Last_Change_Date), 120)) AS EndDate
							, CONVERT(MONEY, Package_Price) AS WAC
							FROM [Medispan_Staging].[dbo].[MF2PRC_M]
							WHERE Price_Code = 'W'		
						) AS dt
					CROSS APPLY(SELECT DISTINCT da.DateKey
									, dd.DrugKey
									, dt.WAC
									, dd.NDC
									FROM Pricing.dbo.DateDim AS da
									CROSS JOIN Pricing.dbo.DrugDim AS dd
									WHERE dt.NDC = dd.NDC
									AND da.TheDate >= dt.StartDate
									AND da.TheDate < dt.EndDate
									) AS ca
					WHERE dt.NDC = ca.NDC
			 ) AS s(DateKey, DrugKey, WAC, NDC)
			  ON t.[DrugKey] = s.DrugKey AND t.DateKey = s.DateKey

		WHEN MATCHED THEN
		UPDATE 
			SET DrugKey = s.DrugKey
			, WAC = s.WAC

		WHEN NOT MATCHED THEN
		INSERT(DrugKey
				, DateKey
				, WAC	
				)
		VALUES(s.DrugKey
				, s.DateKey
				, s.WAC
				);

	--Load AAWP data 
	MERGE [Staging].[MedispanPricing] AS t
	USING(SELECT ca.DateKey
			, ca.DrugKey
			, NULLIF(ca.AAWP, 0.00) AS WAC
			, ca.NDC
			FROM(SELECT B.NDC_UPC_HRI AS NDC
				, CONVERT(DATETIME, CONVERT(VARCHAR(8), A.Last_Change_Date), 120) AS StartDate
				, DATEADD(DAY, 7, CONVERT(DATETIME, CONVERT(VARCHAR(8), A.Last_Change_Date), 120)) AS EndDate
				, CONVERT(MONEY, A.Unit_Price) AS AAWP
				FROM [Medispan_Staging].dbo.MF2GPR_L AS a
				INNER JOIN [Medispan_Staging].[dbo].[MF2NDC_H] AS B ON a.Generic_Product_Packaging_Code = B.Generic_Product_Packaging_Code
				WHERE GPPC_Price_Code = 1	
						) AS dt
					CROSS APPLY(SELECT DISTINCT da.DateKey
									, dd.DrugKey
									, dt.AAWP
									, dd.NDC
									FROM Pricing.dbo.DateDim AS da
									CROSS JOIN Pricing.dbo.DrugDim AS dd
									WHERE dt.NDC = dd.NDC
									AND da.TheDate >= dt.StartDate
									AND da.TheDate < dt.EndDate
									) AS ca
					WHERE dt.NDC = ca.NDC
			 ) AS s(DateKey, DrugKey, AAWP, NDC)
			  ON t.[DrugKey] = s.DrugKey AND t.DateKey = s.DateKey

		WHEN MATCHED THEN
		UPDATE 
			SET DrugKey = s.DrugKey
			, AAWP = s.AAWP

		WHEN NOT MATCHED THEN
		INSERT(DrugKey
				, DateKey
				, AAWP
				)
		VALUES(s.DrugKey
				, s.DateKey
				, s.AAWP
				);

	--Load GEAP data 
	MERGE [Staging].[MedispanPricing] AS t
	USING(SELECT ca.DateKey
			, ca.DrugKey
			, NULLIF(ca.GEAP, 0.00) AS WAC
			, ca.NDC
			FROM(SELECT B.NDC_UPC_HRI AS NDC
				, CONVERT(DATETIME, CONVERT(VARCHAR(8), A.Last_Change_Date), 120) AS StartDate
				, DATEADD(DAY, 7, CONVERT(DATETIME, CONVERT(VARCHAR(8), A.Last_Change_Date), 120)) AS EndDate
				, CONVERT(MONEY, A.Unit_Price) AS GEAP
				FROM [Medispan_Staging].dbo.MF2GPR_L AS a
				INNER JOIN [Medispan_Staging].[dbo].[MF2NDC_H] AS B ON a.Generic_Product_Packaging_Code = B.Generic_Product_Packaging_Code
				WHERE GPPC_Price_Code = 2	
						) AS dt
					CROSS APPLY(SELECT DISTINCT da.DateKey
									, dd.DrugKey
									, dt.GEAP
									, dd.NDC
									FROM Pricing.dbo.DateDim AS da
									CROSS JOIN Pricing.dbo.DrugDim AS dd
									WHERE dt.NDC = dd.NDC
									AND da.TheDate >= dt.StartDate
									AND da.TheDate < dt.EndDate
									) AS ca
					WHERE dt.NDC = ca.NDC
			 ) AS s(DateKey, DrugKey, GEAP, NDC)
			  ON t.[DrugKey] = s.DrugKey AND t.DateKey = s.DateKey

		WHEN MATCHED THEN
		UPDATE 
			SET DrugKey = s.DrugKey
			, GEAP = s.GEAP

		WHEN NOT MATCHED THEN
		INSERT(DrugKey
				, DateKey
				, GEAP
				)
		VALUES(s.DrugKey
				, s.DateKey
				, s.GEAP
				);

	UPDATE STATISTICS [Staging].[MedispanPricing]


END
GO
