USE [NCPDPODS]
GO
/****** Object:  View [Staging].[vw_NCPDP_FraudWasteandAbuseTrainingAttestation]    Script Date: 12/22/2020 7:25:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [Staging].[vw_NCPDP_FraudWasteandAbuseTrainingAttestation]

AS

SELECT SUBSTRING(C1,1,7) AS NCPDPProviderID
	, SUBSTRING(C1,8,1) AS MedicaidID
	, NULLIF(SUBSTRING(C1,9,1), '') AS FWAattestation
	, NULLIF(SUBSTRING(C1,10,5), '') AS VersionNumber
	, NULLIF(SUBSTRING(C1,15,4), '') AS PlanYear	
	, NULLIF(SUBSTRING(C1,19,1), '') AS Q1
	, NULLIF(SUBSTRING(C1,20,1), '') AS Q2
	, NULLIF(SUBSTRING(C1,21,8), '') AS AccreditationDate
	, NULLIF(SUBSTRING(C1,29,60), '') AS AccreditationOrganization
	, NULLIF(SUBSTRING(C1,89,1), '') AS Q3
	, NULLIF(SUBSTRING(C1,90,1), '') AS Q4
	, NULLIF(SUBSTRING(C1,91,60), '') AS SignatureofResponsiblePart
	, NULLIF(SUBSTRING(C1,151,8), '') AS SignatureDate
	, NULLIF(SUBSTRING(C1,159,60), '') AS ResponsibleParty
	, NULLIF(SUBSTRING(C1,219,60), '') AS ParticipatingPharmacyorPSAOName
	, NULLIF(SUBSTRING(C1,279,55), '') AS Address1
	, NULLIF(SUBSTRING(C1,334,55), '') AS Address2
	, NULLIF(SUBSTRING(C1,389,30), '') AS City
	, NULLIF(SUBSTRING(C1,419,2), '') AS StateCode
	, NULLIF(SUBSTRING(C1,421,9), '') AS ZipCode
	, NULLIF(SUBSTRING(C1,430,10), '') AS NPI
	, NULLIF(SUBSTRING(C1,440,10), '') AS Fax
	, NULLIF(SUBSTRING(C1,450,50), '') AS Email	
FROM (SELECT MIN(RowID) AS MinRowID
	  , MAX(RowID) AS MaxRowID
	 FROM [ODSIntake].[Staging].[NCPDP_FraudWasteandAbuseTrainingAttestation]
	 ) AS dt
INNER JOIN [ODSIntake].[Staging].[NCPDP_FraudWasteandAbuseTrainingAttestation] AS s ON s.RowID > dt.MinRowID
													AND s.RowID < dt.MaxRowID

GO
