USE [DynamicsODS]
GO
/****** Object:  StoredProcedure [dbo].[usp_CAHAccounts]    Script Date: 12/22/2020 6:59:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE PROCEDURE [dbo].[usp_CAHAccounts]

AS

SET NOCOUNT ON;

BEGIN

	SELECT CONVERT(INT, u.new_pmid) AS PMID
	, c.[new_cah_account] AS CAHAccountPrimary
	, c.[new_cah_account2] AS CAHAccount2
	, c.[new_cah_account3] AS CAHAccount3
	, c.[new_cahcsosaccount] AS CAHCSOSAccount
	, c.[new_cahposaccount] AS CAHPOSAccount
	, c.new_cahspecialtyaccount AS [CAHSpecialtyAccount]
	, c.new_cahotcaccount AS [CAHOTCAccount]
	, c.new_cahdmeaccount AS [CAHDMEAccount]
	, c.new_cahdepositaccount AS [CAHDepositAccount]
	, c.[new_cahstaccount] AS CAHScanTossAccount
	, u.new_aap_effective_date AS AAPStartDate
	, u.[new_aapquit] AS AAPEndDate
	, a.[new_api_account] AS APIAccountNo
	, c.[new_cahcomboaccount] AS CAHComboAccount
	, c.[new_cahpvatermdate] AS CAHPVATermDate
	FROM [dbo].[CRM_AccountEntity_CAH] AS c
	INNER JOIN dbo.CRM_AccountEntity_User AS u ON c.accountid = u.accountid
	INNER JOIN dbo.CRM_AccountEntity_API AS a ON c.accountid = a.accountid

END




GO
