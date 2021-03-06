USE [PharmacyMaster]
GO
/****** Object:  View [dbo].[vPP_volRebate_Deleted]    Script Date: 12/22/2020 7:35:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vPP_volRebate_Deleted]
AS 
SELECT Col.*, CM.Created, CM.Modified, DD.Deleted FROM  (SELECT PrimaryKey
, 
 Max(Case ColumnName WHEN '[acct_no] ' THEN LastValue ELSE '' END) AS [acct_no], 
 Max(Case ColumnName WHEN '[dt] ' THEN LastValue ELSE '' END) AS [dt], 
 Max(Case ColumnName WHEN '[old_vendor_id] ' THEN LastValue ELSE '' END) AS [old_vendor_id], 
 Max(Case ColumnName WHEN '[vendor] ' THEN LastValue ELSE '' END) AS [vendor], 
 Max(Case ColumnName WHEN '[reports] ' THEN LastValue ELSE '' END) AS [reports], 
 Max(Case ColumnName WHEN '[volume] ' THEN LastValue ELSE '' END) AS [volume], 
 Max(Case ColumnName WHEN '[PMID] ' THEN LastValue ELSE '' END) AS [PMID], 
 Max(Case ColumnName WHEN '[rebate] ' THEN LastValue ELSE '' END) AS [rebate], 
 Max(Case ColumnName WHEN '[vendorID] ' THEN LastValue ELSE '' END) AS [vendorID]
  FROM (Select PrimaryKey, ColumnName, NewValue as LastValue from dbo.audit  
  		 Where Operation IN ('i', 'u') 
  				AND AuditID IN (
  					Select Max(AuditID)
  				  FROM dbo.audit a
  						JOIN (SELECT TableName, PrimaryKey FROM dbo.audit where operation = 'd' AND TableName = 'dbo.PP_volRebate') d
  						  on a.tablename = d.tablename and a.primarykey = d.primarykey
  					  GROUP BY a.TableName, a.PrimaryKey, a.ColumnName )) q
  GROUP BY PrimaryKey) Col
  JOIN 
  (SELECT a.TableName, a.PrimaryKey, Min(AuditDate) as Created, Max(AuditDate) as Modified
  			  FROM dbo.Audit a
  				JOIN (SELECT TableName, PrimaryKey FROM dbo.audit where operation = 'd' AND TableName = 'dbo.PP_volRebate') d
  					on a.tablename = d.tablename and a.primarykey = d.primarykey
  			  Where Operation IN ('i', 'u')
  			  GROUP BY a.TableName, a.PrimaryKey ) CM
  			ON Col.PrimaryKey = CM.PrimaryKey
      JOIN 
  		(SELECT PrimaryKey, AuditDate as Deleted 
              FROM dbo.audit 
              WHERE operation = 'd' 
              AND TableName = 'dbo.PP_volRebate') DD
  			ON Col.PrimaryKey = DD.PrimaryKey
GO
