USE [Pricing]
GO
/****** Object:  StoredProcedure [dbo].[usp_CompetitorDrugDim_API]    Script Date: 12/22/2020 7:32:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






CREATE PROCEDURE [dbo].[usp_CompetitorDrugDim_API]

/*******************************************************************************

-- Author: Scott Edwards
-- Description: Used to insert\update ABC information for CompetitorDrugDim table.
-- InParameter: N\A
-- OutParameter: N\A
-- Created Date: 08/29/2017
-- Revision History :
-- Modified Date Modified By version Description
-- Test code: Execute sproc as is.

********************************************************************************/

AS

SET NOCOUNT ON;

BEGIN

	MERGE [dbo].[CompetitorDrugDim] AS t
	USING(SELECT ROW_NUMBER() OVER(PARTITION BY A.[DateKey], dd.[NDC] ORDER BY(SELECT NULL)) AS RN
			, A.[DateKey]
			, ISNULL(dd.[NDC], 0) AS NDC
			, a.NDC AS API_NDC
			, [API_ItemNumber]
			, A.RowversionID AS API_RowVersionID
			FROM [Staging].[APIPricing]	AS a
			INNER JOIN(SELECT MAX(DrugKey) AS DrugKey
						, NDC
						FROM dbo.DrugDim
						GROUP BY NDC
						) AS dd ON a.NDC = dd.NDC		
			) AS s(RN, DateKey, NDC, API_NDC, [API_ItemNumber], API_RowVersionID)
			ON t.DateKey = s.DateKey
			AND t.NDC = s.NDC
			AND s.RN = 1
							
	WHEN MATCHED THEN
	UPDATE SET [API_ItemNumber] = s.[API_ItemNumber]
				, API_NDC = s.API_NDC
				, API_RowversionID = s.API_RowversionID	
	WHEN NOT MATCHED THEN	
	INSERT(DateKey
			, NDC
			, [API_ItemNumber]	
			, [API_NDC]
			, API_RowVersionID
			)
	VALUES(s.DateKey
			, s.NDC
			, s.[API_ItemNumber]
			, s.API_NDC	
			, s.API_RowVersionID
			);


END





GO
