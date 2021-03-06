USE [Pricing]
GO
/****** Object:  StoredProcedure [dbo].[usp_PriceFact_Load_McKesson]    Script Date: 12/22/2020 7:32:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






CREATE PROCEDURE [dbo].[usp_PriceFact_Load_McKesson]


/*******************************************************************************

-- Author: Scott Edwards
-- Description: Used to insert\update McKesson information for PricingFAct table.
-- InParameter: N\A
-- OutParameter: N\A
-- Created Date: 08/22/2017
-- Revision History :
-- Modified Date Modified By version Description
-- Test code: Execute sproc as is.

********************************************************************************/

AS


SET NOCOUNT ON;

BEGIN

	MERGE [dbo].[PriceFact] AS t
	USING(SELECT dd.DateKey
			, d.DrugKey
			, B.CompetitorDrugKey
			, A.[Price] AS McKesson
			FROM [Staging].[McKesson] AS A
			INNER JOIN [dbo].[CompetitorDrugDim] AS B ON A.RowversionID = B.McKessonRowVersionID
			INNER JOIN dbo.DateDim AS dd ON A.DateKey = dd.DateKey
			INNER JOIN(SELECT MAX(DrugKey) AS DrugKey
						, NDC
						FROM dbo.DrugDim
						GROUP BY NDC
						) AS d ON a.NDC = d.NDC
			) AS s (DateKey, DrugKey, CompetitorDrugKey, McKesson)
				ON t.DrugKey = s.DrugKey
					AND t.DateKey = s.DateKey
					AND t.CompetitorDrugKey = s.CompetitorDrugKey
	WHEN MATCHED THEN
	UPDATE SET McKesson = s.McKesson
					
	WHEN NOT MATCHED THEN
	INSERT(DateKey
			, DrugKey
			, CompetitorDrugKey
			, McKesson
			)

	VALUES(s.DateKey
			, s.DrugKey
			, s.CompetitorDrugKey
			, s.McKesson
			);


END





GO
