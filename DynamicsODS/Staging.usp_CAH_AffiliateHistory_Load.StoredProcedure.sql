USE [DynamicsODS]
GO
/****** Object:  StoredProcedure [Staging].[usp_CAH_AffiliateHistory_Load]    Script Date: 12/22/2020 6:59:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [Staging].[usp_CAH_AffiliateHistory_Load]

AS

SET NOCOUNT ON;

BEGIN

	INSERT INTO [Staging].[CRM_AffiliateHistory](createdby, createdbyname, createdbyyominame, createdon, createdonbehalfby, createdonbehalfbyname, createdonbehalfbyyominame, importsequencenumber, modifiedby, modifiedbyname, modifiedbyyominame, modifiedon, modifiedonbehalfby, modifiedonbehalfbyname, modifiedonbehalfbyyominame, new_accountid, new_accountidname, new_accountidyominame, new_affiliategroup, new_affiliategroupname, new_affiliateid, new_affiliationend, new_affiliationstart, new_name, new_newaffiliation, new_reason, organizationid, organizationidname, overriddencreatedon, statecode, statecodename, statuscode, statuscodename, timezoneruleversionnumber, utcconversiontimezonecode, versionnumber, DateKey)
	SELECT createdby, createdbyname, createdbyyominame, createdon, createdonbehalfby, createdonbehalfbyname, createdonbehalfbyyominame, importsequencenumber, modifiedby, modifiedbyname, modifiedbyyominame, modifiedon, modifiedonbehalfby, modifiedonbehalfbyname, modifiedonbehalfbyyominame, new_accountid, new_accountidname, new_accountidyominame, new_affiliategroup, new_affiliategroupname, new_affiliateid, new_affiliationend, new_affiliationstart, new_name, new_newaffiliation, new_reason, organizationid, organizationidname, overriddencreatedon, statecode, statecodename, statuscode, statuscodename, timezoneruleversionnumber, utcconversiontimezonecode, versionnumber, DateKey
	FROM ODSIntake.[Staging].[CRM_AffiliateHistory]

END
GO
