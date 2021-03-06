USE [ClaimsDDS]
GO
/****** Object:  StoredProcedure [dbo].[usp_FDSComplianceReport_Load]    Script Date: 12/22/2020 6:54:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE PROCEDURE [dbo].[usp_FDSComplianceReport_Load]

	@DateKey INT	

AS

SET NOCOUNT ON;

BEGIN
	 
	  	
		SELECT dt.RowID
		, dt.DateKey
		, dt.PMID
		, GPI
		, Description
		, QuantityDispensed
		, IsGeneric
		, PrescriptionNumber
		, RefillNumber
		, TransactionDate
		, NDC
		, [Is340BClaim]
		FROM(SELECT CONVERT(INT,ROW_NUMBER() OVER(ORDER BY (SELECT 1))) AS RowID
			, t1.DateofServiceKey AS DateKey
			, t4.PMID
			, t2.GPI
			, t2.Description		
			, t1.QuantityDispensed 
			, t2.IsGeneric
			--, CASE 
			--	WHEN t2.[MultiSourceCode] = 'Y' THEN 1
			--	ELSE 0
			--	END AS IsGeneric
			, t3.[PrescriptionNumber]
			, t1.[RefillNumber]
			, t3.[TransactionDate]
			, t2.NDC
			, t3.Is340BClaim	
			FROM ClaimsDDS.dbo.ClaimFactFDS AS t1
			INNER JOIN ClaimsDDS.dbo.DrugDim AS t2 ON t1.DrugKey = t2.DrugKey
			INNER JOIN ClaimsDDS.dbo.EventDimFDS AS t3 ON t1.EventKey = t3.EventKey
			INNER JOIN ClaimsDDS.dbo.PharmacyDim AS t4 ON t1.PharmacyKey = t4.PharmacyKey
			INNER JOIN ClaimsDDS.[dbo].[ComplianceReportXref] AS x ON t3.EventKey = x.EventKey
			WHERE t1.DateOfServiceKey = @DateKey
			--AND t3.PayerSequence = 1
			----AND t3.ClaimStatusCode IN('C', 'P')
			--AND t1.QuantityDispensed <= 9999
			--AND t1.QuantityDispensed > 0
			--AND t4.PMID <> 0 -- 02/05/2020 Added by RSE to filter out unmapped PMID's
			--AND t2.GPI <> 'UNKNOWN'		
			--AND EXISTS(SELECT 1
			--				FROM(SELECT DISTINCT GPI 
			--					FROM DrugMaster.[dbo].[vwAPIandCAHCatalog]
			--					WHERE (IsAPIActive = 1	OR IsCAHActive = 1)
			--					AND IsCAHActive = 1
			--					) AS ac
			--				WHERE t2.GPI= ac.GPI						
			--			)
			) AS dt
			ORDER BY dt.RowID ASC
			, dt.DateKey ASC

END

























GO
