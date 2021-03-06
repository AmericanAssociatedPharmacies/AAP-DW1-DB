USE [NCPDPODS]
GO
/****** Object:  StoredProcedure [dbo].[usp_FraudWasteandAbuseTrainingAttestation_Load]    Script Date: 12/22/2020 7:25:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[usp_FraudWasteandAbuseTrainingAttestation_Load]

AS

SET NOCOUNT ON;

BEGIN

	MERGE [dbo].[FraudWasteandAbuseTrainingAttestation] AS T
	USING (SELECT [NCPDPProviderID], [MedicaidID], [FWAattestation], [VersionNumber], [PlanYear], [Q1], [Q2], [AccreditationDate], [AccreditationOrganization], [Q3], [Q4], [SignatureofResponsiblePart]
				, [SignatureDate], [ResponsibleParty], [ParticipatingPharmacyorPSAOName], [Address1], [Address2], [City], [StateCode], [ZipCode], [NPI], [Fax], [Email]
		   FROM [Staging].[vw_NCPDP_FraudWasteandAbuseTrainingAttestation]
		  ) AS S
				([NCPDPProviderID], [MedicaidID], [FWAattestation], [VersionNumber], [PlanYear], [Q1], [Q2], [AccreditationDate], [AccreditationOrganization], [Q3], [Q4], [SignatureofResponsiblePart]
			   , [SignatureDate], [ResponsibleParty], [ParticipatingPharmacyorPSAOName], [Address1], [Address2], [City], [StateCode], [ZipCode], [NPI], [Fax], [Email])
		  ON T.NCPDPProviderID = S.NCPDPProviderID
		  AND t.PlanYear = s.PlanYear

WHEN MATCHED THEN

UPDATE SET [MedicaidID] = S.[MedicaidID]
		 , [FWAattestation] = S.[FWAattestation]
		 , [VersionNumber] = S.[VersionNumber]
		 --, [PlanYear] = S.[PlanYear]
		 , [Q1] = S.[Q1]
		 , [Q2] = S.[Q2]
		 , [SignatureofResponsiblePart] = S. [SignatureofResponsiblePart]
		 , [SignatureDate] = S.[SignatureDate]
		 , [ResponsibleParty] = S.[ResponsibleParty]
		 , [ParticipatingPharmacyorPSAOName] = S.[ParticipatingPharmacyorPSAOName]
		 , [Address1] = S.[Address1]
		 , [Address2] = S.[Address2]
		 , [City] = S.[City]
		 , [StateCode] = S.[StateCode]
		 , [ZipCode] = S.[ZipCode]
		 , [NPI] = S.[NPI]
		 , [Fax] = S.[Fax]
		 , [Email] = S.[Email]

WHEN NOT MATCHED THEN
		INSERT ([NCPDPProviderID], [MedicaidID], [FWAattestation], [VersionNumber], [PlanYear], [Q1], [Q2], [AccreditationDate], [AccreditationOrganization], [Q3], [Q4], [SignatureofResponsiblePart], 
				[SignatureDate], [ResponsibleParty], [ParticipatingPharmacyorPSAOName], [Address1], [Address2], [City], [StateCode], [ZipCode], [NPI], [Fax], [Email])
		VALUES (S.[NCPDPProviderID], S.[MedicaidID], S.[FWAattestation], S.[VersionNumber], S.[PlanYear], S.[Q1], S.[Q2], S.[AccreditationDate], S.[AccreditationOrganization], S.[Q3], S.[Q4]
			  , S.[SignatureofResponsiblePart], S.[SignatureDate], S.[ResponsibleParty], S.[ParticipatingPharmacyorPSAOName], S.[Address1], S.[Address2], S.[City], S.[StateCode], S.[ZipCode], S.[NPI]
			  , S.[Fax], S.[Email]);
END
GO
