USE [PharmacyMaster]
GO
/****** Object:  View [dbo].[vtmp_globalreport_Q2_Deleted]    Script Date: 12/22/2020 7:35:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vtmp_globalreport_Q2_Deleted]
AS 
SELECT Col.*, CM.Created, CM.Modified, DD.Deleted FROM  (SELECT PrimaryKey
, 
 Max(Case ColumnName WHEN '[PMID] ' THEN LastValue ELSE '' END) AS [PMID], 
 Max(Case ColumnName WHEN '[AAP #] ' THEN LastValue ELSE '' END) AS [AAP #], 
 Max(Case ColumnName WHEN '[Parent #] ' THEN LastValue ELSE '' END) AS [Parent #], 
 Max(Case ColumnName WHEN '[Account Name] ' THEN LastValue ELSE '' END) AS [Account Name], 
 Max(Case ColumnName WHEN '[City] ' THEN LastValue ELSE '' END) AS [City], 
 Max(Case ColumnName WHEN '[St] ' THEN LastValue ELSE '' END) AS [St], 
 Max(Case ColumnName WHEN '[TM] ' THEN LastValue ELSE '' END) AS [TM], 
 Max(Case ColumnName WHEN '[DEA] ' THEN LastValue ELSE '' END) AS [DEA], 
 Max(Case ColumnName WHEN '[Affiliate] ' THEN LastValue ELSE '' END) AS [Affiliate], 
 Max(Case ColumnName WHEN '[BC] ' THEN LastValue ELSE '' END) AS [BC], 
 Max(Case ColumnName WHEN '[Period] ' THEN LastValue ELSE '' END) AS [Period], 
 Max(Case ColumnName WHEN '[Gen Src] ' THEN LastValue ELSE '' END) AS [Gen Src], 
 Max(Case ColumnName WHEN '[Gen Exc] ' THEN LastValue ELSE '' END) AS [Gen Exc], 
 Max(Case ColumnName WHEN '[Gen Total] ' THEN LastValue ELSE '' END) AS [Gen Total], 
 Max(Case ColumnName WHEN '[CH Br] ' THEN LastValue ELSE '' END) AS [CH Br], 
 Max(Case ColumnName WHEN '[CH Oth] ' THEN LastValue ELSE '' END) AS [CH Oth], 
 Max(Case ColumnName WHEN '[UD No Category*] ' THEN LastValue ELSE '' END) AS [UD No Category*], 
 Max(Case ColumnName WHEN '[CH Total] ' THEN LastValue ELSE '' END) AS [CH Total], 
 Max(Case ColumnName WHEN '[API Gen] ' THEN LastValue ELSE '' END) AS [API Gen], 
 Max(Case ColumnName WHEN '[API Br] ' THEN LastValue ELSE '' END) AS [API Br], 
 Max(Case ColumnName WHEN '[API OTC] ' THEN LastValue ELSE '' END) AS [API OTC], 
 Max(Case ColumnName WHEN '[API Total] ' THEN LastValue ELSE '' END) AS [API Total], 
 Max(Case ColumnName WHEN '[ML Total] ' THEN LastValue ELSE '' END) AS [ML Total], 
 Max(Case ColumnName WHEN '[Anda Total] ' THEN LastValue ELSE '' END) AS [Anda Total], 
 Max(Case ColumnName WHEN '[All Total] ' THEN LastValue ELSE '' END) AS [All Total]
  FROM (Select PrimaryKey, ColumnName, NewValue as LastValue from dbo.audit  
  		 Where Operation IN ('i', 'u') 
  				AND AuditID IN (
  					Select Max(AuditID)
  				  FROM dbo.audit a
  						JOIN (SELECT TableName, PrimaryKey FROM dbo.audit where operation = 'd' AND TableName = 'dbo.tmp_globalreport_Q2') d
  						  on a.tablename = d.tablename and a.primarykey = d.primarykey
  					  GROUP BY a.TableName, a.PrimaryKey, a.ColumnName )) q
  GROUP BY PrimaryKey) Col
  JOIN 
  (SELECT a.TableName, a.PrimaryKey, Min(AuditDate) as Created, Max(AuditDate) as Modified
  			  FROM dbo.Audit a
  				JOIN (SELECT TableName, PrimaryKey FROM dbo.audit where operation = 'd' AND TableName = 'dbo.tmp_globalreport_Q2') d
  					on a.tablename = d.tablename and a.primarykey = d.primarykey
  			  Where Operation IN ('i', 'u')
  			  GROUP BY a.TableName, a.PrimaryKey ) CM
  			ON Col.PrimaryKey = CM.PrimaryKey
      JOIN 
  		(SELECT PrimaryKey, AuditDate as Deleted 
              FROM dbo.audit 
              WHERE operation = 'd' 
              AND TableName = 'dbo.tmp_globalreport_Q2') DD
  			ON Col.PrimaryKey = DD.PrimaryKey
GO
