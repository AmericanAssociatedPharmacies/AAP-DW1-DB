USE [DynamicsODS]
GO
/****** Object:  View [dbo].[vwCAHAccount]    Script Date: 12/22/2020 6:59:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE VIEW [dbo].[vwCAHAccount]

AS

SELECT CONVERT(INT,dt.PMID) AS PMID
, LTRIM(RTRIM(dt.CAHAccountNo)) AS CAHAccountNo
, dt.AAPEffectiveDate
, dt.AAPQuitDate
, CAST(CONVERT(VARCHAR(20),AAPEffectiveDate,112) as INT) AS AAPEffectiveDateKey
, CAST(CONVERT(VARCHAR(20),AAPQuitDate ,112) as INT) AS AAPQuitDateKey
, CASE
		WHEN LEN(LTRIM(RTRIM(CAHAccountNo))) < 6 THEN REVERSE(LEFT(REVERSE(STUFF(LTRIM(RTRIM(CAHAccountNo)), 1, 0, REPLICATE('0', 6 - LEN(LTRIM(RTRIM(CAHAccountNo)))))), 6))
		ELSE LTRIM(RTRIM(CAHAccountNo))
		END AS CorrectedCAHAccountNo
, dt.AAPAccountNo
, dt.PreviousMemberPMID
, dt.IsPVA
FROM(SELECT u.new_pmid AS PMID
	, c.[new_cah_account] AS CAHAccountNo
	, u.[new_aap_effective_date] AS AAPEffectiveDate
	, ISNULL(u.[new_aapquit], '29991231') AS AAPQuitDate
	, u.[new_aap_account] AS AAPAccountNo
	, u.[new_previousmemberpmid] AS PreviousMemberPMID
	, CONVERT(BIT,CASE	
					WHEN c.[new_cahpvastatusname] = 'ACTIVE' THEN 1
					ELSE 0
					END
			)
		 AS IsPVA
	FROM DynamicsODS.dbo.CRM_AccountEntity_CAH AS c
	INNER JOIN DynamicsODS.[dbo].[CRM_AccountEntity_User] AS u ON c.accountid = u.accountid
	WHERE c.[new_cah_account] IS NOT NULL

	UNION

	SELECT u.new_pmid AS PMID
	, c.[new_cah_account2] AS CAHAccountNo
	, u.[new_aap_effective_date] AS AAPEffectiveDate
	, ISNULL(u.[new_aapquit], '29991231') AS AAPQuitDate
	, u.[new_aap_account] AS AAPAccountNo
	, u.[new_previousmemberpmid] AS PreviousMemberPMID
	, CONVERT(BIT,CASE	
					WHEN c.[new_cahpvastatusname] = 'ACTIVE' THEN 1
					ELSE 0
					END
			)
		 AS IsPVA
	FROM DynamicsODS.dbo.CRM_AccountEntity_CAH AS c
	INNER JOIN DynamicsODS.[dbo].[CRM_AccountEntity_User] AS u ON c.accountid = u.accountid
	WHERE c.[new_cah_account2] IS NOT NULL

	UNION

	SELECT u.new_pmid AS PMID
	, c.[new_cah_account3] AS CAHAccountNo
	, u.[new_aap_effective_date] AS AAPEffectiveDate
	, ISNULL(u.[new_aapquit], '29991231') AS AAPQuitDate
	, u.[new_aap_account] AS AAPAccountNo
	, u.[new_previousmemberpmid] AS PreviousMemberPMID
	, CONVERT(BIT,CASE	
					WHEN c.[new_cahpvastatusname] = 'ACTIVE' THEN 1
					ELSE 0
					END
			)
		 AS IsPVA
	FROM DynamicsODS.dbo.CRM_AccountEntity_CAH AS c
	INNER JOIN DynamicsODS.[dbo].[CRM_AccountEntity_User] AS u ON c.accountid = u.accountid
	WHERE c.[new_cah_account3] IS NOT NULL

	UNION

	SELECT u.new_pmid AS PMID
	, c.[new_cahcsosaccount] AS CAHAccountNo
	, u.[new_aap_effective_date] AS AAPEffectiveDate
	, ISNULL(u.[new_aapquit], '29991231') AS AAPQuitDate
	, u.[new_aap_account] AS AAPAccountNo
	, u.[new_previousmemberpmid] AS PreviousMemberPMID
	, CONVERT(BIT,CASE	
					WHEN c.[new_cahpvastatusname] = 'ACTIVE' THEN 1
					ELSE 0
					END
			)
		 AS IsPVA
	FROM DynamicsODS.dbo.CRM_AccountEntity_CAH AS c
	INNER JOIN DynamicsODS.[dbo].[CRM_AccountEntity_User] AS u ON c.accountid = u.accountid
	WHERE c.[new_cahcsosaccount] IS NOT NULL

	UNION

	SELECT u.new_pmid AS PMID
	, c.[new_cahposaccount] AS CAHAccountNo
	, u.[new_aap_effective_date] AS AAPEffectiveDate
	, ISNULL(u.[new_aapquit], '29991231') AS AAPQuitDate
	, u.[new_aap_account] AS AAPAccountNo
	, u.[new_previousmemberpmid] AS PreviousMemberPMID
	, CONVERT(BIT,CASE	
					WHEN c.[new_cahpvastatusname] = 'ACTIVE' THEN 1
					ELSE 0
					END
			)
		 AS IsPVA
	FROM DynamicsODS.dbo.CRM_AccountEntity_CAH AS c
	INNER JOIN DynamicsODS.[dbo].[CRM_AccountEntity_User] AS u ON c.accountid = u.accountid
	WHERE c.[new_cahposaccount] IS NOT NULL

	UNION

	SELECT u.new_pmid AS PMID
	, c.[new_cahstaccount] AS CAHAccountNo
	, u.[new_aap_effective_date] AS AAPEffectiveDate
	, ISNULL(u.[new_aapquit], '29991231') AS AAPQuitDate
	, u.[new_aap_account] AS AAPAccountNo
	, u.[new_previousmemberpmid] AS PreviousMemberPMID
	, CONVERT(BIT,CASE	
					WHEN c.[new_cahpvastatusname] = 'ACTIVE' THEN 1
					ELSE 0
					END
			)
		 AS IsPVA
	FROM DynamicsODS.dbo.CRM_AccountEntity_CAH AS c
	INNER JOIN DynamicsODS.[dbo].[CRM_AccountEntity_User] AS u ON c.accountid = u.accountid
	WHERE c.[new_cahstaccount] IS NOT NULL

	UNION

	SELECT u.new_pmid AS PMID
	, c.[new_cahdepositaccount] AS CAHAccountNo
	, u.[new_aap_effective_date] AS AAPEffectiveDate
	, ISNULL(u.[new_aapquit], '29991231') AS AAPQuitDate
	, u.[new_aap_account] AS AAPAccountNo
	, u.[new_previousmemberpmid] AS PreviousMemberPMID
	, CONVERT(BIT,CASE	
					WHEN c.[new_cahpvastatusname] = 'ACTIVE' THEN 1
					ELSE 0
					END
			)
		 AS IsPVA
	FROM DynamicsODS.dbo.CRM_AccountEntity_CAH AS c
	INNER JOIN DynamicsODS.[dbo].[CRM_AccountEntity_User] AS u ON c.accountid = u.accountid
	WHERE c.[new_cahdepositaccount] IS NOT NULL

	UNION

	SELECT u.new_pmid AS PMID
	, c.[new_cahdmeaccount] AS CAHAccountNo
	, u.[new_aap_effective_date] AS AAPEffectiveDate
	, ISNULL(u.[new_aapquit], '29991231') AS AAPQuitDate
	, u.[new_aap_account] AS AAPAccountNo
	, u.[new_previousmemberpmid] AS PreviousMemberPMID
	, CONVERT(BIT,CASE	
					WHEN c.[new_cahpvastatusname] = 'ACTIVE' THEN 1
					ELSE 0
					END
			)
		 AS IsPVA
	FROM DynamicsODS.dbo.CRM_AccountEntity_CAH AS c
	INNER JOIN DynamicsODS.[dbo].[CRM_AccountEntity_User] AS u ON c.accountid = u.accountid
	WHERE c.[new_cahdepositaccount] IS NOT NULL

	UNION

	SELECT u.new_pmid AS PMID
	, c.[new_cahdmeaccount] AS CAHAccountNo
	, u.[new_aap_effective_date] AS AAPEffectiveDate
	, ISNULL(u.[new_aapquit], '29991231') AS AAPQuitDate
	, u.[new_aap_account] AS AAPAccountNo
	, u.[new_previousmemberpmid] AS PreviousMemberPMID
	, CONVERT(BIT,CASE	
					WHEN c.[new_cahpvastatusname] = 'ACTIVE' THEN 1
					ELSE 0
					END
			)
		 AS IsPVA
	FROM DynamicsODS.dbo.CRM_AccountEntity_CAH AS c
	INNER JOIN DynamicsODS.[dbo].[CRM_AccountEntity_User] AS u ON c.accountid = u.accountid
	WHERE c.[new_cahdmeaccount] IS NOT NULL

	UNION

	SELECT u.new_pmid AS PMID
	, c.[new_cahotcaccount] AS CAHAccountNo
	, u.[new_aap_effective_date] AS AAPEffectiveDate
	, ISNULL(u.[new_aapquit], '29991231') AS AAPQuitDate
	, u.[new_aap_account] AS AAPAccountNo
	, u.[new_previousmemberpmid] AS PreviousMemberPMID
	, CONVERT(BIT,CASE	
					WHEN c.[new_cahpvastatusname] = 'ACTIVE' THEN 1
					ELSE 0
					END
			)
		 AS IsPVA
	FROM DynamicsODS.dbo.CRM_AccountEntity_CAH AS c
	INNER JOIN DynamicsODS.[dbo].[CRM_AccountEntity_User] AS u ON c.accountid = u.accountid
	WHERE c.[new_cahotcaccount] IS NOT NULL

	UNION

	SELECT u.new_pmid AS PMID
	, c.[new_cahspecialtyaccount] AS CAHAccountNo
	, u.[new_aap_effective_date] AS AAPEffectiveDate
	, ISNULL(u.[new_aapquit], '29991231') AS AAPQuitDate
	, u.[new_aap_account] AS AAPAccountNo
	, u.[new_previousmemberpmid] AS PreviousMemberPMID
	, CONVERT(BIT,CASE	
					WHEN c.[new_cahpvastatusname] = 'ACTIVE' THEN 1
					ELSE 0
					END
			)
		 AS IsPVA
	FROM DynamicsODS.dbo.CRM_AccountEntity_CAH AS c
	INNER JOIN DynamicsODS.[dbo].[CRM_AccountEntity_User] AS u ON c.accountid = u.accountid
	WHERE c.[new_cahspecialtyaccount] IS NOT NULL

	UNION

	SELECT u.new_pmid AS PMID
	, c.[new_cahcomboaccount] AS CAHAccountNo
	, u.[new_aap_effective_date] AS AAPEffectiveDate
	, ISNULL(u.[new_aapquit], '29991231') AS AAPQuitDate
	, u.[new_aap_account] AS AAPAccountNo
	, u.[new_previousmemberpmid] AS PreviousMemberPMID
	, CONVERT(BIT,CASE	
					WHEN c.[new_cahpvastatusname] = 'ACTIVE' THEN 1
					ELSE 0
					END
			)
		 AS IsPVA
	FROM DynamicsODS.dbo.CRM_AccountEntity_CAH AS c
	INNER JOIN DynamicsODS.[dbo].[CRM_AccountEntity_User] AS u ON c.accountid = u.accountid
	WHERE c.[new_cahcomboaccount] IS NOT NULL
	) AS dt





GO
