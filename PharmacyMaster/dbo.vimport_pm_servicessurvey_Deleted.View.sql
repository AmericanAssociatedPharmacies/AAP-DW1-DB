USE [PharmacyMaster]
GO
/****** Object:  View [dbo].[vimport_pm_servicessurvey_Deleted]    Script Date: 12/22/2020 7:35:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vimport_pm_servicessurvey_Deleted]
AS 
SELECT Col.*, CM.Created, CM.Modified, DD.Deleted FROM  (SELECT PrimaryKey
, 
 Max(Case ColumnName WHEN '[PMID] ' THEN LastValue ELSE '' END) AS [PMID], 
 Max(Case ColumnName WHEN '[NCPDP] ' THEN LastValue ELSE '' END) AS [NCPDP], 
 Max(Case ColumnName WHEN '[AccountName] ' THEN LastValue ELSE '' END) AS [AccountName], 
 Max(Case ColumnName WHEN '[DiabetesEducatorCertified] ' THEN LastValue ELSE '' END) AS [DiabetesEducatorCertified], 
 Max(Case ColumnName WHEN '[DiabetesEducatorNonCertified] ' THEN LastValue ELSE '' END) AS [DiabetesEducatorNonCertified], 
 Max(Case ColumnName WHEN '[HypertensionTesting] ' THEN LastValue ELSE '' END) AS [HypertensionTesting], 
 Max(Case ColumnName WHEN '[AsthmaServices] ' THEN LastValue ELSE '' END) AS [AsthmaServices], 
 Max(Case ColumnName WHEN '[CholesterolServices] ' THEN LastValue ELSE '' END) AS [CholesterolServices], 
 Max(Case ColumnName WHEN '[CompoundingLevel1thru3] ' THEN LastValue ELSE '' END) AS [CompoundingLevel1thru3], 
 Max(Case ColumnName WHEN '[CompoundingLevel4Sterile] ' THEN LastValue ELSE '' END) AS [CompoundingLevel4Sterile], 
 Max(Case ColumnName WHEN '[DMELight] ' THEN LastValue ELSE '' END) AS [DMELight], 
 Max(Case ColumnName WHEN '[DMEHeavy] ' THEN LastValue ELSE '' END) AS [DMEHeavy], 
 Max(Case ColumnName WHEN '[DMEAccreditedPharmacy] ' THEN LastValue ELSE '' END) AS [DMEAccreditedPharmacy], 
 Max(Case ColumnName WHEN '[Contracted340BSelfAdministered] ' THEN LastValue ELSE '' END) AS [Contracted340BSelfAdministered], 
 Max(Case ColumnName WHEN '[Contracted340BThirdPartyAdministered] ' THEN LastValue ELSE '' END) AS [Contracted340BThirdPartyAdministered], 
 Max(Case ColumnName WHEN '[Contracted340BExplain] ' THEN LastValue ELSE '' END) AS [Contracted340BExplain], 
 Max(Case ColumnName WHEN '[ImmunizationsFLUVaccines] ' THEN LastValue ELSE '' END) AS [ImmunizationsFLUVaccines], 
 Max(Case ColumnName WHEN '[ImmunizationsTravelVaccines] ' THEN LastValue ELSE '' END) AS [ImmunizationsTravelVaccines], 
 Max(Case ColumnName WHEN '[ImmunizationsOtherExplain] ' THEN LastValue ELSE '' END) AS [ImmunizationsOtherExplain], 
 Max(Case ColumnName WHEN '[WeightLossClinics] ' THEN LastValue ELSE '' END) AS [WeightLossClinics], 
 Max(Case ColumnName WHEN '[NutritionServices] ' THEN LastValue ELSE '' END) AS [NutritionServices], 
 Max(Case ColumnName WHEN '[OtherRetirementCommunities] ' THEN LastValue ELSE '' END) AS [OtherRetirementCommunities], 
 Max(Case ColumnName WHEN '[OtherAssistedLivingFacilities] ' THEN LastValue ELSE '' END) AS [OtherAssistedLivingFacilities], 
 Max(Case ColumnName WHEN '[OtherHospiceCenters] ' THEN LastValue ELSE '' END) AS [OtherHospiceCenters], 
 Max(Case ColumnName WHEN '[OtherSkilledNursingFacilities] ' THEN LastValue ELSE '' END) AS [OtherSkilledNursingFacilities], 
 Max(Case ColumnName WHEN '[DeliveryServicesNoCharge] ' THEN LastValue ELSE '' END) AS [DeliveryServicesNoCharge], 
 Max(Case ColumnName WHEN '[DeliveryServicesChargeFee] ' THEN LastValue ELSE '' END) AS [DeliveryServicesChargeFee]
  FROM (Select PrimaryKey, ColumnName, NewValue as LastValue from dbo.audit  
  		 Where Operation IN ('i', 'u') 
  				AND AuditID IN (
  					Select Max(AuditID)
  				  FROM dbo.audit a
  						JOIN (SELECT TableName, PrimaryKey FROM dbo.audit where operation = 'd' AND TableName = 'dbo.import_pm_servicessurvey') d
  						  on a.tablename = d.tablename and a.primarykey = d.primarykey
  					  GROUP BY a.TableName, a.PrimaryKey, a.ColumnName )) q
  GROUP BY PrimaryKey) Col
  JOIN 
  (SELECT a.TableName, a.PrimaryKey, Min(AuditDate) as Created, Max(AuditDate) as Modified
  			  FROM dbo.Audit a
  				JOIN (SELECT TableName, PrimaryKey FROM dbo.audit where operation = 'd' AND TableName = 'dbo.import_pm_servicessurvey') d
  					on a.tablename = d.tablename and a.primarykey = d.primarykey
  			  Where Operation IN ('i', 'u')
  			  GROUP BY a.TableName, a.PrimaryKey ) CM
  			ON Col.PrimaryKey = CM.PrimaryKey
      JOIN 
  		(SELECT PrimaryKey, AuditDate as Deleted 
              FROM dbo.audit 
              WHERE operation = 'd' 
              AND TableName = 'dbo.import_pm_servicessurvey') DD
  			ON Col.PrimaryKey = DD.PrimaryKey
GO
