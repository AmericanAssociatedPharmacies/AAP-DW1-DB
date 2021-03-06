USE [ClaimsDDS]
GO
/****** Object:  View [dbo].[vwFDSPaidClaimsETL]    Script Date: 12/22/2020 6:54:01 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vwFDSPaidClaimsETL]

AS

SELECT p.EventKey, p.DateofServiceKey, CONVERT(BIT,1) AS IsPaidClaim
FROM(SELECT MAX(e.EventKey) AS EventKey, f.DateofServiceKey, pd.PMID, e.PrescriptionNumber, f.RefillNumber, ISNULL(e.AuthNumber,'N\A') AS AuthNumber, MAX(e.TransactionDate) AS TransactionDate
	FROM dbo.EventDimFDS AS e
	INNER JOIN dbo.ClaimFactFDS AS f ON e.EventKey = f.EventKey
	INNER JOIN dbo.PharmacyDim AS pd ON f.PharmacyKey = pd.PharmacyKey
	WHERE ClaimStatusCode IN('C','P')
	AND pd.PMID > 0
	AND f.QuantityDispensed BETWEEN 1 AND 9999
	AND f.DrugKey > 0
	AND  EXISTS(SELECT 1
				FROM [Staging].[FDS] AS s
				WHERE s.CorrectedPMID = pd.PMID
				AND e.PrescriptionNumber = s.PrescriptionNumber
				AND f.RefillNumber = s.RefillNumber									
				) 
	GROUP BY f.DateofServiceKey, pd.PMID, e.PrescriptionNumber, f.RefillNumber, ISNULL(e.AuthNumber,'N\A')
	)AS p 
LEFT OUTER JOIN(SELECT e.EventKey, pd.PMID, e.PrescriptionNumber, f.RefillNumber, ISNULL(e.AuthNumber,'N\A') AS AuthNumber, e.TransactionDate
				FROM dbo.EventDimFDS AS e
				INNER JOIN dbo.ClaimFactFDS AS f ON e.EventKey = f.EventKey
				INNER JOIN dbo.PharmacyDim AS pd ON f.PharmacyKey = pd.PharmacyKey
				WHERE ClaimStatusCode IN('V','R')
				AND pd.PMID > 0
				AND f.QuantityDispensed BETWEEN 1 AND 9999
				AND f.DrugKey > 0
				AND  EXISTS(SELECT 1
							FROM [Staging].[FDS] AS s
							WHERE s.CorrectedPMID = pd.PMID
							AND e.PrescriptionNumber = s.PrescriptionNumber
							AND f.RefillNumber = s.RefillNumber									
							) 
				) AS cj ON p.PMID = cj.PMID
						AND p.PrescriptionNumber = cj.PrescriptionNumber
						AND p.RefillNumber = cj.RefillNumber
						AND ISNULL(p.AuthNUmber, 'N\A') = ISNULL(cj.AuthNumber, 'N\A')						
WHERE p.TransactionDate > ISNULL(cj.TransactionDate, '19000101')
GO
