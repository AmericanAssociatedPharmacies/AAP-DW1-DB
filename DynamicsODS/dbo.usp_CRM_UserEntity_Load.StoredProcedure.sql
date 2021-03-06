USE [DynamicsODS]
GO
/****** Object:  StoredProcedure [dbo].[usp_CRM_UserEntity_Load]    Script Date: 12/22/2020 6:59:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_CRM_UserEntity_Load]

AS

SET NOCOUNT ON;

BEGIN
BEGIN TRY

	MERGE [dbo].[CRM_UserEntity] AS t
	USING ODSIntake.[Staging].[CRM_UserEntity] AS s ON t.systemuserid = s.systemuserid

	WHEN MATCHED THEN
	UPDATE 
	SET accessmode = s.accessmode
	, accessmodename = s.accessmodename
	, address1_addressid = s.address1_addressid
	, address1_addresstypecode = s.address1_addresstypecode
	, address1_addresstypecodename = s.address1_addresstypecodename
	, address1_city = s.address1_city
	, address1_country = s.address1_country
	, address1_county = s.address1_county
	, address1_fax = s.address1_fax
	, address1_latitude = s.address1_latitude
	, address1_line1 = s.address1_line1
	, address1_line2 = s.address1_line2
	, address1_line3 = s.address1_line3
	, address1_longitude = s.address1_longitude
	, address1_name = s.address1_name
	, address1_postalcode = s.address1_postalcode
	, address1_postofficebox = s.address1_postofficebox
	, address1_shippingmethodcode = s.address1_shippingmethodcode
	, address1_shippingmethodcodename = s.address1_shippingmethodcodename
	, address1_stateorprovince = s.address1_stateorprovince
	, address1_telephone1 = s.address1_telephone1
	, address1_telephone2 = s.address1_telephone2
	, address1_telephone3 = s.address1_telephone3
	, address1_upszone = s.address1_upszone
	, address1_utcoffset = s.address1_utcoffset
	, address2_addressid = s.address2_addressid
	, address2_addresstypecode = s.address2_addresstypecode
	, address2_addresstypecodename = s.address2_addresstypecodename
	, address2_city = s.address2_city
	, address2_country = s.address2_country
	, address2_county = s.address2_county
	, address2_fax = s.address2_fax
	, address2_latitude = s.address2_latitude
	, address2_line1 = s.address2_line1
	, address2_line2 = s.address2_line2
	, address2_line3 = s.address2_line3
	, address2_longitude = s.address2_longitude
	, address2_name = s.address2_name
	, address2_postalcode = s.address2_postalcode
	, address2_postofficebox = s.address2_postofficebox
	, address2_shippingmethodcode = s.address2_shippingmethodcode
	, address2_shippingmethodcodename = s.address2_shippingmethodcodename
	, address2_stateorprovince = s.address2_stateorprovince
	, address2_telephone1 = s.address2_telephone1
	, address2_telephone2 = s.address2_telephone2
	, address2_telephone3 = s.address2_telephone3
	, address2_upszone = s.address2_upszone
	, address2_utcoffset = s.address2_utcoffset
	, applicationid = s.applicationid
	, applicationiduri = s.applicationiduri
	, azureactivedirectoryobjectid = s.azureactivedirectoryobjectid
	, businessunitid = s.businessunitid
	, businessunitidname = s.businessunitidname
	, calendarid = s.calendarid
	, caltype = s.caltype
	, caltypename = s.caltypename
	, createdby = s.createdby
	, createdbyname = s.createdbyname
	, createdbyyominame = s.createdbyyominame
	, createdon = s.createdon
	, createdonbehalfby = s.createdonbehalfby
	, createdonbehalfbyname = s.createdonbehalfbyname
	, createdonbehalfbyyominame = s.createdonbehalfbyyominame
	, DateKey = s.DateKey
	, defaultfilterspopulated = s.defaultfilterspopulated
	, defaultmailbox = s.defaultmailbox
	, defaultmailboxname = s.defaultmailboxname
	, defaultodbfoldername = s.defaultodbfoldername
	, disabledreason = s.disabledreason
	, displayinserviceviews = s.displayinserviceviews
	, displayinserviceviewsname = s.displayinserviceviewsname
	, domainname = s.domainname
	, emailrouteraccessapproval = s.emailrouteraccessapproval
	, emailrouteraccessapprovalname = s.emailrouteraccessapprovalname
	, employeeid = s.employeeid
	, exchangerate = s.exchangerate
	, firstname = s.firstname
	, fullname = s.fullname
	, governmentid = s.governmentid
	, homephone = s.homephone
	, importsequencenumber = s.importsequencenumber
	, incomingemaildeliverymethod = s.incomingemaildeliverymethod
	, incomingemaildeliverymethodname = s.incomingemaildeliverymethodname
	, internalemailaddress = s.internalemailaddress
	, invitestatuscode = s.invitestatuscode
	, invitestatuscodename = s.invitestatuscodename
	, isdisabled = s.isdisabled
	, isdisabledname = s.isdisabledname
	, isemailaddressapprovedbyo365admin = s.isemailaddressapprovedbyo365admin
	, isintegrationuser = s.isintegrationuser
	, isintegrationusername = s.isintegrationusername
	, islicensed = s.islicensed
	, issyncwithdirectory = s.issyncwithdirectory
	, jobtitle = s.jobtitle
	, lastname = s.lastname
	, middlename = s.middlename
	, mobilealertemail = s.mobilealertemail
	, mobileofflineprofileid = s.mobileofflineprofileid
	, mobileofflineprofileidname = s.mobileofflineprofileidname
	, mobilephone = s.mobilephone
	, modifiedby = s.modifiedby
	, modifiedbyname = s.modifiedbyname
	, modifiedbyyominame = s.modifiedbyyominame
	, modifiedon = s.modifiedon
	, modifiedonbehalfby = s.modifiedonbehalfby
	, modifiedonbehalfbyname = s.modifiedonbehalfbyname
	, modifiedonbehalfbyyominame = s.modifiedonbehalfbyyominame
	, new_department = s.new_department
	, new_departmentname = s.new_departmentname
	, new_division = s.new_division
	, new_divisionname = s.new_divisionname
	, new_region = s.new_region
	, new_regionname = s.new_regionname
	, new_reportsto = s.new_reportsto
	, new_reportstoname = s.new_reportstoname
	, new_reportstoyominame = s.new_reportstoyominame
	, nickname = s.nickname
	, organizationid = s.organizationid
	, organizationidname = s.organizationidname
	, outgoingemaildeliverymethod = s.outgoingemaildeliverymethod
	, outgoingemaildeliverymethodname = s.outgoingemaildeliverymethodname
	, overriddencreatedon = s.overriddencreatedon
	, parentsystemuserid = s.parentsystemuserid
	, parentsystemuseridname = s.parentsystemuseridname
	, parentsystemuseridyominame = s.parentsystemuseridyominame
	, passporthi = s.passporthi
	, passportlo = s.passportlo
	, personalemailaddress = s.personalemailaddress
	, photourl = s.photourl
	, positionid = s.positionid
	, positionidname = s.positionidname
	, preferredaddresscode = s.preferredaddresscode
	, preferredaddresscodename = s.preferredaddresscodename
	, preferredemailcode = s.preferredemailcode
	, preferredemailcodename = s.preferredemailcodename
	, preferredphonecode = s.preferredphonecode
	, preferredphonecodename = s.preferredphonecodename
	, processid = s.processid
	, queueid = s.queueid
	, queueidname = s.queueidname
	, RowCreatedDate = s.RowCreatedDate
	, RowUpdatedDate = s.RowUpdatedDate
	, salutation = s.salutation
	, setupuser = s.setupuser
	, setupusername = s.setupusername
	, sharepointemailaddress = s.sharepointemailaddress
	, siteid = s.siteid
	, siteidname = s.siteidname
	, skills = s.skills
	, stageid = s.stageid
	, territoryid = s.territoryid
	, territoryidname = s.territoryidname
	, timezoneruleversionnumber = s.timezoneruleversionnumber
	, title = s.title
	, transactioncurrencyid = s.transactioncurrencyid
	, transactioncurrencyidname = s.transactioncurrencyidname
	, traversedpath = s.traversedpath
	, userlicensetype = s.userlicensetype
	, utcconversiontimezonecode = s.utcconversiontimezonecode
	, versionnumber = s.versionnumber
	, windowsliveid = s.windowsliveid
	, yammeremailaddress = s.yammeremailaddress
	, yammeruserid = s.yammeruserid
	, yomifirstname = s.yomifirstname
	, yomifullname = s.yomifullname
	, yomilastname = s.yomilastname
	, yomimiddlename = s.yomimiddlename

	WHEN NOT MATCHED THEN

	INSERT(accessmode, accessmodename, address1_addressid, address1_addresstypecode, address1_addresstypecodename, address1_city, address1_country
			, address1_county, address1_fax, address1_latitude, address1_line1, address1_line2, address1_line3, address1_longitude
			, address1_name, address1_postalcode, address1_postofficebox, address1_shippingmethodcode, address1_shippingmethodcodename
			, address1_stateorprovince, address1_telephone1, address1_telephone2, address1_telephone3, address1_upszone, address1_utcoffset
			, address2_addressid, address2_addresstypecode, address2_addresstypecodename, address2_city, address2_country, address2_county
			, address2_fax, address2_latitude, address2_line1, address2_line2, address2_line3, address2_longitude, address2_name, address2_postalcode
			, address2_postofficebox, address2_shippingmethodcode, address2_shippingmethodcodename, address2_stateorprovince, address2_telephone1
			, address2_telephone2, address2_telephone3, address2_upszone, address2_utcoffset, applicationid, applicationiduri, azureactivedirectoryobjectid
			, businessunitid, businessunitidname, calendarid, caltype, caltypename, createdby, createdbyname, createdbyyominame, createdon, createdonbehalfby
			, createdonbehalfbyname, createdonbehalfbyyominame, defaultfilterspopulated, defaultmailbox, defaultmailboxname, defaultodbfoldername
			, disabledreason, displayinserviceviews, displayinserviceviewsname, domainname, emailrouteraccessapproval, emailrouteraccessapprovalname
			, employeeid, exchangerate, firstname, fullname, governmentid, homephone, importsequencenumber, incomingemaildeliverymethod
			, incomingemaildeliverymethodname, internalemailaddress, invitestatuscode, invitestatuscodename, isdisabled, isdisabledname
			, isemailaddressapprovedbyo365admin, isintegrationuser, isintegrationusername, islicensed, issyncwithdirectory, jobtitle, lastname
			, middlename, mobilealertemail, mobileofflineprofileid, mobileofflineprofileidname, mobilephone, modifiedby, modifiedbyname
			, modifiedbyyominame, modifiedon, modifiedonbehalfby, modifiedonbehalfbyname, modifiedonbehalfbyyominame, new_department, new_departmentname
			, new_division, new_divisionname, new_region, new_regionname, new_reportsto, new_reportstoname, new_reportstoyominame, nickname
			, organizationid, organizationidname, outgoingemaildeliverymethod, outgoingemaildeliverymethodname, overriddencreatedon, parentsystemuserid
			, parentsystemuseridname, parentsystemuseridyominame, passporthi, passportlo, personalemailaddress, photourl, positionid, positionidname
			, preferredaddresscode, preferredaddresscodename, preferredemailcode, preferredemailcodename, preferredphonecode, preferredphonecodename
			, processid, queueid, queueidname, salutation, setupuser, setupusername, sharepointemailaddress, siteid, siteidname, skills, stageid
			, systemuserid, territoryid, territoryidname, timezoneruleversionnumber, title, transactioncurrencyid, transactioncurrencyidname
			, traversedpath, userlicensetype, utcconversiontimezonecode, versionnumber, windowsliveid, yammeremailaddress, yammeruserid, yomifirstname
			, yomifullname, yomilastname, yomimiddlename, DateKey)
	VALUES (s.accessmode, s.accessmodename, s.address1_addressid, s.address1_addresstypecode, s.address1_addresstypecodename, s.address1_city, s.address1_country
			, s.address1_county, s.address1_fax, s.address1_latitude, s.address1_line1, s.address1_line2, s.address1_line3, s.address1_longitude
			, s.address1_name, s.address1_postalcode, s.address1_postofficebox, s.address1_shippingmethodcode, s.address1_shippingmethodcodename
			, s.address1_stateorprovince, s.address1_telephone1, s.address1_telephone2, s.address1_telephone3, s.address1_upszone, s.address1_utcoffset
			, s.address2_addressid, s.address2_addresstypecode, s.address2_addresstypecodename, s.address2_city, s.address2_country, s.address2_county
			, s.address2_fax, s.address2_latitude, s.address2_line1, s.address2_line2, s.address2_line3, s.address2_longitude, s.address2_name, s.address2_postalcode
			, s.address2_postofficebox, s.address2_shippingmethodcode, s.address2_shippingmethodcodename, s.address2_stateorprovince, s.address2_telephone1
			, s.address2_telephone2, s.address2_telephone3, s.address2_upszone, s.address2_utcoffset, s.applicationid, s.applicationiduri, s.azureactivedirectoryobjectid
			, s.businessunitid, s.businessunitidname, s.calendarid, s.caltype, s.caltypename, s.createdby, s.createdbyname, s.createdbyyominame, s.createdon, s.createdonbehalfby
			, s.createdonbehalfbyname, s.createdonbehalfbyyominame, s.defaultfilterspopulated, s.defaultmailbox, s.defaultmailboxname, s.defaultodbfoldername
			, s.disabledreason, s.displayinserviceviews, s.displayinserviceviewsname, s.domainname, s.emailrouteraccessapproval, s.emailrouteraccessapprovalname
			, s.employeeid, s.exchangerate, s.firstname, s.fullname, s.governmentid, s.homephone, s.importsequencenumber, s.incomingemaildeliverymethod
			, s.incomingemaildeliverymethodname, s.internalemailaddress, s.invitestatuscode, s.invitestatuscodename, s.isdisabled, s.isdisabledname
			, s.isemailaddressapprovedbyo365admin, s.isintegrationuser, s.isintegrationusername, s.islicensed, s.issyncwithdirectory, s.jobtitle, s.lastname
			, s.middlename, s.mobilealertemail, s.mobileofflineprofileid, s.mobileofflineprofileidname, s.mobilephone, s.modifiedby, s.modifiedbyname
			, s.modifiedbyyominame, s.modifiedon, s.modifiedonbehalfby, s.modifiedonbehalfbyname, s.modifiedonbehalfbyyominame, s.new_department, s.new_departmentname
			, s.new_division, s.new_divisionname, s.new_region, s.new_regionname, s.new_reportsto, s.new_reportstoname, s.new_reportstoyominame, s.nickname
			, s.organizationid, s.organizationidname, s.outgoingemaildeliverymethod, s.outgoingemaildeliverymethodname, s.overriddencreatedon, s.parentsystemuserid
			, s.parentsystemuseridname, s.parentsystemuseridyominame, s.passporthi, s.passportlo, s.personalemailaddress, s.photourl, s.positionid, s.positionidname
			, s.preferredaddresscode, s.preferredaddresscodename, s.preferredemailcode, s.preferredemailcodename, s.preferredphonecode, s.preferredphonecodename
			, s.processid, s.queueid, s.queueidname, s.salutation, s.setupuser, s.setupusername, s.sharepointemailaddress, s.siteid, s.siteidname, s.skills, s.stageid
			, s.systemuserid, s.territoryid, s.territoryidname, s.timezoneruleversionnumber, s.title, s.transactioncurrencyid, s.transactioncurrencyidname
			, s.traversedpath, s.userlicensetype, s.utcconversiontimezonecode, s.versionnumber, s.windowsliveid, s.yammeremailaddress, s.yammeruserid, s.yomifirstname
			, s.yomifullname, s.yomilastname, s.yomimiddlename, s.DateKey);

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
