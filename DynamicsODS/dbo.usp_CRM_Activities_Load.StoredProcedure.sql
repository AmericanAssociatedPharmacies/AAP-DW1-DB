USE [DynamicsODS]
GO
/****** Object:  StoredProcedure [dbo].[usp_CRM_Activities_Load]    Script Date: 12/22/2020 6:59:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[usp_CRM_Activities_Load]

AS

SET NOCOUNT ON;


BEGIN
BEGIN TRY


	MERGE [dbo].[CRM_Activities] AS t
	USING dbo.vwCRMActivities AS s
								ON s.[activityid] = t.[activityid]

	WHEN MATCHED THEN
	UPDATE 
	SET activitytypecode = s.activitytypecode
	, activitytypecodename = s.activitytypecodename
	, actualdurationminutes = s.actualdurationminutes
	, actualend = s.actualend
	, actualstart = s.actualstart
	, community = s.community
	, communityname = s.communityname
	, createdby = s.createdby
	, createdbyname = s.createdbyname
	, createdbyyominame = s.createdbyyominame
	, createdon = s.createdon
	, createdonbehalfby = s.createdonbehalfby
	, createdonbehalfbyname = s.createdonbehalfbyname
	, createdonbehalfbyyominame = s.createdonbehalfbyyominame
	, deliverylastattemptedon = s.deliverylastattemptedon
	, deliveryprioritycode = s.deliveryprioritycode
	, deliveryprioritycodename = s.deliveryprioritycodename
	, description = s.description
	, exchangeitemid = s.exchangeitemid
	, exchangerate = s.exchangerate
	, exchangeweblink = s.exchangeweblink
	, instancetypecode = s.instancetypecode
	, instancetypecodename = s.instancetypecodename
	, isbilled = s.isbilled
	, isbilledname = s.isbilledname
	, ismapiprivate = s.ismapiprivate
	, ismapiprivatename = s.ismapiprivatename
	, isregularactivity = s.isregularactivity
	, isregularactivityname = s.isregularactivityname
	, isworkflowcreated = s.isworkflowcreated
	, isworkflowcreatedname = s.isworkflowcreatedname
	, lastonholdtime = s.lastonholdtime
	, leftvoicemail = s.leftvoicemail
	, leftvoicemailname = s.leftvoicemailname
	, modifiedby = s.modifiedby
	, modifiedbyname = s.modifiedbyname
	, modifiedbyyominame = s.modifiedbyyominame
	, modifiedon = s.modifiedon
	, modifiedonbehalfby = s.modifiedonbehalfby
	, modifiedonbehalfbyname = s.modifiedonbehalfbyname
	, modifiedonbehalfbyyominame = s.modifiedonbehalfbyyominame
	, onholdtime = s.onholdtime
	, ownerid = s.ownerid
	, owneridname = s.owneridname
	, owneridtype = s.owneridtype
	, owneridyominame = s.owneridyominame
	, owningbusinessunit = s.owningbusinessunit
	, owningteam = s.owningteam
	, owninguser = s.owninguser
	, postponeactivityprocessinguntil = s.postponeactivityprocessinguntil
	, prioritycode = s.prioritycode
	, prioritycodename = s.prioritycodename
	, processid = s.processid
	, regardingobjectid = s.regardingobjectid
	, regardingobjectidname = s.regardingobjectidname
	, regardingobjectidyominame = s.regardingobjectidyominame
	, regardingobjecttypecode = s.regardingobjecttypecode
	, scheduleddurationminutes = s.scheduleddurationminutes
	, scheduledend = s.scheduledend
	, scheduledstart = s.scheduledstart
	, sendermailboxid = s.sendermailboxid
	, sendermailboxidname = s.sendermailboxidname
	, senton = s.senton
	, seriesid = s.seriesid
	, serviceid = s.serviceid
	, serviceidname = s.serviceidname
	, slaid = s.slaid
	, slainvokedid = s.slainvokedid
	, slainvokedidname = s.slainvokedidname
	, slaname = s.slaname
	, sortdate = s.sortdate
	, stageid = s.stageid
	, statecode = s.statecode
	, statecodename = s.statecodename
	, statuscode = s.statuscode
	, statuscodename = s.statuscodename
	, subject = s.subject
	, timezoneruleversionnumber = s.timezoneruleversionnumber
	, transactioncurrencyid = s.transactioncurrencyid
	, transactioncurrencyidname = s.transactioncurrencyidname
	, traversedpath = s.traversedpath
	, utcconversiontimezonecode = s.utcconversiontimezonecode
	, versionnumber = s.versionnumber


	WHEN NOT MATCHED THEN

	INSERT(activityid, activitytypecode, activitytypecodename, actualdurationminutes, actualend, actualstart, community, communityname, createdby, createdbyname, createdbyyominame
			, createdon, createdonbehalfby, createdonbehalfbyname, createdonbehalfbyyominame, deliverylastattemptedon, deliveryprioritycode, deliveryprioritycodename, description
			, exchangeitemid, exchangerate, exchangeweblink, instancetypecode, instancetypecodename, isbilled, isbilledname, ismapiprivate, ismapiprivatename, isregularactivity
			, isregularactivityname, isworkflowcreated, isworkflowcreatedname, lastonholdtime, leftvoicemail, leftvoicemailname, modifiedby, modifiedbyname, modifiedbyyominame
			, modifiedon, modifiedonbehalfby, modifiedonbehalfbyname, modifiedonbehalfbyyominame, onholdtime, ownerid, owneridname, owneridtype, owneridyominame, owningbusinessunit
			, owningteam, owninguser, postponeactivityprocessinguntil, prioritycode, prioritycodename, processid, regardingobjectid, regardingobjectidname, regardingobjectidyominame
			, regardingobjecttypecode, scheduleddurationminutes, scheduledend, scheduledstart, sendermailboxid, sendermailboxidname, senton, seriesid, serviceid, serviceidname
			, slaid, slainvokedid, slainvokedidname, slaname, sortdate, stageid, statecode, statecodename, statuscode, statuscodename, subject, timezoneruleversionnumber
			, transactioncurrencyid, transactioncurrencyidname, traversedpath, utcconversiontimezonecode, versionnumber)
	VALUES(activityid,  s.activitytypecode,  s.activitytypecodename,  s.actualdurationminutes,  s.actualend,  s.actualstart,  s.community,  s.communityname,  s.createdby,  s.createdbyname,  s.createdbyyominame
			,  s.createdon,  s.createdonbehalfby,  s.createdonbehalfbyname,  s.createdonbehalfbyyominame,  s.deliverylastattemptedon,  s.deliveryprioritycode,  s.deliveryprioritycodename,  s.description
			,  s.exchangeitemid,  s.exchangerate,  s.exchangeweblink,  s.instancetypecode,  s.instancetypecodename,  s.isbilled,  s.isbilledname,  s.ismapiprivate,  s.ismapiprivatename,  s.isregularactivity
			,  s.isregularactivityname,  s.isworkflowcreated,  s.isworkflowcreatedname,  s.lastonholdtime,  s.leftvoicemail,  s.leftvoicemailname,  s.modifiedby,  s.modifiedbyname,  s.modifiedbyyominame
			,  s.modifiedon,  s.modifiedonbehalfby,  s.modifiedonbehalfbyname,  s.modifiedonbehalfbyyominame,  s.onholdtime,  s.ownerid,  s.owneridname,  s.owneridtype,  s.owneridyominame,  s.owningbusinessunit
			,  s.owningteam,  s.owninguser,  s.postponeactivityprocessinguntil,  s.prioritycode,  s.prioritycodename,  s.processid,  s.regardingobjectid,  s.regardingobjectidname,  s.regardingobjectidyominame
			,  s.regardingobjecttypecode,  s.scheduleddurationminutes,  s.scheduledend,  s.scheduledstart,  s.sendermailboxid,  s.sendermailboxidname,  s.senton,  s.seriesid,  s.serviceid,  s.serviceidname
			,  s.slaid,  s.slainvokedid,  s.slainvokedidname,  s.slaname,  s.sortdate,  s.stageid,  s.statecode,  s.statecodename,  s.statuscode,  s.statuscodename,  s.subject,  s.timezoneruleversionnumber
			,  s.transactioncurrencyid,  s.transactioncurrencyidname,  s.traversedpath,  s.utcconversiontimezonecode,  s.versionnumber
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
