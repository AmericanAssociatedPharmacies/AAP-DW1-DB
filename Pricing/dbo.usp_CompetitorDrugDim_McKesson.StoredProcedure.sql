USE [Pricing]
GO
/****** Object:  StoredProcedure [dbo].[usp_CompetitorDrugDim_McKesson]    Script Date: 12/22/2020 7:32:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO









CREATE PROCEDURE [dbo].[usp_CompetitorDrugDim_McKesson]

/*******************************************************************************

-- Author: Scott Edwards
-- Description: Used to insert\update McKesson information for CompetitorDrugDim table.
-- InParameter: N\A
-- OutParameter: N\A
-- Created Date: 05/29/2018
-- Revision History :
-- Modified Date Modified By version Description
-- Test code: Execute sproc as is.

********************************************************************************/

AS

SET NOCOUNT ON;

BEGIN

	MERGE [dbo].[CompetitorDrugDim] AS t
	USING(SELECT DISTINCT ROW_NUMBER() OVER(PARTITION BY A.DateKey, dd.NDC ORDER BY(SELECT NULL)) AS RN
			, a.DateKey
			, ISNULL(dd.[NDC], 0) AS NDC
			, a.[ItemNumber] AS McKessonItemNumber
			, a.NDC AS McKesson_NDC
			, a.RowversionID AS McKessonRowversionID
			FROM [Staging].[McKesson] AS a
			INNER JOIN(SELECT MAX(DrugKey) AS DrugKey
						, NDC
						FROM dbo.DrugDim
						GROUP BY NDC
						) AS dd ON a.NDC = dd.NDC			
			) AS s(RN, DateKey, NDC, McKessonItemNumber, McKesson_NDC, McKessonRowversionID)
			ON t.DateKey = s.DateKey
				AND t.NDC = s.NDC
				AND s.RN = 1				
	WHEN MATCHED THEN
	UPDATE SET McKessonItemNumber = s.McKessonItemNumber
				, McKesson_NDC = s.McKesson_NDC
				, McKessonRowversionID = s.McKessonRowversionID
	
	WHEN NOT MATCHED THEN	
	INSERT(DateKey
			, NDC
			, McKessonItemNumber
			, McKesson_NDC
			, McKessonRowversionID
			)
	VALUES(s.DateKey
			, s.NDC
			, s.McKessonItemNumber
			, s.McKesson_NDC
			, s.McKessonRowversionID
			);


END








GO
