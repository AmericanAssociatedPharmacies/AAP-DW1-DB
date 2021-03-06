USE [DynamicsODS]
GO
/****** Object:  View [dbo].[vwAPIAccount]    Script Date: 12/22/2020 6:59:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vwAPIAccount]


AS



SELECT a.[new_api_account] AS APIAccountNo
, u.new_pmid AS PMID
, CONVERT(DATE,NULL) AS APIEffectiveDate
, a.[new_apideactivation] AS APIQuitDate
FROM [dbo].[CRM_AccountEntity_API] AS a
INNER JOIN [dbo].[CRM_AccountEntity_User] AS u ON a.accountid = u.accountid
AND u.new_pmid IS NOT NULL
AND a.new_api_account IS NOT NULL
--ORDER BY a.[new_api_account] ASC, u.new_pmid DESC 
GO
