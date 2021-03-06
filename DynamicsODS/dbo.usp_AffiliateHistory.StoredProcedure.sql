USE [DynamicsODS]
GO
/****** Object:  StoredProcedure [dbo].[usp_AffiliateHistory]    Script Date: 12/22/2020 6:59:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_AffiliateHistory]

AS

SET NOCOUNT ON;

BEGIN

	SELECT DISTINCT u.new_pmid AS PMID, a.new_affiliategroupname AS GroupName, a.[new_affiliationstart], a.[new_affiliationend], a.new_reason, a.statuscodename
	FROM [dbo].[CRM_AffiliateHistory] AS a
	INNER JOIN dbo.CRM_AccountEntity_User AS u ON a.new_accountid = u.accountid

END
GO
