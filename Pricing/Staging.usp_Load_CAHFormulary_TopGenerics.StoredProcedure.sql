USE [Pricing]
GO
/****** Object:  StoredProcedure [Staging].[usp_Load_CAHFormulary_TopGenerics]    Script Date: 12/22/2020 7:32:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







CREATE PROCEDURE [Staging].[usp_Load_CAHFormulary_TopGenerics]

AS


SET NOCOUNT ON;

BEGIN

	MERGE [Staging].[CardinalCatalog] AS t
	USING(SELECT DISTINCT dt.RN, dt.NDC, dt.Datekey, dt.CardinalItemNumber, dt.CardinalInvoicePrice, dt.Size, dt.ContractType, dt.IsFormularyFile, dt.PricePerUnit
			FROM(SELECT ROW_NUMBER() OVER(PARTITION BY NDC, DateKey ORDER BY(SELECT NULL)) AS RN
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
				FROM [Staging].[vw_CAH_FormularyFiles_TopGenerics]	
				) AS dt
			WHERE dt.RN = 1
		) AS s(RN, NDC, Datekey, CardinalItemNumber, CardinalInvoicePrice, Size, ContractType, IsFormularyFile, PricePerUnit
				) ON t.DateKey = s.DateKey
				AND t.NDC = s.NDC
				AND s.RN = 1

		WHEN MATCHED AND (s.RN = 1) THEN 
		UPDATE SET [CardinalItemNumber] = s.CardinalItemNumber
			, [CardinalInvoicePrice] = s.CardinalInvoicePrice
			, [Size] = s.Size
			, [ContractType] = s.ContractType
			, IsFormularyFile = s.IsFormularyFile
			, PricePerUnit = s.PricePerUnit

		WHEN NOT MATCHED AND (s.RN = 1) THEN
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

END





GO
