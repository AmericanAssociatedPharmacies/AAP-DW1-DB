USE [NCPDPODS]
GO
/****** Object:  View [Staging].[vw_NCPDP_RelationshipDemographicInformation]    Script Date: 12/22/2020 7:25:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [Staging].[vw_NCPDP_RelationshipDemographicInformation]

AS

SELECT SUBSTRING(C1,1,3) AS RelationshipID
, SUBSTRING(C1,4,2) AS RelationshipType
, NULLIF(SUBSTRING(C1,6,35), '') AS Name
, NULLIF(SUBSTRING(C1,41,55), '') AS Address1
, NULLIF(SUBSTRING(C1,96,55), '') AS Address2
, NULLIF(SUBSTRING(C1,151,30), '') AS City
, NULLIF(SUBSTRING(C1,181,2), '') AS StateCode
, NULLIF(SUBSTRING(C1,183,9), '') AS ZipCode
, NULLIF(SUBSTRING(C1,192,10), '') AS PhoneNumber
, NULLIF(SUBSTRING(C1,202,5), '') AS Extension
, NULLIF(SUBSTRING(C1,207,10), '') AS FAXNumber
, NULLIF(SUBSTRING(C1,217,10), '') AS RelationshipNPI
, NULLIF(SUBSTRING(C1,227,15), '') AS RelationShipFederalTaxID
, NULLIF(SUBSTRING(C1,242,30), '') AS ContactName
, NULLIF(SUBSTRING(C1,272,30), '') AS ContactTitle
, NULLIF(SUBSTRING(C1,302,50), '') AS EmailAddress
, NULLIF(SUBSTRING(C1,352,30), '') AS ContractualContactName
, NULLIF(SUBSTRING(C1,382,30), '') AS ContractualContactTitle
, NULLIF(SUBSTRING(C1,412,50), '') AS ContractualContactEmail
, NULLIF(SUBSTRING(C1,462,30), '') AS OperationalContactName
, NULLIF(SUBSTRING(C1,492,30), '') AS OperationalContactTitle
, NULLIF(SUBSTRING(C1,522,50), '') AS OperationalContactEmail
, NULLIF(SUBSTRING(C1,572,30), '') AS TechnicalContactName
, NULLIF(SUBSTRING(C1,602,30), '') AS TechnicalContactTitle
, NULLIF(SUBSTRING(C1,632,50), '') AS TechnicalContactEmail
, NULLIF(SUBSTRING(C1,682,30), '') AS AuditContactName
, NULLIF(SUBSTRING(C1,712,30), '') AS AuditContactTitle
, NULLIF(SUBSTRING(C1,742,50), '') AS AuditContactEmail
, NULLIF(SUBSTRING(C1,792,6), '') AS ParentOrganizationID
, NULLIF(SUBSTRING(C1,798,8), '') AS EffectiveFromDate
, NULLIF(SUBSTRING(C1,806,8), '') AS DeleteDate
FROM(SELECT MIN(RowID) AS MinRowID
	, MAX(RowID) AS MaxRowID
	FROM ODSIntake.[Staging].[NCPDP_RelationshipDemographicInformation]
	) AS dt
INNER JOIN ODSIntake.[Staging].[NCPDP_RelationshipDemographicInformation] AS s ON s.RowID > dt.MinRowID
													AND s.RowID < dt.MaxRowID
GO
