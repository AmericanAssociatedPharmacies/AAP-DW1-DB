USE [DynamicsODS]
GO
/****** Object:  StoredProcedure [dbo].[usp_Dynamics_Task_Load]    Script Date: 12/22/2020 6:59:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[usp_Dynamics_Task_Load]

AS

SET NOCOUNT ON;

BEGIN

	SELECT DateKey, activityadditionalparams, activityid, activitytypecode, activitytypecodename, actualdurationminutes, actualend
	, actualstart, category, createdby, createdbyname, createdbyyominame, createdon, createdonbehalfby, createdonbehalfbyname, createdonbehalfbyyominame
	, crmtaskassigneduniqueid, description, exchangerate, importsequencenumber, isbilled, isbilledname, isregularactivity, isregularactivityname
	, isworkflowcreated, isworkflowcreatedname, lastonholdtime, modifiedby, modifiedbyname, modifiedbyyominame, modifiedon, modifiedonbehalfby
	, modifiedonbehalfbyname, modifiedonbehalfbyyominame, onholdtime, overriddencreatedon, ownerid, owneridname, owneridtype, owneridyominame
	, owningbusinessunit, owningteam, owninguser, percentcomplete, prioritycode, prioritycodename, processid, regardingobjectid, regardingobjectidname
	, regardingobjectidyominame, regardingobjecttypecode, scheduleddurationminutes, scheduledend, scheduledstart, serviceid, slaid, slainvokedid
	, slainvokedidname, slaname, sortdate, stageid, statecode, statecodename, statuscode, statuscodename, subcategory, subject, timezoneruleversionnumber
	, transactioncurrencyid, transactioncurrencyidname, traversedpath, utcconversiontimezonecode, versionnumber
	FROM(SELECT DateKey, CONVERT(NVARCHAR(4000), activityadditionalparams) AS activityadditionalparams, activityid, activitytypecode, activitytypecodename, actualdurationminutes, actualend
		, actualstart, category, createdby, createdbyname, createdbyyominame, createdon, createdonbehalfby, createdonbehalfbyname, createdonbehalfbyyominame
		, crmtaskassigneduniqueid, CONVERT(NVARCHAR(4000), description) AS description, exchangerate, importsequencenumber, isbilled, isbilledname, isregularactivity, isregularactivityname
		, isworkflowcreated, isworkflowcreatedname, lastonholdtime, modifiedby, modifiedbyname, modifiedbyyominame, modifiedon, modifiedonbehalfby
		, modifiedonbehalfbyname, modifiedonbehalfbyyominame, onholdtime, overriddencreatedon, ownerid, owneridname, owneridtype, owneridyominame
		, owningbusinessunit, owningteam, owninguser, percentcomplete, prioritycode, prioritycodename, processid, regardingobjectid, regardingobjectidname
		, regardingobjectidyominame, regardingobjecttypecode, scheduleddurationminutes, scheduledend, scheduledstart, serviceid, slaid, slainvokedid
		, slainvokedidname, slaname, sortdate, stageid, statecode, statecodename, statuscode, statuscodename, subcategory, subject, timezoneruleversionnumber
		, transactioncurrencyid, transactioncurrencyidname, traversedpath, utcconversiontimezonecode, versionnumber
		FROM ODSIntake.Staging.CRM_Task AS a
		WHERE NOT EXISTS(SELECT 1
							FROM dbo.CRM_Task AS B (NOLOCK)
							WHERE a.activityid = b.activityid
							)
		) AS dt


END

GO
