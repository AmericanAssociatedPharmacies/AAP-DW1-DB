USE [Pricing]
GO
/****** Object:  StoredProcedure [Staging].[usp_Load_CAHFormulary_SourceWeekly]    Script Date: 12/22/2020 7:32:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE PROCEDURE [Staging].[usp_Load_CAHFormulary_SourceWeekly]

AS


SET NOCOUNT ON;

BEGIN

	MERGE [Staging].[CardinalCatalog] AS t
	USING(SELECT dt.NDC
			, dt.DateKey
			, dt.CardinalItemNumber
			, dt.CardinalInvoicePrice
			, dt.Size
			, dt.ContractType
			, dt.IsFormularyFile
			, dt.PricePerUnit
			FROM(SELECT ROW_NUMBER() OVER(PARTITION BY NDC, CASE
															WHEN DATEPART(dw, GETDATE()) = 2 THEN DateKey
															ELSE CAST(CONVERT(varchar(20), GETDATE(), 112) as INT)
															END 
															ORDER BY(SELECT NULL)
															) AS RN
						, NDC
						, CASE
							WHEN DATEPART(dw, GETDATE()) = 2 THEN DateKey
							ELSE CAST(CONVERT(varchar(20), GETDATE(), 112) as INT)
							END AS DateKey
						, CardinalItemNumber
						, CardinalInvoicePrice
						, Size
						, ContractType
						, IsFormularyFile
						, PricePerUnit
						FROM [Staging].[vw_CAH_FormularyFiles_SourceWeekly]	
					) AS dt
					WHERE dt.RN = 1
					AND NDC IS NOT NULL 
					AND DateKey IS NOT NULL
		) AS s(NDC
				, Datekey
				, CardinalItemNumber
				, CardinalInvoicePrice
				, Size
				, ContractType
				, IsFormularyFile
				, PricePerUnit
				) ON t.DateKey = s.DateKey
				AND t.NDC = s.NDC				
		WHEN MATCHED THEN 
		UPDATE SET [CardinalItemNumber] = s.CardinalItemNumber
			, [CardinalInvoicePrice] = s.CardinalInvoicePrice
			, [Size] = s.Size
			, [ContractType] = s.ContractType
			, IsFormularyFile = s.IsFormularyFile
			, PricePerUnit = s.PricePerUnit

		WHEN NOT MATCHED THEN
		INSERT(NDC
				, Datekey
				, CardinalItemNumber
				, CardinalInvoicePrice
				, Size
				, ContractType
				, IsFormularyFile
				, PricePerUnit		
				)
		VALUES(s.NDC
				, s.Datekey
				, s.CardinalItemNumber
				, s.CardinalInvoicePrice
				, s.Size
				, s.ContractType
				, s.IsFormularyFile
				, s.PricePerUnit		
				);

	--INSERT INTO [Staging].[CardinalCatalog](NDC, DateKey, CardinalItemNumber, CardinalInvoicePrice, Size, ContractType, IsFormularyFile, PricePerUnit)
	--SELECT s.NDC
	--, s.Datekey
	--, s.CardinalItemNumber
	--, s.CardinalInvoicePrice
	--, s.Size
	--, s.ContractType
	--, s.IsFormularyFile
	--, s.PricePerUnit
	--FROM [Staging].[vw_CAH_FormularyFiles_SourceWeekly] AS s
	--WHERE NOT EXISTS(SELECT 1
	--					FROM dbo.CompetitorDrugDim AS c
	--					WHERE s.DateKey = c.DateKey
	--					AND s.NDC = c.NDC
	--				 )

END




GO
