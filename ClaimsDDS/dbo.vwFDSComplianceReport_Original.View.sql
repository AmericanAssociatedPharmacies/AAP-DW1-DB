USE [ClaimsDDS]
GO
/****** Object:  View [dbo].[vwFDSComplianceReport_Original]    Script Date: 12/22/2020 6:54:01 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE VIEW [dbo].[vwFDSComplianceReport_Original]

AS


SELECT dt.DateKey
		, dt.PMID
		, GPI
		, Description
		, QuantityDispensed
		, PrescriptionNumber
		, RefillNumber
		, TransactionDate
		, NDC
		, [Is340BClaim]
		, dt.IsGeneric
		--, dt.IsBrand
		FROM(SELECT d.DateKey
			, t4.PMID
			, t2.GPI
			, t2.Description		
			, t1.QuantityDispensed 
			, t3.[PrescriptionNumber]
			, t1.[RefillNumber]
			, t3.[TransactionDate]
			, t2.NDC
			, t3.Is340BClaim	
			, CASE
				WHEN t2.MultiSourceCode = 'Y' THEN 1
				ELSE 0
				END AS IsGeneric
			--, ISNULL(g.IsGeneric,0) AS IsGeneric
			--, ISNULL(b.IsBrand,0) AS IsBrand
			FROM ClaimsDDS.dbo.ClaimFactFDS AS t1
			INNER JOIN ClaimsDDS.dbo.DrugDim AS t2 ON t1.DrugKey = t2.DrugKey
			INNER JOIN ClaimsDDS.dbo.EventDimFDS AS t3 ON t1.EventKey = t3.EventKey
			INNER JOIN ClaimsDDS.dbo.PharmacyDim AS t4 ON t1.PharmacyKey = t4.PharmacyKey
			INNER JOIN ClaimsDDS.dbo.DateDim AS d ON t1.DateofServiceKey = d.DateKey
			--LEFT OUTER JOIN(SELECT DrugKey, CONVERT(BIT,1) AS IsGeneric
			--					FROM ClaimsDDS.dbo.DrugDim
			--					WHERE MultiSourceCode IN('Y','M') 
			--					) AS g ON t2.DrugKey = g.DrugKey
			--LEFT OUTER JOIN(SELECT DrugKey, CONVERT(BIT,1) AS IsBrand
			--					FROM ClaimsDDS.dbo.DrugDim
			--					WHERE MultiSourceCode IN('N','O')
			--					) AS b ON t2.DrugKey = b.DrugKey							
			WHERE t1.DateofServiceKey = (t1.DateofServiceKey + 0) -- Added for performance. Do not remove!
			AND t3.EventKey = (t3.EventKey + 0)	-- Added for performance. Do not remove
			AND t2.DrugKey = (t2.DrugKey + 0)
			--AND EXISTS(SELECT 1
			--				FROM(SELECT DISTINCT GPI 
			--					FROM DrugMaster.[dbo].[vwAPIandCAHCatalog]
			--					WHERE (IsAPIActive = 1	OR IsCAHActive = 1)
			--					AND IsCAHActive = 1
			--					) AS ac
			--				WHERE t2.GPI= ac.GPI						
			--			)
			--AND EXISTS(SELECT 1
			--			FROM ClaimsDDS.dbo.ComplianceReportXref AS x
			--			WHERE x.EventKey = t3.EventKey
			--			)
			AND t3.PayerSequence = 1
			AND t3.ClaimStatusCode IN('C', 'P')
			AND t1.QuantityDispensed BETWEEN 1 AND 9999
			AND t4.PMID <> 0 -- 02/05/2020 Added by RSE to filter out unmapped PMID's
			AND t2.DrugKey > 0
			AND t1.DateofServiceKey = (t1.DateofServiceKey + 0) -- Added for performance. Do not remove!
			AND t3.EventKey = (t3.EventKey + 0)	-- Added for performance. Do not remove
			AND t2.DrugKey = (t2.DrugKey + 0)
			AND EXISTS(SELECT 1
							FROM(SELECT DISTINCT GPI 
								FROM DrugMaster.[dbo].[vwAPIandCAHCatalog]
								WHERE (IsAPIActive = 1	OR IsCAHActive = 1)
								AND IsCAHActive = 1
								) AS ac
							WHERE t2.GPI= ac.GPI						
						)
			AND EXISTS(SELECT 1
						FROM ClaimsDDS.dbo.ComplianceReportXref AS x
						WHERE x.EventKey = t3.EventKey
						)
			) AS dt
		WHERE dt.IsGeneric = 1




GO
