USE [NCPDPODS]
GO
/****** Object:  View [Staging].[vw_NCPDP_ParentOrganization]    Script Date: 12/22/2020 7:25:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [Staging].[vw_NCPDP_ParentOrganization]

AS


SELECT SUBSTRING(C1,1,6) AS ParentOrganizationID
, SUBSTRING(C1,7,35) AS ParentOrganizationName
, NULLIF(SUBSTRING(C1,42,55), '') AS Address1
, NULLIF(SUBSTRING(C1,97,55), '') AS Address2
, NULLIF(SUBSTRING(C1,152,30), '') AS City
, NULLIF(SUBSTRING(C1,182,2), '') AS StateCode
, NULLIF(SUBSTRING(C1,184,9), '') AS ZipCode
, NULLIF(SUBSTRING(C1,193,10), '') AS PhoneNumber
, NULLIF(SUBSTRING(C1,203,5), '') AS Extension
, NULLIF(SUBSTRING(C1,208,10), '') AS FAXNumber
, NULLIF(SUBSTRING(C1,218,10), '') AS ParentOrganizationNPI
, NULLIF(SUBSTRING(C1,228,15), '') AS ParentOrganizationFederalTaxID 
, NULLIF(SUBSTRING(C1,243,30), '') AS ContactName
, NULLIF(SUBSTRING(C1,273,30), '') AS ContactTitle
, NULLIF(SUBSTRING(C1,303,50), '') AS EmailAddress
, NULLIF(SUBSTRING(C1,353,8), '') AS DeleteDate
FROM(SELECT MIN(RowID) AS MinRowID
	, MAX(RowID) AS MaxRowID
	FROM ODSIntake.Staging.NCPDP_ParentOrganization
	) AS dt
INNER JOIN ODSIntake.Staging.NCPDP_ParentOrganization AS s ON s.RowID > dt.MinRowID
													AND s.RowID < dt.MaxRowID
GO
