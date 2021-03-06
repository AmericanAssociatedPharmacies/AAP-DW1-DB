USE [DynamicsODS]
GO
/****** Object:  StoredProcedure [dbo].[usp_CRM_ProgramEntity_Load]    Script Date: 12/22/2020 6:59:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_CRM_ProgramEntity_Load]

AS

SET NOCOUNT ON;

BEGIN
BEGIN TRY


		MERGE [dbo].[CRM_ProgramEntity] AS t
		USING ODSIntake.[Staging].[CRM_ProgramEntity] AS s ON s.new_programid = t.new_programid


		WHEN MATCHED THEN
		UPDATE
		SET createdby = s.createdby
		, createdbyname = s.createdbyname
		, createdbyyominame = s.createdbyyominame
		, createdon = s.createdon
		, createdonbehalfby = s.createdonbehalfby
		, createdonbehalfbyname = s.createdonbehalfbyname
		, createdonbehalfbyyominame = s.createdonbehalfbyyominame
		, importsequencenumber = s.importsequencenumber
		, modifiedby = s.modifiedby
		, modifiedbyname = s.modifiedbyname
		, modifiedbyyominame = s.modifiedbyyominame
		, modifiedon = s.modifiedon
		, modifiedonbehalfby = s.modifiedonbehalfby
		, modifiedonbehalfbyname = s.modifiedonbehalfbyname
		, modifiedonbehalfbyyominame = s.modifiedonbehalfbyyominame
		, new_aap_account = s.new_aap_account
		, new_aap_applicationreceived = s.new_aap_applicationreceived
		, new_aap_authorizedsignature = s.new_aap_authorizedsignature
		, new_aap_feedate = s.new_aap_feedate
		, new_aap_feepaid = s.new_aap_feepaid
		, new_aap_feepaidname = s.new_aap_feepaidname
		, new_aap_iatv = s.new_aap_iatv
		, new_aap_industrysupport = s.new_aap_industrysupport
		, new_aap_industrysupportname = s.new_aap_industrysupportname
		, new_aap_membershipowner = s.new_aap_membershipowner
		, new_aap_ownertype = s.new_aap_ownertype
		, new_aap_ownertypename = s.new_aap_ownertypename
		, new_aap_status_global = s.new_aap_status_global
		, new_aap_status_globalname = s.new_aap_status_globalname
		, new_aap_termnotice = s.new_aap_termnotice
		, new_accountid = s.new_accountid
		, new_accountidname = s.new_accountidname
		, new_accountidyominame = s.new_accountidyominame
		, new_activation = s.new_activation
		, new_activationstring = s.new_activationstring
		, new_api_account = s.new_api_account
		, new_api_accounthistorical = s.new_api_accounthistorical
		, new_api_alert_global = s.new_api_alert_global
		, new_api_alert_globalname = s.new_api_alert_globalname
		, new_api_annualprofile = s.new_api_annualprofile
		, new_api_applicationapproved = s.new_api_applicationapproved
		, new_api_applicationcredit = s.new_api_applicationcredit
		, new_api_applicationreceived = s.new_api_applicationreceived
		, new_api_applicationstatus = s.new_api_applicationstatus
		, new_api_applicationstatusname = s.new_api_applicationstatusname
		, new_api_diversionce = s.new_api_diversionce
		, new_api_inactive = s.new_api_inactive
		, new_api_originalactivation = s.new_api_originalactivation
		, new_api_pmidtransition = s.new_api_pmidtransition
		, new_api_questionnairereceived = s.new_api_questionnairereceived
		, new_api_questionnairestatus = s.new_api_questionnairestatus
		, new_api_questionnairestatusname = s.new_api_questionnairestatusname
		, new_api_reactivations = s.new_api_reactivations
		, new_api_status_global = s.new_api_status_global
		, new_api_status_globalname = s.new_api_status_globalname
		, new_api_triggerglobal = s.new_api_triggerglobal
		, new_api_triggerglobalname = s.new_api_triggerglobalname
		, new_api_vendor = s.new_api_vendor
		, new_arete_network_global = s.new_arete_network_global
		, new_arete_network_globalname = s.new_arete_network_globalname
		, new_arete_status_global = s.new_arete_status_global
		, new_arete_status_globalname = s.new_arete_status_globalname
		, new_documentscomplete = s.new_documentscomplete
		, new_photoscomplete = s.new_photoscomplete
		, new_pmid_lookup = s.new_pmid_lookup
		, new_profitamp_applicationreceived = s.new_profitamp_applicationreceived
		, new_profitamp_fee = s.new_profitamp_fee
		, new_profitamp_feename = s.new_profitamp_feename
		, new_profitamp_invoice = s.new_profitamp_invoice
		, new_profitamp_invoicename = s.new_profitamp_invoicename
		, new_profitamp_level_global = s.new_profitamp_level_global
		, new_profitamp_level_globalname = s.new_profitamp_level_globalname
		, new_profitamp_renewal = s.new_profitamp_renewal
		, new_profitamp_renewalname = s.new_profitamp_renewalname
		, new_profitamp_servicestart = s.new_profitamp_servicestart
		, new_profitamp_status_global = s.new_profitamp_status_global
		, new_profitamp_status_globalname = s.new_profitamp_status_globalname
		, new_profitamp_termnotice = s.new_profitamp_termnotice
		, new_program = s.new_program
		, new_programname = s.new_programname
		, new_programstatus = s.new_programstatus
		, new_programstatusname = s.new_programstatusname
		, new_programstatusstring = s.new_programstatusstring
		, new_programtypeglobal = s.new_programtypeglobal
		, new_programtypeglobalname = s.new_programtypeglobalname
		, new_programtypevalue = s.new_programtypevalue
		, new_resignationreason_global = s.new_resignationreason_global
		, new_resignationreason_globalname = s.new_resignationreason_globalname
		, new_termination = s.new_termination
		, organizationid = s.organizationid
		, organizationidname = s.organizationidname
		, overriddencreatedon = s.overriddencreatedon
		, statecode = s.statecode
		, statecodename = s.statecodename
		, statuscode = s.statuscode
		, statuscodename = s.statuscodename
		, timezoneruleversionnumber = s.timezoneruleversionnumber
		, utcconversiontimezonecode = s.utcconversiontimezonecode
		, versionnumber = s.versionnumber


		WHEN NOT MATCHED THEN

		INSERT(createdby, createdbyname, createdbyyominame, createdon, createdonbehalfby, createdonbehalfbyname, createdonbehalfbyyominame, importsequencenumber, modifiedby
				, modifiedbyname, modifiedbyyominame, modifiedon, modifiedonbehalfby, modifiedonbehalfbyname, modifiedonbehalfbyyominame, new_aap_account
				, new_aap_applicationreceived, new_aap_authorizedsignature, new_aap_feedate, new_aap_feepaid, new_aap_feepaidname, new_aap_iatv, new_aap_industrysupport
				, new_aap_industrysupportname, new_aap_membershipowner, new_aap_ownertype, new_aap_ownertypename, new_aap_status_global, new_aap_status_globalname
				, new_aap_termnotice, new_accountid, new_accountidname, new_accountidyominame, new_activation, new_activationstring, new_api_account, new_api_accounthistorical
				, new_api_alert_global, new_api_alert_globalname, new_api_annualprofile, new_api_applicationapproved, new_api_applicationcredit, new_api_applicationreceived
				, new_api_applicationstatus, new_api_applicationstatusname, new_api_diversionce, new_api_inactive, new_api_originalactivation, new_api_pmidtransition
				, new_api_questionnairereceived, new_api_questionnairestatus, new_api_questionnairestatusname, new_api_reactivations, new_api_status_global
				, new_api_status_globalname, new_api_triggerglobal, new_api_triggerglobalname, new_api_vendor, new_arete_network_global, new_arete_network_globalname
				, new_arete_status_global, new_arete_status_globalname, new_documentscomplete, new_photoscomplete, new_pmid_lookup, new_profitamp_applicationreceived
				, new_profitamp_fee, new_profitamp_feename, new_profitamp_invoice, new_profitamp_invoicename, new_profitamp_level_global, new_profitamp_level_globalname
				, new_profitamp_renewal, new_profitamp_renewalname, new_profitamp_servicestart, new_profitamp_status_global, new_profitamp_status_globalname
				, new_profitamp_termnotice, new_program, new_programid, new_programname, new_programstatus, new_programstatusname, new_programstatusstring
				, new_programtypeglobal, new_programtypeglobalname, new_programtypevalue, new_resignationreason_global, new_resignationreason_globalname
				, new_termination, organizationid, organizationidname, overriddencreatedon, statecode, statecodename, statuscode, statuscodename
				, timezoneruleversionnumber, utcconversiontimezonecode, versionnumber
				)
		VALUES(createdby, s.createdbyname, s.createdbyyominame, s.createdon, s.createdonbehalfby, s.createdonbehalfbyname, s.createdonbehalfbyyominame, s.importsequencenumber, s.modifiedby
				, s.modifiedbyname, s.modifiedbyyominame, s.modifiedon, s.modifiedonbehalfby, s.modifiedonbehalfbyname, s.modifiedonbehalfbyyominame, s.new_aap_account
				, s.new_aap_applicationreceived, s.new_aap_authorizedsignature, s.new_aap_feedate, s.new_aap_feepaid, s.new_aap_feepaidname, s.new_aap_iatv, s.new_aap_industrysupport
				, s.new_aap_industrysupportname, s.new_aap_membershipowner, s.new_aap_ownertype, s.new_aap_ownertypename, s.new_aap_status_global, s.new_aap_status_globalname
				, s.new_aap_termnotice, s.new_accountid, s.new_accountidname, s.new_accountidyominame, s.new_activation, s.new_activationstring, s.new_api_account, s.new_api_accounthistorical
				, s.new_api_alert_global, s.new_api_alert_globalname, s.new_api_annualprofile, s.new_api_applicationapproved, s.new_api_applicationcredit, s.new_api_applicationreceived
				, s.new_api_applicationstatus, s.new_api_applicationstatusname, s.new_api_diversionce, s.new_api_inactive, s.new_api_originalactivation, s.new_api_pmidtransition
				, s.new_api_questionnairereceived, s.new_api_questionnairestatus, s.new_api_questionnairestatusname, s.new_api_reactivations, s.new_api_status_global
				, s.new_api_status_globalname, s.new_api_triggerglobal, s.new_api_triggerglobalname, s.new_api_vendor, s.new_arete_network_global, s.new_arete_network_globalname
				, s.new_arete_status_global, s.new_arete_status_globalname, s.new_documentscomplete, s.new_photoscomplete, s.new_pmid_lookup, s.new_profitamp_applicationreceived
				, s.new_profitamp_fee, s.new_profitamp_feename, s.new_profitamp_invoice, s.new_profitamp_invoicename, s.new_profitamp_level_global, s.new_profitamp_level_globalname
				, s.new_profitamp_renewal, s.new_profitamp_renewalname, s.new_profitamp_servicestart, s.new_profitamp_status_global, s.new_profitamp_status_globalname
				, s.new_profitamp_termnotice, s.new_program, s.new_programid, s.new_programname, s.new_programstatus, s.new_programstatusname, s.new_programstatusstring
				, s.new_programtypeglobal, s.new_programtypeglobalname, s.new_programtypevalue, s.new_resignationreason_global, s.new_resignationreason_globalname
				, s.new_termination, s.organizationid, s.organizationidname, s.overriddencreatedon, s.statecode, s.statecodename, s.statuscode, s.statuscodename
				, s.timezoneruleversionnumber, s.utcconversiontimezonecode, s.versionnumber
				);

END TRY
BEGIN CATCH

	
	DECLARE @ErrorMessage NVARCHAR(4000)
        , @ErrorNumber INT
        , @ErrorSeverity INT
        , @ErrorState INT
        , @ErrorLine INT
        , @ErrorProcedure NVARCHAR(200)

		SELECT 
        @ErrorNumber = ERROR_NUMBER()
        , @ErrorSeverity = ERROR_SEVERITY()
        , @ErrorState = ERROR_STATE()
        , @ErrorLine = ERROR_LINE()
        , @ErrorProcedure = ISNULL(ERROR_PROCEDURE(), '-')
		, @ErrorMessage = ERROR_MESSAGE();

		RAISERROR 
        (@ErrorMessage 
        , @ErrorSeverity, 1               
        , @ErrorNumber    -- parameter: original error number.
        , @ErrorSeverity  -- parameter: original error severity.
        , @ErrorState     -- parameter: original error state.
        , @ErrorProcedure -- parameter: original error procedure name.
        , @ErrorLine       -- parameter: original error line number.
        );

END CATCH




END
								
GO
