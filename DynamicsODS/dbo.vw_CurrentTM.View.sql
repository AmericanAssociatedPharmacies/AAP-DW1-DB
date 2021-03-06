USE [DynamicsODS]
GO
/****** Object:  View [dbo].[vw_CurrentTM]    Script Date: 12/22/2020 6:59:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vw_CurrentTM]

AS
    SELECT au.new_PMID As PMID
            , ae.new_api_account As APIAccountNo
            , au.new_corporatename AccountName
            , au.new_territoryname As Territory
            , au.new_territorymanagername As TMName
    FROM DynamicsODS.[dbo].[CRM_AccountEntity_User] AS au 
	join DynamicsODS.[dbo].[CRM_AccountEntity_API] AS ae on au.accountid = ae.accountid
GO
