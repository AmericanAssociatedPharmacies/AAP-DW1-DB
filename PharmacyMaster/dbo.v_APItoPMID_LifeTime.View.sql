USE [PharmacyMaster]
GO
/****** Object:  View [dbo].[v_APItoPMID_LifeTime]    Script Date: 12/22/2020 7:35:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE VIEW [dbo].[v_APItoPMID_LifeTime]
AS

/*-------------------
Start of CTEs
-------------------*/

--The purpose of PMID Rank is to capture the scenario of one APIAccountNo having multiple PMIDs
WITH PMIDRank as 
(
	SELECT pm.PMID
		, pm.AAPAccountNo
		, pm.APIAccountNo
		, pm.AAPEffectiveDate
		, pm.AAPQuitDate
		, pm.DateOpened
		, pm.Created
		, RANK() OVER (PARTITION BY LEFT(pm.APIAccountNo,8) ORDER BY PMID ASC) AS PMIDNum
	FROM PharmacyMaster.dbo.PM_Pharmacy as pm
	INNER JOIN (
				SELECT LEFT(APIAccountNo,8) as APIAccountNo
					, COUNT(*) as Cnt
				FROM PharmacyMaster.dbo.PM_Pharmacy
				WHERE APIAccountNo IS NOT NULL 
				AND APIAccountNo <> ''
				GROUP BY LEFT(APIAccountNo,8)
				HAVING COUNT(*) > 1
				) as a
	ON LEFT(pm.APIAccountNo, 8) = LEFT(a.APIAccountNo,8)
), 

--Need to get the first order date because there are some cases where the first order date is
--prior to the Date Opened date.
api_firstorder as
(
	SELECT DISTINCT WHAccountID	
		, MIN(InvDate) as FirstOrderDate
		, MAX(InvDate) AS LastOrderDate
	FROM API.dbo.APISalesDetail
	GROUP BY WHAccountID
),

--Capturing the API Account Numbers that have only been associated with one PMID in their lifetime.
--The start date is either assigned to the Date Opened or the First Order Date. If they have no orders, the start
--date is assigned to the Date Opened. If they have a First Order Date, we use the minimum date between First Order Date
--and the Date Opened.
single_pmid as
(
	SELECT 
		pm.APIAccountNo
		, pm.PMID
		, pm.AAPEffectiveDate
		, pm.AAPQuitDate
		, pm.DateOpened
		, b.FirstOrderDate
		, IIF(b.FirstOrderDate IS NULL, pm.DateOpened, IIF(pm.DateOpened <= b.FirstOrderDate, pm.DateOpened, b.FirstOrderDate)) as API_PMID_EffectiveDate
		, '29991231' as API_PMID_QuitDate
		, pm.AAPAccountNo
		, b.LastOrderDate
	FROM 
		PharmacyMaster.dbo.PM_Pharmacy as pm
	LEFT JOIN 
		api_firstorder as b
		ON LEFT(pm.APIAccountNo,8) = b.WHAccountID
	INNER JOIN 
		(
			SELECT LEFT(APIAccountNo,8) as APIAccountNo
				, COUNT(*) as Cnt
			FROM PharmacyMaster.dbo.PM_Pharmacy
			GROUP BY LEFT(APIAccountNo,8)
			HAVING COUNT(*) = 1
		) as a
		ON LEFT(pm.APIAccountNo, 8) = LEFT(a.APIAccountNo,8)
)
/*-------------------
End of CTEs
-------------------*/


SELECT 
	p.APIAccountNo
	, p.PMID
	, p.AAPEffectiveDate
	, ISNULL(p.AAPQuitDate, '29991231') AS AAPQuitDate
	, p.DateOpened
	, a.FirstOrderDate
	, IIF(p.PMIDNum = 1, IIF(a.FirstOrderDate IS NULL, p.DateOpened, IIF(p.DateOpened <= a.FirstOrderDate, p.DateOpened, a.FirstOrderDate)), ISNULL(p.AAPEffectiveDate, p.Created)) as API_PMID_EffectiveDate
	, IIF(p.AAPQuitDate IS NOT NULL, ISNULL(p2.AAPEffectiveDate, p2.Created), '29991231') as API_PMID_QuitDate
	, p.AAPAccountNo
	, a.LastOrderDate
FROM 
	PMIDRank as p
LEFT JOIN 
	PMIDRank as p2
	ON LEFT(p.APIAccountNo, 8) = LEFT(p2.APIAccountNo,8) AND p.PMIDNum = (p2.PMIDNum - 1)
LEFT JOIN 
	api_firstorder as a
	ON LEFT(p.APIAccountNo, 8) = a.WHAccountID 
--ORDER BY p.APIAccountNo


UNION 

SELECT 
	APIAccountNo
	, PMID
	, AAPEffectiveDate
	, ISNULL(AAPQuitDate, '29991231') AS AAPQuitDate
	, DateOpened
	, FirstOrderDate
	, API_PMID_EffectiveDate
	, API_PMID_QuitDate
	, AAPAccountNo
	, LastOrderDate
FROM 
	single_pmid

UNION

SELECT dt.APIAccountNo
, dt.PMID
, dt.AAPEffectiveDate
, dt.AAPQuiteDate
, NULL AS DateOpened
, NULL AS FirstOrderDate
, NULL AS API_PMID_EffectiveDate
, NULL AS API_PMID_QuitDate
, NULL AS AAPAccountNo
, NULL AS LastOrderDate
FROM(SELECT '0' AS APIAccountNo
	, 0 AS PMID
	, '19000101' AS AAPEffectiveDate
	, '29991231' AS AAPQuiteDate
	) AS dt





GO
