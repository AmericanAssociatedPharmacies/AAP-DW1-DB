USE [PharmacyMaster]
GO
/****** Object:  View [dbo].[vpm_addressmaster_backup_Deleted]    Script Date: 12/22/2020 7:35:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vpm_addressmaster_backup_Deleted]
AS 
SELECT Col.*, CM.Created, CM.Modified, DD.Deleted FROM  (SELECT PrimaryKey
, 
 Max(Case ColumnName WHEN '[PK_AddressMaster] ' THEN LastValue ELSE '' END) AS [PK_AddressMaster], 
 Max(Case ColumnName WHEN '[PMID] ' THEN LastValue ELSE '' END) AS [PMID], 
 Max(Case ColumnName WHEN '[Address_Type_Id] ' THEN LastValue ELSE '' END) AS [Address_Type_Id], 
 Max(Case ColumnName WHEN '[Address] ' THEN LastValue ELSE '' END) AS [Address], 
 Max(Case ColumnName WHEN '[Address2] ' THEN LastValue ELSE '' END) AS [Address2], 
 Max(Case ColumnName WHEN '[City] ' THEN LastValue ELSE '' END) AS [City], 
 Max(Case ColumnName WHEN '[County] ' THEN LastValue ELSE '' END) AS [County], 
 Max(Case ColumnName WHEN '[State] ' THEN LastValue ELSE '' END) AS [State], 
 Max(Case ColumnName WHEN '[Zip] ' THEN LastValue ELSE '' END) AS [Zip], 
 Max(Case ColumnName WHEN '[ContactFullName] ' THEN LastValue ELSE '' END) AS [ContactFullName], 
 Max(Case ColumnName WHEN '[Fax] ' THEN LastValue ELSE '' END) AS [Fax], 
 Max(Case ColumnName WHEN '[Phone] ' THEN LastValue ELSE '' END) AS [Phone], 
 Max(Case ColumnName WHEN '[AlternatePhone] ' THEN LastValue ELSE '' END) AS [AlternatePhone], 
 Max(Case ColumnName WHEN '[Email] ' THEN LastValue ELSE '' END) AS [Email]
  FROM (Select PrimaryKey, ColumnName, NewValue as LastValue from dbo.audit  
  		 Where Operation IN ('i', 'u') 
  				AND AuditID IN (
  					Select Max(AuditID)
  				  FROM dbo.audit a
  						JOIN (SELECT TableName, PrimaryKey FROM dbo.audit where operation = 'd' AND TableName = 'dbo.pm_addressmaster_backup') d
  						  on a.tablename = d.tablename and a.primarykey = d.primarykey
  					  GROUP BY a.TableName, a.PrimaryKey, a.ColumnName )) q
  GROUP BY PrimaryKey) Col
  JOIN 
  (SELECT a.TableName, a.PrimaryKey, Min(AuditDate) as Created, Max(AuditDate) as Modified
  			  FROM dbo.Audit a
  				JOIN (SELECT TableName, PrimaryKey FROM dbo.audit where operation = 'd' AND TableName = 'dbo.pm_addressmaster_backup') d
  					on a.tablename = d.tablename and a.primarykey = d.primarykey
  			  Where Operation IN ('i', 'u')
  			  GROUP BY a.TableName, a.PrimaryKey ) CM
  			ON Col.PrimaryKey = CM.PrimaryKey
      JOIN 
  		(SELECT PrimaryKey, AuditDate as Deleted 
              FROM dbo.audit 
              WHERE operation = 'd' 
              AND TableName = 'dbo.pm_addressmaster_backup') DD
  			ON Col.PrimaryKey = DD.PrimaryKey
GO
