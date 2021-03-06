USE [Pricing]
GO
/****** Object:  StoredProcedure [dbo].[usp_CompetitorDrugDim_ABC]    Script Date: 12/22/2020 7:32:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO








CREATE PROCEDURE [dbo].[usp_CompetitorDrugDim_ABC]

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
	USING(SELECT ROW_NUMBER() OVER(PARTITION BY A.DateKey, dd.NDC ORDER BY(SELECT NULL)) AS RN
			, a.DateKey
			, ISNULL(dd.[NDC], 0) AS NDC
			, a.[ABCItemNum]
			, a.NDC AS ABC_NDC
			, a.RowversionID AS ABC_RowversionID
			FROM [Staging].[ABC] AS a
			INNER JOIN(SELECT MAX(DrugKey) AS DrugKey
						, NDC
						FROM dbo.DrugDim
						GROUP BY NDC
						) AS dd ON a.NDC = dd.NDC			
			) AS s(RN, DateKey, NDC, ABCItemNum, ABC_NDC, ABC_RowversionID)
			ON t.DateKey = s.DateKey
				AND t.NDC = s.NDC
				AND s.RN = 1				
	WHEN MATCHED THEN
	UPDATE SET ABCItemNumber = s.ABCItemNum
				, [ABC_NDC] = s.ABC_NDC
				, ABC_RowVersionID = s.ABC_RowversionID
	
	WHEN NOT MATCHED THEN	
	INSERT(DateKey
			, NDC
			, ABCItemNumber	
			, ABC_NDC
			, ABC_RowversionID
			)
	VALUES(s.DateKey
			, s.NDC
			, s.ABCItemNum	
			, s.ABC_NDC
			, s.ABC_RowversionID
			);


END







GO
