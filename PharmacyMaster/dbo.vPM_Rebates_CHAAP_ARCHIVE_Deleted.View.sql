USE [PharmacyMaster]
GO
/****** Object:  View [dbo].[vPM_Rebates_CHAAP_ARCHIVE_Deleted]    Script Date: 12/22/2020 7:35:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vPM_Rebates_CHAAP_ARCHIVE_Deleted]
AS 
SELECT Col.*, CM.Created, CM.Modified, DD.Deleted FROM  (SELECT PrimaryKey
, 
 Max(Case ColumnName WHEN '[PMID] ' THEN LastValue ELSE '' END) AS [PMID], 
 Max(Case ColumnName WHEN '[date] ' THEN LastValue ELSE '' END) AS [date], 
 Max(Case ColumnName WHEN '[date_period_start] ' THEN LastValue ELSE '' END) AS [date_period_start], 
 Max(Case ColumnName WHEN '[date_period_end] ' THEN LastValue ELSE '' END) AS [date_period_end], 
 Max(Case ColumnName WHEN '[rebate_type] ' THEN LastValue ELSE '' END) AS [rebate_type], 
 Max(Case ColumnName WHEN '[ExtendedSales] ' THEN LastValue ELSE '' END) AS [ExtendedSales], 
 Max(Case ColumnName WHEN '[SourceSales] ' THEN LastValue ELSE '' END) AS [SourceSales], 
 Max(Case ColumnName WHEN '[AAPVolumeAdminFee] ' THEN LastValue ELSE '' END) AS [AAPVolumeAdminFee], 
 Max(Case ColumnName WHEN '[AAPGenericAdminFee] ' THEN LastValue ELSE '' END) AS [AAPGenericAdminFee], 
 Max(Case ColumnName WHEN '[GenericRebate] ' THEN LastValue ELSE '' END) AS [GenericRebate], 
 Max(Case ColumnName WHEN '[LeaderRebate] ' THEN LastValue ELSE '' END) AS [LeaderRebate], 
 Max(Case ColumnName WHEN '[Pay to store] ' THEN LastValue ELSE '' END) AS [Pay to store], 
 Max(Case ColumnName WHEN '[Pay to Affiliate Office] ' THEN LastValue ELSE '' END) AS [Pay to Affiliate Office], 
 Max(Case ColumnName WHEN '[EffectivePct] ' THEN LastValue ELSE '' END) AS [EffectivePct], 
 Max(Case ColumnName WHEN '[HRTA] ' THEN LastValue ELSE '' END) AS [HRTA], 
 Max(Case ColumnName WHEN '[AAPVolumeAdminFeeAffiliate] ' THEN LastValue ELSE '' END) AS [AAPVolumeAdminFeeAffiliate], 
 Max(Case ColumnName WHEN '[AAPGenericAdminFeePipco] ' THEN LastValue ELSE '' END) AS [AAPGenericAdminFeePipco]
  FROM (Select PrimaryKey, ColumnName, NewValue as LastValue from dbo.audit  
  		 Where Operation IN ('i', 'u') 
  				AND AuditID IN (
  					Select Max(AuditID)
  				  FROM dbo.audit a
  						JOIN (SELECT TableName, PrimaryKey FROM dbo.audit where operation = 'd' AND TableName = 'dbo.PM_Rebates_CHAAP_ARCHIVE') d
  						  on a.tablename = d.tablename and a.primarykey = d.primarykey
  					  GROUP BY a.TableName, a.PrimaryKey, a.ColumnName )) q
  GROUP BY PrimaryKey) Col
  JOIN 
  (SELECT a.TableName, a.PrimaryKey, Min(AuditDate) as Created, Max(AuditDate) as Modified
  			  FROM dbo.Audit a
  				JOIN (SELECT TableName, PrimaryKey FROM dbo.audit where operation = 'd' AND TableName = 'dbo.PM_Rebates_CHAAP_ARCHIVE') d
  					on a.tablename = d.tablename and a.primarykey = d.primarykey
  			  Where Operation IN ('i', 'u')
  			  GROUP BY a.TableName, a.PrimaryKey ) CM
  			ON Col.PrimaryKey = CM.PrimaryKey
      JOIN 
  		(SELECT PrimaryKey, AuditDate as Deleted 
              FROM dbo.audit 
              WHERE operation = 'd' 
              AND TableName = 'dbo.PM_Rebates_CHAAP_ARCHIVE') DD
  			ON Col.PrimaryKey = DD.PrimaryKey
GO
