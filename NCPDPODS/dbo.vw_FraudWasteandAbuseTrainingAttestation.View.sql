USE [NCPDPODS]
GO
/****** Object:  View [dbo].[vw_FraudWasteandAbuseTrainingAttestation]    Script Date: 12/22/2020 7:25:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vw_FraudWasteandAbuseTrainingAttestation]

AS


SELECT FraudKey, NCPDPProviderID, MedicaidID, FWAattestation, VersionNumber, PlanYear, Q1, Q2, AccreditationDate, AccreditationOrganization, Q3, Q4
, SignatureofResponsiblePart 
, CONVERT(DATE, CASE
					WHEN SignatureDate = '00000000' THEN '19000101'
					ELSE RIGHT(SignatureDate, 4) + LEFT(SignatureDate, 2) +  SUBSTRING(SignatureDate,3,2)
					END)
					 AS SignatureDate, ResponsibleParty
, ParticipatingPharmacyorPSAOName, Address1, Address2, City
, StateCode, ZipCode, NPI, Fax, Email, RowCreatedDate
FROM [dbo].[FraudWasteandAbuseTrainingAttestation]

GO
