USE [PharmacyMaster]
GO
/****** Object:  View [dbo].[vpm_rebates_HighVolume_bkp111611_Deleted]    Script Date: 12/22/2020 7:35:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vpm_rebates_HighVolume_bkp111611_Deleted]
AS 
SELECT Col.*, CM.Created, CM.Modified, DD.Deleted FROM  (SELECT PrimaryKey
, 
 Max(Case ColumnName WHEN '[date] ' THEN LastValue ELSE '' END) AS [date], 
 Max(Case ColumnName WHEN '[rebate_type] ' THEN LastValue ELSE '' END) AS [rebate_type], 
 Max(Case ColumnName WHEN '[PMID] ' THEN LastValue ELSE '' END) AS [PMID], 
 Max(Case ColumnName WHEN '[AAP#] ' THEN LastValue ELSE '' END) AS [AAP#], 
 Max(Case ColumnName WHEN '[API acct] ' THEN LastValue ELSE '' END) AS [API acct], 
 Max(Case ColumnName WHEN '[Customer Name] ' THEN LastValue ELSE '' END) AS [Customer Name], 
 Max(Case ColumnName WHEN '[City] ' THEN LastValue ELSE '' END) AS [City], 
 Max(Case ColumnName WHEN '[ST] ' THEN LastValue ELSE '' END) AS [ST], 
 Max(Case ColumnName WHEN '[Bs Class] ' THEN LastValue ELSE '' END) AS [Bs Class], 
 Max(Case ColumnName WHEN '[Month] ' THEN LastValue ELSE '' END) AS [Month], 
 Max(Case ColumnName WHEN '[Current Est Mo Sales] ' THEN LastValue ELSE '' END) AS [Current Est Mo Sales], 
 Max(Case ColumnName WHEN '[Mo API Volume] ' THEN LastValue ELSE '' END) AS [Mo API Volume], 
 Max(Case ColumnName WHEN '[CAH off Contract-LTC Volume] ' THEN LastValue ELSE '' END) AS [CAH off Contract-LTC Volume], 
 Max(Case ColumnName WHEN '[AAP Net Sales] ' THEN LastValue ELSE '' END) AS [AAP Net Sales], 
 Max(Case ColumnName WHEN '[Mo Comb Volume] ' THEN LastValue ELSE '' END) AS [Mo Comb Volume], 
 Max(Case ColumnName WHEN '[AAP Sales- COG Applied] ' THEN LastValue ELSE '' END) AS [AAP Sales- COG Applied], 
 Max(Case ColumnName WHEN '[AAP Brand RX Sales] ' THEN LastValue ELSE '' END) AS [AAP Brand RX Sales], 
 Max(Case ColumnName WHEN '[Current CA COG] ' THEN LastValue ELSE '' END) AS [Current CA COG], 
 Max(Case ColumnName WHEN '[Base] ' THEN LastValue ELSE '' END) AS [Base], 
 Max(Case ColumnName WHEN '[Brand RX@WAC] ' THEN LastValue ELSE '' END) AS [Brand RX@WAC], 
 Max(Case ColumnName WHEN '[Brand RX Saved] ' THEN LastValue ELSE '' END) AS [Brand RX Saved], 
 Max(Case ColumnName WHEN '[High Volume Incentive] ' THEN LastValue ELSE '' END) AS [High Volume Incentive], 
 Max(Case ColumnName WHEN '[Total Saved] ' THEN LastValue ELSE '' END) AS [Total Saved], 
 Max(Case ColumnName WHEN '[ECOG] ' THEN LastValue ELSE '' END) AS [ECOG], 
 Max(Case ColumnName WHEN '[COG Reduction] ' THEN LastValue ELSE '' END) AS [COG Reduction]
  FROM (Select PrimaryKey, ColumnName, NewValue as LastValue from dbo.audit  
  		 Where Operation IN ('i', 'u') 
  				AND AuditID IN (
  					Select Max(AuditID)
  				  FROM dbo.audit a
  						JOIN (SELECT TableName, PrimaryKey FROM dbo.audit where operation = 'd' AND TableName = 'dbo.pm_rebates_HighVolume_bkp111611') d
  						  on a.tablename = d.tablename and a.primarykey = d.primarykey
  					  GROUP BY a.TableName, a.PrimaryKey, a.ColumnName )) q
  GROUP BY PrimaryKey) Col
  JOIN 
  (SELECT a.TableName, a.PrimaryKey, Min(AuditDate) as Created, Max(AuditDate) as Modified
  			  FROM dbo.Audit a
  				JOIN (SELECT TableName, PrimaryKey FROM dbo.audit where operation = 'd' AND TableName = 'dbo.pm_rebates_HighVolume_bkp111611') d
  					on a.tablename = d.tablename and a.primarykey = d.primarykey
  			  Where Operation IN ('i', 'u')
  			  GROUP BY a.TableName, a.PrimaryKey ) CM
  			ON Col.PrimaryKey = CM.PrimaryKey
      JOIN 
  		(SELECT PrimaryKey, AuditDate as Deleted 
              FROM dbo.audit 
              WHERE operation = 'd' 
              AND TableName = 'dbo.pm_rebates_HighVolume_bkp111611') DD
  			ON Col.PrimaryKey = DD.PrimaryKey
GO
