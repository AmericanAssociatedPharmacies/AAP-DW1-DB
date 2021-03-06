USE [Pricing]
GO
/****** Object:  StoredProcedure [dbo].[usp_PriceFact_Load_CAH]    Script Date: 12/22/2020 7:32:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[usp_PriceFact_Load_CAH]

/*******************************************************************************

-- Author: Scott Edwards
-- Description: Used to insert\update CAH information for PricingFact table.
-- InParameter: N\A
-- OutParameter: N\A
-- Created Date: 08/16/2017
-- Revision History :
-- Modified Date Modified By version Description
-- Test code: Execute sproc as is.

********************************************************************************/


AS

SET NOCOUNT ON;

BEGIN

	MERGE [dbo].[PriceFact] AS t
	USING(SELECT ISNULL(d.DrugKey, 0) AS DrugKey
			, cah.DateKey
			, ISNULL(cd.[CompetitorDrugKey], 0) AS CompetitorDrugKey
			, [CardinalInvoicePrice]
			, CONVERT(MONEY, [CardinalInvoicePrice]/[Size]) AS [CardinalPricePerUnit]
			FROM [Staging].[CardinalCatalog] AS cah
			INNER JOIN(SELECT MAX(DrugKey) AS DrugKey
						, NDC
						FROM dbo.DrugDim
						GROUP BY NDC
						) AS d ON cah.NDC = d.NDC
			INNER JOIN [dbo].[CompetitorDrugDim] AS cd ON cah.[RowVersionID] = cd.[CAH_RowVersionID]
				) AS s (DrugKey, DateKey, CompetitorDrugKey, CardinalInvoicePrice, CardinalPricePerUnit)
				ON t.DateKey = s.DateKey
					AND t.DrugKey = s.DrugKey
					AND t.CompetitorDrugKey = s.CompetitorDrugKey
	WHEN MATCHED THEN
	UPDATE SET [CardinalInvoicePrice] = s.CardinalInvoicePrice
			   , [CardinalPricePerUnit] = s.CardinalPricePerUnit
	WHEN NOT MATCHED THEN
	INSERT(DateKey
			, DrugKey
			, CompetitorDrugKey
			, [CardinalInvoicePrice]
			, [CardinalPricePerUnit]	
		   )
	VALUES(s.DateKey
			, s.DrugKey
			, s.CompetitorDrugKey
			, s.CardinalInvoicePrice
			, s.CardinalPricePerUnit	
		  );

END


GO
