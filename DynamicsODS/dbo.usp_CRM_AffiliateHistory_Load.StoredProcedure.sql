USE [DynamicsODS]
GO
/****** Object:  StoredProcedure [dbo].[usp_CRM_AffiliateHistory_Load]    Script Date: 12/22/2020 6:59:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[usp_CRM_AffiliateHistory_Load]

AS

SET NOCOUNT ON;

BEGIN

	MERGE [dbo].[CRM_AffiliateHistory] AS t
	USING [Staging].[CRM_AffiliateHistory] AS s ON t.[new_accountid] = s.[new_accountid]
												--AND (t.createdby <>  s.createdby
												--	OR t.createdbyname <>  s.createdbyname
												--	OR t.createdbyyominame <>  s.createdbyyominame
												--	OR t.createdon <>  s.createdon
												--	OR t.createdonbehalfby <>  s.createdonbehalfby
												--	OR t.createdonbehalfbyname <>  s.createdonbehalfbyname
												--	OR t.createdonbehalfbyyominame <>  s.createdonbehalfbyyominame
												--	OR t.importsequencenumber <>  s.importsequencenumber
												--	OR t.modifiedby <>  s.modifiedby
												--	OR t.modifiedbyname <>  s.modifiedbyname
												--	OR t.modifiedbyyominame <>  s.modifiedbyyominame
												--	OR t.modifiedon <>  s.modifiedon
												--	OR t.modifiedonbehalfby <>  s.modifiedonbehalfby
												--	OR t.modifiedonbehalfbyname <>  s.modifiedonbehalfbyname
												--	OR t.modifiedonbehalfbyyominame <>  s.modifiedonbehalfbyyominame
												--	OR t.new_accountid <>  s.new_accountid
												--	OR t.new_accountidname <>  s.new_accountidname
												--	OR t.new_accountidyominame <>  s.new_accountidyominame
												--	OR t.new_affiliategroup <>  s.new_affiliategroup
												--	OR t.new_affiliategroupname <>  s.new_affiliategroupname
												--	OR t.new_affiliateid <>  s.new_affiliateid
												--	OR t.new_affiliationend <>  s.new_affiliationend
												--	OR t.new_affiliationstart <>  s.new_affiliationstart
												--	OR t.new_name <>  s.new_name
												--	OR t.new_newaffiliation <>  s.new_newaffiliation
												--	OR t.new_reason <>  s.new_reason
												--	OR t.organizationid <>  s.organizationid
												--	OR t.organizationidname <>  s.organizationidname
												--	OR t.overriddencreatedon <>  s.overriddencreatedon
												--	OR t.statecode <>  s.statecode
												--	OR t.statecodename <>  s.statecodename
												--	OR t.statuscode <>  s.statuscode
												--	OR t.statuscodename <>  s.statuscodename
												--	OR t.timezoneruleversionnumber <>  s.timezoneruleversionnumber
												--	OR t.utcconversiontimezonecode <>  s.utcconversiontimezonecode
												--	)												
												
													

	WHEN MATCHED THEN
	UPDATE
	SET createdby= s.createdby
	, createdbyname= s.createdbyname
	, createdbyyominame= s.createdbyyominame
	, createdon= s.createdon
	, createdonbehalfby= s.createdonbehalfby
	, createdonbehalfbyname= s.createdonbehalfbyname
	, createdonbehalfbyyominame= s.createdonbehalfbyyominame
	, importsequencenumber= s.importsequencenumber
	, modifiedby= s.modifiedby
	, modifiedbyname= s.modifiedbyname
	, modifiedbyyominame= s.modifiedbyyominame
	, modifiedon= s.modifiedon
	, modifiedonbehalfby= s.modifiedonbehalfby
	, modifiedonbehalfbyname= s.modifiedonbehalfbyname
	, modifiedonbehalfbyyominame= s.modifiedonbehalfbyyominame
	, new_accountid= s.new_accountid
	, new_accountidname= s.new_accountidname
	, new_accountidyominame= s.new_accountidyominame
	, new_affiliategroup= s.new_affiliategroup
	, new_affiliategroupname= s.new_affiliategroupname
	, new_affiliateid= s.new_affiliateid
	, new_affiliationend= s.new_affiliationend
	, new_affiliationstart= s.new_affiliationstart
	, new_name= s.new_name
	, new_newaffiliation= s.new_newaffiliation
	, new_reason= s.new_reason
	, organizationid= s.organizationid
	, organizationidname= s.organizationidname
	, overriddencreatedon= s.overriddencreatedon
	, statecode= s.statecode
	, statecodename= s.statecodename
	, statuscode= s.statuscode
	, statuscodename= s.statuscodename
	, timezoneruleversionnumber= s.timezoneruleversionnumber
	, utcconversiontimezonecode= s.utcconversiontimezonecode
	, versionnumber= s.versionnumber

	WHEN NOT MATCHED THEN
	INSERT (createdby, createdbyname, createdbyyominame, createdon, createdonbehalfby, createdonbehalfbyname, createdonbehalfbyyominame, importsequencenumber, modifiedby, modifiedbyname, modifiedbyyominame, modifiedon, modifiedonbehalfby, modifiedonbehalfbyname, modifiedonbehalfbyyominame, new_accountid, new_accountidname, new_accountidyominame, new_affiliategroup, new_affiliategroupname, new_affiliateid, new_affiliationend, new_affiliationstart, new_name, new_newaffiliation, new_reason, organizationid, organizationidname, overriddencreatedon, statecode, statecodename, statuscode, statuscodename, timezoneruleversionnumber, utcconversiontimezonecode, versionnumber, DateKey)
	VALUES(s.createdby, s.createdbyname, s.createdbyyominame, s.createdon, s.createdonbehalfby, s.createdonbehalfbyname, s.createdonbehalfbyyominame, s.importsequencenumber, s.modifiedby, s.modifiedbyname, s.modifiedbyyominame, s.modifiedon, s.modifiedonbehalfby, s.modifiedonbehalfbyname, s.modifiedonbehalfbyyominame, s.new_accountid, s.new_accountidname, s.new_accountidyominame, s.new_affiliategroup, s.new_affiliategroupname, s.new_affiliateid, s.new_affiliationend, new_affiliationstart, s.new_name, s.new_newaffiliation, s.new_reason, s.organizationid, s.organizationidname, s.overriddencreatedon, s.statecode, s.statecodename, s.statuscode, s.statuscodename, s.timezoneruleversionnumber, s.utcconversiontimezonecode, s.versionnumber, s.DateKey)
	;

END


GO
