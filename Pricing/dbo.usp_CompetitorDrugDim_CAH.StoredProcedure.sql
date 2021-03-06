USE [Pricing]
GO
/****** Object:  StoredProcedure [dbo].[usp_CompetitorDrugDim_CAH]    Script Date: 12/22/2020 7:32:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO








CREATE PROCEDURE [dbo].[usp_CompetitorDrugDim_CAH]

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
	USING(SELECT ROW_NUMBER() OVER(PARTITION BY [DateKey], dd.[NDC] ORDER BY(SELECT NULL)) AS RN
			, [DateKey]
			, ISNULL(dd.[NDC], 0) AS NDC
			, s.NDC AS CAH_NDC
			, [CardinalItemNumber]
			, s.[ContractType]
			, s.[RowVersionID] AS [CAH_RowVersionID]
			FROM [Staging].[CardinalCatalog] AS s
			INNER JOIN(SELECT MAX(DrugKey) AS DrugKey
						, NDC
						FROM dbo.DrugDim
						GROUP BY NDC
						) AS dd ON s.NDC = dd.NDC		
			) AS s(RN, DateKey, NDC, CAH_NDC ,[CardinalItemNumber], ContractType, CAH_RowVersionID)
			ON t.NDC = s.NDC
			AND t.DateKey = s.DateKey
			AND s.RN = 1
				
	WHEN MATCHED THEN
	UPDATE SET [CAHItemNumber] = s.[CardinalItemNumber]
				, [CAH_NDC] = s.CAH_NDC	
				, CAH_RowVersionID = s.CAH_RowVersionID
				, [CAHContractType] = s.ContractType
	WHEN NOT MATCHED THEN	
	INSERT(DateKey
			, NDC
			, [CAHItemNumber]
			, [CAH_NDC]
			, [CAHContractType]
			, CAH_RowVersionID
			)
	VALUES(s.DateKey
			, s.NDC
			, s.[CardinalItemNumber]
			, s.[CAH_NDC]	
			, s.ContractType
			, s.CAH_RowVersionID
			);


END







GO
