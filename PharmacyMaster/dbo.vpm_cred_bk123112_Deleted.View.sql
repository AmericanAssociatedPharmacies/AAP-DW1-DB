USE [PharmacyMaster]
GO
/****** Object:  View [dbo].[vpm_cred_bk123112_Deleted]    Script Date: 12/22/2020 7:35:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vpm_cred_bk123112_Deleted]
AS 
SELECT Col.*, CM.Created, CM.Modified, DD.Deleted FROM  (SELECT PrimaryKey
, 
 Max(Case ColumnName WHEN '[PK_Cred] ' THEN LastValue ELSE '' END) AS [PK_Cred], 
 Max(Case ColumnName WHEN '[PMID] ' THEN LastValue ELSE '' END) AS [PMID], 
 Max(Case ColumnName WHEN '[StateLicNo] ' THEN LastValue ELSE '' END) AS [StateLicNo], 
 Max(Case ColumnName WHEN '[StateMedicaidNo] ' THEN LastValue ELSE '' END) AS [StateMedicaidNo], 
 Max(Case ColumnName WHEN '[StateLicExpDate] ' THEN LastValue ELSE '' END) AS [StateLicExpDate], 
 Max(Case ColumnName WHEN '[StateLicNo2] ' THEN LastValue ELSE '' END) AS [StateLicNo2], 
 Max(Case ColumnName WHEN '[StateMedicaidNo2] ' THEN LastValue ELSE '' END) AS [StateMedicaidNo2], 
 Max(Case ColumnName WHEN '[StateLicExpDate2] ' THEN LastValue ELSE '' END) AS [StateLicExpDate2], 
 Max(Case ColumnName WHEN '[GenLiabCarrier] ' THEN LastValue ELSE '' END) AS [GenLiabCarrier], 
 Max(Case ColumnName WHEN '[GenLiabPolicyNumber] ' THEN LastValue ELSE '' END) AS [GenLiabPolicyNumber], 
 Max(Case ColumnName WHEN '[GenLiabilityLimit1] ' THEN LastValue ELSE '' END) AS [GenLiabilityLimit1], 
 Max(Case ColumnName WHEN '[GenLiabilityLimit2] ' THEN LastValue ELSE '' END) AS [GenLiabilityLimit2], 
 Max(Case ColumnName WHEN '[GenInsExpDate] ' THEN LastValue ELSE '' END) AS [GenInsExpDate], 
 Max(Case ColumnName WHEN '[ProfLiabCarrier] ' THEN LastValue ELSE '' END) AS [ProfLiabCarrier], 
 Max(Case ColumnName WHEN '[ProfLiabInsExpDate] ' THEN LastValue ELSE '' END) AS [ProfLiabInsExpDate], 
 Max(Case ColumnName WHEN '[ProfPolicyNumber] ' THEN LastValue ELSE '' END) AS [ProfPolicyNumber], 
 Max(Case ColumnName WHEN '[ProfLiabLimit1] ' THEN LastValue ELSE '' END) AS [ProfLiabLimit1], 
 Max(Case ColumnName WHEN '[ProfLiabLimit2] ' THEN LastValue ELSE '' END) AS [ProfLiabLimit2], 
 Max(Case ColumnName WHEN '[DeliveryService] ' THEN LastValue ELSE '' END) AS [DeliveryService], 
 Max(Case ColumnName WHEN '[EmergencyServices] ' THEN LastValue ELSE '' END) AS [EmergencyServices], 
 Max(Case ColumnName WHEN '[AnsweringServiceOrMachine] ' THEN LastValue ELSE '' END) AS [AnsweringServiceOrMachine], 
 Max(Case ColumnName WHEN '[AlternativeLanguages] ' THEN LastValue ELSE '' END) AS [AlternativeLanguages], 
 Max(Case ColumnName WHEN '[SpecialtyServices] ' THEN LastValue ELSE '' END) AS [SpecialtyServices], 
 Max(Case ColumnName WHEN '[Obra90] ' THEN LastValue ELSE '' END) AS [Obra90], 
 Max(Case ColumnName WHEN '[CounselingArea] ' THEN LastValue ELSE '' END) AS [CounselingArea], 
 Max(Case ColumnName WHEN '[PatientMR] ' THEN LastValue ELSE '' END) AS [PatientMR], 
 Max(Case ColumnName WHEN '[DrugInformation] ' THEN LastValue ELSE '' END) AS [DrugInformation], 
 Max(Case ColumnName WHEN '[FraudFelonyConviction] ' THEN LastValue ELSE '' END) AS [FraudFelonyConviction], 
 Max(Case ColumnName WHEN '[FraudFelonyExplanation] ' THEN LastValue ELSE '' END) AS [FraudFelonyExplanation], 
 Max(Case ColumnName WHEN '[RxLicenseSuspendedOrRevoked] ' THEN LastValue ELSE '' END) AS [RxLicenseSuspendedOrRevoked], 
 Max(Case ColumnName WHEN '[SuspensionRevokationExplanation] ' THEN LastValue ELSE '' END) AS [SuspensionRevokationExplanation], 
 Max(Case ColumnName WHEN '[UnrestrictedLicense] ' THEN LastValue ELSE '' END) AS [UnrestrictedLicense], 
 Max(Case ColumnName WHEN '[UnrestrictedLicenseExplanation] ' THEN LastValue ELSE '' END) AS [UnrestrictedLicenseExplanation], 
 Max(Case ColumnName WHEN '[InvestigatedByMedicareMedicaid] ' THEN LastValue ELSE '' END) AS [InvestigatedByMedicareMedicaid], 
 Max(Case ColumnName WHEN '[UAICoverage] ' THEN LastValue ELSE '' END) AS [UAICoverage], 
 Max(Case ColumnName WHEN '[Judgements] ' THEN LastValue ELSE '' END) AS [Judgements], 
 Max(Case ColumnName WHEN '[CompliesWithADAAct] ' THEN LastValue ELSE '' END) AS [CompliesWithADAAct], 
 Max(Case ColumnName WHEN '[AverageWaitTime] ' THEN LastValue ELSE '' END) AS [AverageWaitTime], 
 Max(Case ColumnName WHEN '[MedicationErrorsDocumented] ' THEN LastValue ELSE '' END) AS [MedicationErrorsDocumented], 
 Max(Case ColumnName WHEN '[ErrorCount12Months] ' THEN LastValue ELSE '' END) AS [ErrorCount12Months], 
 Max(Case ColumnName WHEN '[HasResolutionPolicy] ' THEN LastValue ELSE '' END) AS [HasResolutionPolicy], 
 Max(Case ColumnName WHEN '[doesCompoundPrescriptions] ' THEN LastValue ELSE '' END) AS [doesCompoundPrescriptions], 
 Max(Case ColumnName WHEN '[UnitDosing] ' THEN LastValue ELSE '' END) AS [UnitDosing], 
 Max(Case ColumnName WHEN '[ProvidesDME] ' THEN LastValue ELSE '' END) AS [ProvidesDME], 
 Max(Case ColumnName WHEN '[ProvidesIV] ' THEN LastValue ELSE '' END) AS [ProvidesIV], 
 Max(Case ColumnName WHEN '[CertifiedDiseaseMgmt] ' THEN LastValue ELSE '' END) AS [CertifiedDiseaseMgmt], 
 Max(Case ColumnName WHEN '[CDMExplanation] ' THEN LastValue ELSE '' END) AS [CDMExplanation], 
 Max(Case ColumnName WHEN '[GroupPresentations] ' THEN LastValue ELSE '' END) AS [GroupPresentations], 
 Max(Case ColumnName WHEN '[ContinuingEducationRequired] ' THEN LastValue ELSE '' END) AS [ContinuingEducationRequired], 
 Max(Case ColumnName WHEN '[StoreSizeClassification] ' THEN LastValue ELSE '' END) AS [StoreSizeClassification], 
 Max(Case ColumnName WHEN '[CopyReleaseInfo] ' THEN LastValue ELSE '' END) AS [CopyReleaseInfo]
  FROM (Select PrimaryKey, ColumnName, NewValue as LastValue from dbo.audit  
  		 Where Operation IN ('i', 'u') 
  				AND AuditID IN (
  					Select Max(AuditID)
  				  FROM dbo.audit a
  						JOIN (SELECT TableName, PrimaryKey FROM dbo.audit where operation = 'd' AND TableName = 'dbo.pm_cred_bk123112') d
  						  on a.tablename = d.tablename and a.primarykey = d.primarykey
  					  GROUP BY a.TableName, a.PrimaryKey, a.ColumnName )) q
  GROUP BY PrimaryKey) Col
  JOIN 
  (SELECT a.TableName, a.PrimaryKey, Min(AuditDate) as Created, Max(AuditDate) as Modified
  			  FROM dbo.Audit a
  				JOIN (SELECT TableName, PrimaryKey FROM dbo.audit where operation = 'd' AND TableName = 'dbo.pm_cred_bk123112') d
  					on a.tablename = d.tablename and a.primarykey = d.primarykey
  			  Where Operation IN ('i', 'u')
  			  GROUP BY a.TableName, a.PrimaryKey ) CM
  			ON Col.PrimaryKey = CM.PrimaryKey
      JOIN 
  		(SELECT PrimaryKey, AuditDate as Deleted 
              FROM dbo.audit 
              WHERE operation = 'd' 
              AND TableName = 'dbo.pm_cred_bk123112') DD
  			ON Col.PrimaryKey = DD.PrimaryKey
GO
