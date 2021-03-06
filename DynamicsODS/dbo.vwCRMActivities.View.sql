USE [DynamicsODS]
GO
/****** Object:  View [dbo].[vwCRMActivities]    Script Date: 12/22/2020 6:59:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vwCRMActivities]

AS


SELECT DISTINCT activityadditionalparams, activityid, activitytypecode, activitytypecodename, actualdurationminutes, actualend, actualstart, allparties, community, communityname, createdby, createdbyname, createdbyyominame, createdon, createdonbehalfby, createdonbehalfbyname, createdonbehalfbyyominame, deliverylastattemptedon, deliveryprioritycode, deliveryprioritycodename, description, exchangeitemid, exchangerate, exchangeweblink, instancetypecode, instancetypecodename, isbilled, isbilledname, ismapiprivate, ismapiprivatename, isregularactivity, isregularactivityname, isworkflowcreated, isworkflowcreatedname, lastonholdtime, leftvoicemail, leftvoicemailname, modifiedby, modifiedbyname, modifiedbyyominame, modifiedon, modifiedonbehalfby, modifiedonbehalfbyname, modifiedonbehalfbyyominame, onholdtime, ownerid, owneridname, owneridtype, owneridyominame, owningbusinessunit, owningteam, owninguser, postponeactivityprocessinguntil, prioritycode, prioritycodename, processid, regardingobjectid, regardingobjectidname, regardingobjectidyominame, regardingobjecttypecode, scheduleddurationminutes, scheduledend, scheduledstart, sendermailboxid, sendermailboxidname, senton, seriesid, serviceid, serviceidname, slaid, slainvokedid, slainvokedidname, slaname, sortdate, stageid, statecode, statecodename, statuscode, statuscodename, subject, timezoneruleversionnumber, transactioncurrencyid, transactioncurrencyidname, traversedpath, utcconversiontimezonecode, versionnumber
FROM ODSIntake.[Staging].[CRM_Activities]
GO
